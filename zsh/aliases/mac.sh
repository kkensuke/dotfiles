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

# sleep setting
alias sleepon='sudo pmset -a disablesleep 0'
alias sleepoff='sudo pmset -a disablesleep 1'
