#!/bin/bash
# <xbar.title>Simple Timer (Fixed-width)</xbar.title>
# <xbar.version>v1.2</xbar.version>
# <xbar.author>Kensuke</xbar.author>
# <xbar.desc>Countdown timer with fixed-width digits (uses fullwidth Unicode digits).</xbar.desc>
# <xbar.dependencies>bash, osascript</xbar.dependencies>
# <xbar.refresh>1</xbar.refresh>

STATE_FILE="/tmp/xbar_timer_state"

now() { date +%s; }

save_state() {
  cat >"$STATE_FILE" <<EOF
END_TIME=$END_TIME
RUNNING=$RUNNING
REMAINING=$REMAINING
NOTIFIED=$NOTIFIED
EOF
}

load_state() {
  if [ -f "$STATE_FILE" ]; then
    # shellcheck disable=SC1090
    source "$STATE_FILE"
  else
    END_TIME=0
    RUNNING=0
    REMAINING=0
    NOTIFIED=0
  fi
}

# convert ASCII digits and colon to fullwidth characters (fixed width)
to_fullwidth() {
  s="$1"
  # array of fullwidth digits 0-9
  digits=(０ １ ２ ３ ４ ５ ６ ７ ８ ９)
  for i in 0 1 2 3 4 5 6 7 8 9; do
    s="${s//${i}/${digits[i]}}"
  done
  # convert colon to fullwidth colon
  s="${s//:/：}"
  echo "$s"
}

# parse human-friendly durations: 25m, 5m, 1m, 90s, 1h, or plain minutes (e.g. 25)
parse_seconds() {
  arg="$1"
  if [[ "$arg" =~ ^([0-9]+)h$ ]]; then
    echo $(( ${BASH_REMATCH[1]} * 3600 ))
  elif [[ "$arg" =~ ^([0-9]+)m$ ]]; then
    echo $(( ${BASH_REMATCH[1]} * 60 ))
  elif [[ "$arg" =~ ^([0-9]+)s$ ]]; then
    echo "${BASH_REMATCH[1]}"
  elif [[ "$arg" =~ ^[0-9]+$ ]]; then
    # treat plain number as minutes
    echo $(( arg * 60 ))
  else
    # fallback: 60s
    echo 60
  fi
}

notify_finished() {
  /usr/bin/osascript -e 'beep 3'
  /usr/bin/osascript -e 'display dialog "Timer finished!" with title "xbar Timer" buttons {"OK"} default button "OK" with icon caution' &>/dev/null
}

# Handle action invocations
if [ "$1" = "start" ]; then
  DURATION_STR="${2:-25m}"
  DURATION=$(parse_seconds "$DURATION_STR")
  END_TIME=$(( $(now) + DURATION ))
  RUNNING=1
  REMAINING=0
  NOTIFIED=0
  save_state
  exit 0
elif [ "$1" = "custom" ]; then
  # Show input dialog for custom timer
  CUSTOM_INPUT=$(/usr/bin/osascript -e 'display dialog "Enter timer duration:\n(e.g., 10m, 30s, 1h, or just 15 for minutes)" default answer "10m" with title "Custom Timer" buttons {"Cancel", "Start"} default button "Start"' -e 'text returned of result' 2>/dev/null)
  if [ -n "$CUSTOM_INPUT" ]; then
    DURATION=$(parse_seconds "$CUSTOM_INPUT")
    END_TIME=$(( $(now) + DURATION ))
    RUNNING=1
    REMAINING=0
    NOTIFIED=0
    save_state
  fi
  exit 0
elif [ "$1" = "stop" ]; then
  load_state
  if [ "$RUNNING" -eq 1 ]; then
    REM=$(( END_TIME - $(now) ))
    if [ "$REM" -lt 0 ]; then REM=0; fi
    REMAINING=$REM
    END_TIME=0
  fi
  RUNNING=0
  NOTIFIED=0
  save_state
  exit 0
elif [ "$1" = "reset" ]; then
  END_TIME=0
  RUNNING=0
  REMAINING=0
  NOTIFIED=0
  save_state
  exit 0
fi

# Normal display run (no args)
load_state

# Determine display text and icon
if [ "$RUNNING" -eq 1 ] && [ "$END_TIME" -gt 0 ]; then
  REM=$(( END_TIME - $(now) ))
  if [ "$REM" -eq 0 ]; then
    # Show 00:00 first
    DISPLAY="00:00"
    ICON="⏰"
  elif [ "$REM" -lt 0 ]; then
    # Time is up, show alert
    if [ "$NOTIFIED" -eq 0 ]; then
      notify_finished
      NOTIFIED=1
    fi
    RUNNING=0
    REMAINING=0
    END_TIME=0
    save_state
    DISPLAY="Done"
    ICON=""
  else
    # Running timer - format time
    H=$(( REM / 3600 ))
    M=$(( (REM % 3600) / 60 ))
    S=$(( REM % 60 ))
    if [ "$H" -gt 0 ]; then
      printf -v DISPLAY "%02d:%02d:%02d" "$H" "$M" "$S"
    else
      printf -v DISPLAY "%02d:%02d" "$M" "$S"
    fi
    ICON="⏰"
  fi
else
  # Stopped/paused timer
  REM=$REMAINING
  if [ "$REM" -gt 0 ]; then
    # Paused with remaining time
    H=$(( REM / 3600 ))
    M=$(( (REM % 3600) / 60 ))
    S=$(( REM % 60 ))
    if [ "$H" -gt 0 ]; then
      printf -v DISPLAY "%02d:%02d:%02d" "$H" "$M" "$S"
    else
      printf -v DISPLAY "%02d:%02d" "$M" "$S"
    fi
    ICON="⏸"
  else
    # No timer set
    DISPLAY="⏰"
    ICON=""
  fi
fi

# Convert to fullwidth if contains digits/colon
if [[ "$DISPLAY" =~ [0-9] ]]; then
  DISPLAY=$(to_fullwidth "$DISPLAY")
fi

# Combine icon and display
if [ -n "$ICON" ]; then
  DISPLAY="${ICON} ${DISPLAY}"
fi

# Single output point for menu bar
echo "$DISPLAY"

# Menu items
echo '---'
SCRIPT_PATH="$0"
echo "Start 1h  | bash='$SCRIPT_PATH' param1='start' param2='1h' terminal=false refresh=true"
echo "Start 30m  | bash='$SCRIPT_PATH' param1='start' param2='30m' terminal=false refresh=true"

echo "Start 3m  | bash='$SCRIPT_PATH' param1='start' param2='3m' terminal=false refresh=true"
echo "Set Custom Timer... | bash='$SCRIPT_PATH' param1='custom' terminal=false refresh=true"
if [ "$RUNNING" -eq 1 ]; then
  echo "Stop      | bash='$SCRIPT_PATH' param1='stop' terminal=false refresh=true"
fi
echo "Reset     | bash='$SCRIPT_PATH' param1='reset' terminal=false refresh=true"
echo "---"
echo "Simple Timer (xbar) - fixed-width digits"