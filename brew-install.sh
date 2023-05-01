#!/bin/bash

set -e
set -u


# Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# CLI
brew install gh
brew install git
brew install imagemagick ffmpeg
brew install mackup
brew install mas
brew install tree
brew install zsh-autosuggestions
brew install zsh-completions
brew install zsh-git-prompt

# GUI
brew install appcleaner
brew install bitwarden
brew install cheatsheet
brew install coconutbattery
brew install cot
brew install clipy
brew install drowio
brew install firefox
brew install google-drive
brew install grammarly
brew install imageoptim
brew install caskformula/caskformula/inkscape
brew install mathpix
brew install notion
brew install rectangle
brew install shotcut
brew install shottr
brew install slack
brew install visual-studio-code
brew install vlc
brew install wezterm
brew install zoom
brew install zotero

# AppStore
mas install 539883307 # LINE
mas install 931571202 # QuickShade
mas install 1502839586 # Hand Mirror

# Quick Look Plugins (https://github.com/sindresorhus/quick-look-plugins)
# brew install qlcolorcode qlstephen qlmarkdown quicklook-json qlimagesize suspicious-package apparency quicklookase qlvideo


# register gh alias
----------------------------------------------------
gh alias set repo-delete 'api -X DELETE "repos/$1"'
gh auth refresh -h github.com -s delete_repo

# usage (WARNING: no confirmation!)
# gh repo-delete user/myrepo
# comfirm
# gh alias list
----------------------------------------------------
