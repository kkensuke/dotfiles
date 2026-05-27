# Screenshot
alias dwl='defaults write com.apple.screencapture location'
alias ddl='defaults delete com.apple.screencapture location'
alias drl='defaults read com.apple.screencapture location'

# Show/hide hidden files in Finder (cmd + shift + .)
alias show='defaults write com.apple.finder AppleShowAllFiles -bool true && killall Finder'
alias hide='defaults write com.apple.finder AppleShowAllFiles -bool false && killall Finder'

# Hide/show all desktop icons
alias dhide='defaults write com.apple.finder CreateDesktop -bool false && killall Finder'
alias dshow='defaults write com.apple.finder CreateDesktop -bool true && killall Finder'

# Hide/show the files and folders
alias hidden='chflags hidden'
alias nohidden='chflags nohidden'

# sleep setting
alias sleepon='sudo pmset -a disablesleep 0'
alias sleepoff='sudo pmset -a disablesleep 1'

# Switch audio output
function _toggle_audio_source() {
  # Get the current audio output device
  local current=$(SwitchAudioSource -c)
  
  if [ "$current" = "MacBook Air Speakers" ]; then
    SwitchAudioSource -s "Soundcore 3" >/dev/null
    echo "\n🎧 Output switched to: Soundcore 3"
  else
    # If it's Soundcore 3 or any other device, switch back to MacBook
    SwitchAudioSource -s "MacBook Air Speakers" >/dev/null
    echo "\n💻 Output switched to: MacBook Air Speakers"
  fi
}
alias ts="_toggle_audio_source"