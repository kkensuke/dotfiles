#timer(){
#    sleep $((60 * $1)); osascript -e 'display alert "Time is up!"'
#}

timer() {
    if [ $# -eq 0 ]; then
        echo "Usage: timer_enhanced <minutes> [message]"
        echo "Example: timer_enhanced 25 'Break time!'"
        return 1
    fi
    
    local total_minutes=$1
    local message="${2:-Time is up!}"
    # Handle decimal minutes using awk for floating point arithmetic
    local total_seconds=$(awk "BEGIN {printf \"%.0f\", $total_minutes * 60}")
    local remaining=$total_seconds
    
    echo "Timer started for $total_minutes minute(s)"
    echo "Message: $message"
    echo "Press Ctrl+C to cancel"
    echo ""
    
    # Store start time for progress bar
    local start_time=$(date +%s)
    
    while [ $remaining -gt 0 ]; do
        local mins=$((remaining / 60))
        local secs=$((remaining % 60))
        
        # Calculate progress for progress bar
        local elapsed=$((total_seconds - remaining))
        local progress=$((elapsed * 20 / total_seconds))
        local bar=""
        
        # Create progress bar
        for i in $(seq 1 20); do
            if [ $i -le $progress ]; then
                bar="${bar}█"
            else
                bar="${bar}░"
            fi
        done
        
        # Display with progress bar
        printf "\rTime remaining: %02d:%02d [%s] %d%%" \
            $mins $secs "$bar" $((elapsed * 100 / total_seconds))
        
        sleep 1
        remaining=$((remaining - 1))
    done
    
    printf "\rCompleted:      00:00 [████████████████████] 100%%\n"
    echo ""
    echo "$message"
    
    # Notifications
    if command -v osascript >/dev/null 2>&1; then
        osascript -e "display alert \"$message\""
    fi
    
    if command -v notify-send >/dev/null 2>&1; then
        notify-send "Timer" "$message"
    fi
    
    # Audio alert
    if command -v say >/dev/null 2>&1; then
        say "$message"
    else
        echo -e "\a\a\a"
    fi
}