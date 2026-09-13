# ============================================================
# Timer
# ============================================================
#
# Usage:
#
#   timer 25
#   timer 25 "Break time"
#   timer 30s "Tea"
#   timer 25m "Pomodoro"
#   timer 1h "Meeting"
#   timer 1h30m "Laundry"
#
#   timer
#   timer stop
#   timer stop 2
#   timer stop all
#
# TIMER_SOUND:
#
#   true  = macOS notification + sound
#   false = macOS notification only
#

: ${TIMER_SOUND:=true}

TIMER_STATE_DIR="${XDG_STATE_HOME:-$HOME/.local/state}/timer"


# ------------------------------------------------------------
# Parse duration
#
# Supported:
#
#   25       -> 25 minutes
#   0.5      -> 30 seconds
#   30s
#   25m
#   1h
#   1h30m
#   2h15m30s
# ------------------------------------------------------------

_timer_parse_duration() {
    local input="$1"

    awk -v d="$input" '
        BEGIN {
            # Plain number = minutes
            if (d ~ /^[0-9]+([.][0-9]+)?$/) {
                seconds = d * 60

                if (seconds < 1)
                    exit 1

                printf "%.0f", seconds
                exit
            }

            # h / m / s format
            if (d !~ /^([0-9]+h)?([0-9]+m)?([0-9]+s)?$/ || d == "")
                exit 1

            total = 0

            if (match(d, /^[0-9]+h/)) {
                value = substr(d, RSTART, RLENGTH - 1)
                total += value * 3600
                d = substr(d, RLENGTH + 1)
            }

            if (match(d, /^[0-9]+m/)) {
                value = substr(d, RSTART, RLENGTH - 1)
                total += value * 60
                d = substr(d, RLENGTH + 1)
            }

            if (match(d, /^[0-9]+s/)) {
                value = substr(d, RSTART, RLENGTH - 1)
                total += value
                d = substr(d, RLENGTH + 1)
            }

            if (total < 1)
                exit 1

            printf "%d", total
        }
    '
}


# ------------------------------------------------------------
# Format seconds
#
# 65    -> 01:05
# 3665  -> 1:01:05
# ------------------------------------------------------------

_timer_format_time() {
    local seconds="$1"

    (( seconds < 0 )) && seconds=0

    local hours=$((seconds / 3600))
    local minutes=$(((seconds % 3600) / 60))
    local secs=$((seconds % 60))

    if (( hours > 0 )); then
        printf "%d:%02d:%02d" \
            "$hours" \
            "$minutes" \
            "$secs"
    else
        printf "%02d:%02d" \
            "$minutes" \
            "$secs"
    fi
}


# ------------------------------------------------------------
# Remove stale timer states
# ------------------------------------------------------------

