#!/bin/bash

set -e
set -u


# Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# reload
exec ${SHELL} -l

# install to use git
xcode-select --install

# CLI
brew install coreutils
brew install duf
brew install gcc
brew install libomp
brew install gh
brew install git-filter-repo
brew install scc
brew install tree
brew install zsh-autosuggestions
brew install zsh-completions
brew install zsh-git-prompt
brew install zsh-syntax-highlighting

# C++
sudo ln -s /opt/homebrew/bin/gcc-14 /usr/local/bin/gcc
sudo ln -s /opt/homebrew/bin/g++-14 /usr/local/bin/g++

# GUI
brew install --cask appcleaner
brew install --cask bitwarden
brew install --cask cheatsheet
brew install --cask cloudflare-warp
brew install --cask coconutbattery
brew install --cask coteditor
brew install --cask clipy
brew install --cask drawio
brew install --cask db-browser-for-sqlite
brew install --cask firefox
brew install --cask google-drive
brew install --cask grammarly
brew install --cask imageoptim
brew install --cask mathpix-snipping-tool
brew install --cask MonitorControl
brew install --cask notion
brew install --cask rectangle
brew install --cask shotcut
brew install --cask shottr
brew install --cask syntax-highlight
brew install --cask visual-studio-code
brew install --cask vlc
brew install --cask zoom
brew install --cask zotero


# app store
# hand-mirror
# unsplash

# register gh alias
----------------------------------------------------
gh alias set repo-delete 'api -X DELETE "repos/$1"'
gh auth refresh -h github.com -s delete_repo

## check alias
# gh alias list
## usage (WARNING: no confirmation!)
# gh repo-delete user/myrepo

# Authenticate Git
gh auth login -s delete_repo
----------------------------------------------------

# reload
exec ${SHELL} -l
