#!/bin/bash

set -e
set -u


# ref:
# - https://github.com/rootbeersoup/dotfiles
# - https://github.com/skwp/dotfiles
# - https://github.com/sobolevn/dotfiles
# - https://github.com/webpro/dotfiles
# - https://apple.stackexchange.com/questions/14001/how-to-turn-off-all-animations-on-os-x


echo 'Configuring your mac. Hang tight.'
osascript -e 'tell application "System Preferences" to quit'


## General ##
# Disable the sound effects on boot
sudo nvram SystemAudioVolume=" "
sudo nvram StartupMute=%01

# deactivate the CapsLockDelay
hidutil property --set '{"CapsLockDelayOverride":0}'

# Disable the “Are you sure you want to open this application?” dialog
defaults write com.apple.LaunchServices LSQuarantine -bool false

# Disable Notifcations
launchctl unload -w /System/Library/LaunchAgents/com.apple.notificationcenterui.plist



## Dock ##
# delete an array of items located on the Applications side of the Dock
defaults delete com.apple.dock persistent-apps

# delete an array of items located on the Documents side of the Dock
defaults delete com.apple.dock persistent-others

# change the size of icons in the dock
defaults write com.apple.dock "tilesize" -int 43

# put favorite apps in the dock
apps=("/System/Applications/System Settings" "/System/Applications/Utilities/Terminal" "/Applications/CotEditor" "/Applications/Visual Studio Code" "/Applications/Firefox" "/Applications/Zotero" "/System/Applications/Mail")

for app in "${apps[@]}"
do
	defaults write com.apple.dock persistent-apps -array-add "<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>$app.app</string><key>_CFURLStringType</key><integer>0</integer></dict></dict></dict>"
done



## Finder ##
# Keep folders on top when sorting by name:
defaults write com.apple.finder _FXSortFoldersFirst -bool true

# Show Finder path bar:
defaults write com.apple.finder ShowPathbar -bool true

# Do not show status bar in Finder:
defaults write com.apple.finder ShowStatusBar -bool false

# Show hidden files in Finder: cmd + shift + .
defaults write com.apple.finder AppleShowAllFiles -bool true

# Show file extensions in Finder:
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# Disable the warning when changing a file extension
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

# Disable the warning when opening unconfirmed apps
defaults write com.apple.LaunchServices LSQuarantine -bool false

# Use column view in all Finder windows by default
# View modes:
# Flwv - Cover Flow View
# Nlsv - List View
# clmv - Column View
# icnv - Icon View
defaults write com.apple.finder FXPreferredViewStyle -string "clmv"

# Avoid creating .DS_Store files
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true

# set coteditor as default editor for any .txt file
defaults write com.apple.LaunchServices LSHandlers -array-add '{LSHandlerContentType=public.plain-text;LSHandlerRoleAll=com.coteditor.CotEditor;}'

# Show Library folder
chflags nohidden ~/Library

# Stop using default folders
chflags hidden ~/{Documents,Movies,Music,Pictures}
chmod 000 ~/{Documents,Movies,Music,Pictures}



## DisableAllAnimations ##
# opening and closing windows and popovers
defaults write NSGlobalDomain NSAutomaticWindowAnimationsEnabled -bool false

# smooth scrolling
defaults write NSGlobalDomain NSScrollAnimationEnabled -bool false

# showing and hiding sheets, resizing preference windows, zooming windows
# float 0 doesn't work
defaults write NSGlobalDomain NSWindowResizeTime -float 0.001

# opening and closing Quick Look windows
defaults write NSGlobalDomain QLPanelAnimationDuration -float 0

# rubberband scrolling (doesn't affect web views)
defaults write NSGlobalDomain NSScrollViewRubberbanding -bool false

# resizing windows before and after showing the version browser
# also disabled by NSWindowResizeTime -float 0.001
defaults write NSGlobalDomain NSDocumentRevisionsWindowTransformAnimation -bool false

# showing a toolbar or menu bar in full screen
defaults write NSGlobalDomain NSToolbarFullScreenAnimationDuration -float 0

# scrolling column views
defaults write NSGlobalDomain NSBrowserColumnAnimationSpeedMultiplier -float 0

# showing the Dock
defaults write com.apple.dock autohide-time-modifier -float 0
defaults write com.apple.dock autohide-delay -float 0

# showing and hiding Mission Control, command+numbers
defaults write com.apple.dock expose-animation-duration -float 0

# showing and hiding Launchpad
defaults write com.apple.dock springboard-show-duration -float 0
defaults write com.apple.dock springboard-hide-duration -float 0

# changing pages in Launchpad
defaults write com.apple.dock springboard-page-duration -float 0

# at least AnimateInfoPanes
defaults write com.apple.finder DisableAllAnimations -bool true

# sending messages and opening windows for replies
defaults write com.apple.Mail DisableSendAnimations -bool true
defaults write com.apple.Mail DisableReplyAnimations -bool true



## Screenshot ##
defaults write com.apple.screencapture name "screenshot"
defaults write com.apple.screencapture show-thumbnail -bool false
defaults write com.apple.screencapture include-date -bool false
defaults write com.apple.screencapture disable-shadow -bool true
defaults write com.apple.screencapture showsCursor -bool true
defaults write com.apple.screencapture location ~/Desktop/
defaults write com.apple.screencapture type png # png, gif, jpeg, pdf, bmp, tiff, psd, jpeg 2000, etc.
# defaults read com.apple.screencapture # See all settings about screenshot



## Restarting apps ##
echo 'Restarting apps...'
killall Finder
killall Dock

echo 'Done!'