_timer_cleanup() {
    setopt local_options numeric_glob_sort

    mkdir -p "$TIMER_STATE_DIR"

    local now
    now=$(date +%s)

    local dir
    local pid
    local end

    for dir in "$TIMER_STATE_DIR"/*(/N); do

        # Broken/incomplete state
        if [[ ! -f "$dir/end" ]]; then
            /bin/rm -rf -- "$dir"
            continue
        fi

        end=$(<"$dir/end")

        # Already expired
        if (( end <= now )); then
            /bin/rm -rf -- "$dir"
            continue
        fi

        # Worker no longer exists
        if [[ -f "$dir/pid" ]]; then
            pid=$(<"$dir/pid")

            if ! kill -0 "$pid" 2>/dev/null; then
                /bin/rm -rf -- "$dir"
            fi
        fi
    done
}


# ------------------------------------------------------------
# Get next timer ID
# ------------------------------------------------------------

_timer_next_id() {
    local id=1

    while [[ -d "$TIMER_STATE_DIR/$id" ]]; do
        (( id++ ))
    done

    printf "%d" "$id"
}


# ------------------------------------------------------------
# Show active timers
# ------------------------------------------------------------

_timer_show() {
    setopt local_options numeric_glob_sort

    _timer_cleanup

    local -a dirs
    dirs=("$TIMER_STATE_DIR"/*(/N))

    if (( ${#dirs[@]} == 0 )); then
        echo "No active timers."
        return 0
    fi

    local now
    now=$(date +%s)

    printf "%-4s %-10s %s\n" \
        "ID" \
        "Remaining" \
        "Message"

    local dir
    local id
    local end
    local remaining
    local message
    local formatted

    for dir in "${dirs[@]}"; do
        id="${dir:t}"
        end=$(<"$dir/end")

        remaining=$((end - now))

        message="Time is up!"

        if [[ -f "$dir/message" ]]; then
            message=$(<"$dir/message")
        fi

        # Keep table on one line
        message="${message//$'\n'/ }"

        formatted=$(_timer_format_time "$remaining")

        printf "%-4s %-10s %s\n" \
            "$id" \
            "$formatted" \
            "$message"
    done
}


# ------------------------------------------------------------
# Stop a specific timer
#
# $1 = ID
# $2 = quiet (true / false)
# ------------------------------------------------------------

_timer_stop_id() {
    local id="$1"
    local quiet="${2:-false}"

    local dir="$TIMER_STATE_DIR/$id"

    if [[ ! "$id" =~ '^[0-9]+$' || ! -d "$dir" ]]; then
        if [[ "$quiet" != "true" ]]; then
            echo "Timer $id not found."
        fi

        return 1
    fi

    local pid=""
    local sleep_pid=""
    local message="Time is up!"

    if [[ -f "$dir/pid" ]]; then
        pid=$(<"$dir/pid")
    fi

    if [[ -f "$dir/sleep_pid" ]]; then
        sleep_pid=$(<"$dir/sleep_pid")
    fi

    if [[ -f "$dir/message" ]]; then
        message=$(<"$dir/message")
    fi

    message="${message//$'\n'/ }"

    # Stop sleep first
    if [[ -n "$sleep_pid" ]]; then
        kill "$sleep_pid" 2>/dev/null
    fi

    # Then stop worker
    if [[ -n "$pid" ]]; then
        kill "$pid" 2>/dev/null
    fi

    # Explicit /bin/rm avoids aliases such as `rm -v`
    /bin/rm -rf -- "$dir"

    if [[ "$quiet" != "true" ]]; then
        printf "■ [%s] stopped  %s\n" \
            "$id" \
            "$message"
    fi

    return 0
}


# ------------------------------------------------------------
# Stop all timers
# ------------------------------------------------------------

_timer_stop_all() {
    setopt local_options numeric_glob_sort

    _timer_cleanup

    local -a dirs
    dirs=("$TIMER_STATE_DIR"/*(/N))

    if (( ${#dirs[@]} == 0 )); then
        echo "No active timers."
        return 0
    fi

    local dir
    local count=0

    for dir in "${dirs[@]}"; do
        [[ -d "$dir" ]] || continue

        if _timer_stop_id "${dir:t}" true; then
            (( count++ ))
        fi
    done

    printf "■ stopped all timers (%d)\n" "$count"
}


# ------------------------------------------------------------
# Stop command
# ------------------------------------------------------------

_timer_stop() {
    setopt local_options numeric_glob_sort

    _timer_cleanup

    local requested_id="$1"

    # timer stop all
    if [[ "$requested_id" == "all" ]]; then
        _timer_stop_all
        return $?
    fi

    # timer stop <ID>
    if [[ -n "$requested_id" ]]; then
        _timer_stop_id "$requested_id"
        return $?
    fi

    # timer stop
    local -a dirs
    dirs=("$TIMER_STATE_DIR"/*(/N))

    case ${#dirs[@]} in

        0)
            echo "No active timers."
            return 0
            ;;

        1)
            _timer_stop_id "${dirs[1]:t}"
            return $?
            ;;

        *)
            echo "Multiple timers are active."
            echo

            _timer_show

            echo
            echo "Usage:"
            echo "  timer stop <ID>"
            echo "  timer stop all"

            return 1
            ;;
    esac
}


# ------------------------------------------------------------
# Main timer command
# ------------------------------------------------------------

timer() {
    mkdir -p "$TIMER_STATE_DIR"

    # --------------------------------------------------------
    # timer
    #
    # Show all active timers
    # --------------------------------------------------------

    if (( $# == 0 )); then
        _timer_show
        return
    fi


    # --------------------------------------------------------
    # timer stop
    # timer stop <ID>
    # timer stop all
    # --------------------------------------------------------

    if [[ "$1" == "stop" ]]; then
        shift

        if (( $# > 1 )); then
            echo "Usage:"
            echo "  timer stop"
            echo "  timer stop <ID>"
            echo "  timer stop all"
            return 1
        fi

        _timer_stop "$1"
        return $?
    fi


    # --------------------------------------------------------
    # Start timer
    # --------------------------------------------------------

    local duration="$1"
    shift

    local message

    if (( $# > 0 )); then
        message="$*"
    else
        message="Time is up!"
    fi

    local total_seconds

    if ! total_seconds=$(
        _timer_parse_duration "$duration"
    ); then
        echo "Invalid duration: $duration"
        echo
        echo "Examples:"
        echo "  timer 25"
        echo "  timer 30s"
        echo "  timer 25m"
        echo "  timer 1h"
        echo "  timer 1h30m"
        echo '  timer 25m "Break time"'
        return 1
    fi

    _timer_cleanup

    local id
    id=$(_timer_next_id)

    local dir="$TIMER_STATE_DIR/$id"

    mkdir -p "$dir"

    local started_at
    local end_at

    started_at=$(date +%s)
    end_at=$((started_at + total_seconds))

    printf "%s\n" "$started_at" \
        > "$dir/started_at"

    printf "%s\n" "$end_at" \
        > "$dir/end"

    printf "%s\n" "$total_seconds" \
        > "$dir/duration"

    printf "%s\n" "$message" \
        > "$dir/message"


    # --------------------------------------------------------
    # Background worker
    # --------------------------------------------------------

    (
        sleep "$total_seconds" &

        sleep_pid=$!

        printf "%s\n" "$sleep_pid" \
            > "$dir/sleep_pid"

        wait "$sleep_pid" || exit 0

        # State no longer exists = timer was stopped
        [[ -d "$dir" ]] || exit 0


        # ----------------------------------------------------
        # macOS alert + sound
        # ----------------------------------------------------

        if [[ "${TIMER_SOUND:l}" == "true" ]]; then
            /usr/bin/afplay /System/Library/Sounds/Glass.aiff &
        fi

        if command -v osascript >/dev/null 2>&1; then
            /usr/bin/osascript - "$message" <<'APPLESCRIPT'
on run argv
    display alert "Timer" message (item 1 of argv) giving up after 10
end run
APPLESCRIPT
        fi

        # ----------------------------------------------------
        # Remove completed timer state
        # ----------------------------------------------------

        /bin/rm -rf -- "$dir"

    ) >/dev/null 2>&1 &!


    # Worker PID
    local worker_pid=$!

    printf "%s\n" "$worker_pid" \
        > "$dir/pid"


    # --------------------------------------------------------
    # Confirmation
    # --------------------------------------------------------

    local formatted
    formatted=$(_timer_format_time "$total_seconds")

    printf "⏱ [%s] %s  %s\n" \
        "$id" \
        "$formatted" \
        "$message"
}


# ============================================================
# zsh completion
# ============================================================
_timer_completion() {
    local context state line

    # --------------------------------------------------------
    # timer <TAB>
    # --------------------------------------------------------

    if (( CURRENT == 2 )); then
        local -a choices

        choices=(
            '5m:5 minutes'
            '25m:25 minutes'
            '1h:1 hour'
            'stop:stop a timer'
        )

        _describe -V 'duration or command' choices
        return
    fi


    # --------------------------------------------------------
    # timer stop <TAB>
    # --------------------------------------------------------

    if (( CURRENT == 3 )) && [[ "$words[2]" == "stop" ]]; then
        local -a choices
        local dir
        local id
        local message
        local end
        local remaining
        local formatted
        local now

        now=$(date +%s)

        for dir in "$TIMER_STATE_DIR"/*(/N); do
            id="${dir:t}"
            message="Time is up!"

            if [[ -f "$dir/message" ]]; then
                message=$(<"$dir/message")
                message="${message//$'\n'/ }"
            fi

            if [[ -f "$dir/end" ]]; then
                end=$(<"$dir/end")
                remaining=$((end - now))

                (( remaining < 0 )) && remaining=0

                formatted=$(_timer_format_time "$remaining")
            else
                formatted="--:--"
            fi

            choices+=(
                "${id}:${formatted}  ${message}"
            )
        done

        choices+=(
            'all:stop all timers'
        )

        _describe -V 'timer' choices
        return
    fi


    # --------------------------------------------------------
    # timer <duration> <message>
    # --------------------------------------------------------

    if (( CURRENT >= 3 )); then
        _message 'timer message'
        return
    fi
}


compdef _timer_completion timer