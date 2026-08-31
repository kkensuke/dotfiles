mkdir -p "$HOME/Library/LaunchAgents"

cat > "$HOME/Library/LaunchAgents/local.capslock-delay.plist" <<'EOF'
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN"
  "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>Label</key>
    <string>local.capslock-delay</string>

    <key>ProgramArguments</key>
    <array>
        <string>/usr/bin/hidutil</string>
        <string>property</string>
        <string>--set</string>
        <string>{"CapsLockDelayOverride":10}</string>
    </array>

    <key>RunAtLoad</key>
    <true/>
</dict>
</plist>
EOF

plutil -lint "$HOME/Library/LaunchAgents/local.capslock-delay.plist"

launchctl bootout "gui/$(id -u)" \
  "$HOME/Library/LaunchAgents/local.capslock-delay.plist" 2>/dev/null || true

launchctl bootstrap "gui/$(id -u)" \
  "$HOME/Library/LaunchAgents/local.capslock-delay.plist"