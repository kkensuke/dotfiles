#!/bin/bash

set -e
set -u


# Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# CLI
brew install gh
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
brew install hand-mirror
brew install imageoptim
brew install mathpix
brew install MonitorControl
brew install notion
brew install rectangle
brew install shotcut
brew install shottr
brew install slack
brew install visual-studio-code
brew install vlc
brew install zoom
brew install zotero


# register gh alias
----------------------------------------------------
gh alias set repo-delete 'api -X DELETE "repos/$1"'
gh auth refresh -h github.com -s delete_repo

# comfirm
# gh alias list
# usage (WARNING: no confirmation!)
# gh repo-delete user/myrepo
----------------------------------------------------
