#!/bin/bash

set -e
set -u


# Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# reload
exec ${SHELL} -l

# CLI
brew install bat
brew install cmatrix
brew install coreutils
brew install duf
brew install fd
brew install fzf
brew install gcc
brew install libomp
brew install gh
brew install git-delta
brew install git-filter-repo
brew install ghostscript
brew install neovim
brew install rename
brew install scc
brew install sqlite
brew install tree
brew install uv
brew install volta
brew install yt-dlp
brew install zsh-autosuggestions
brew install zsh-completions
brew install zsh-git-prompt
brew install zsh-syntax-highlighting

# C++
#sudo ln -s /opt/homebrew/bin/gcc-14 /usr/local/bin/gcc
#sudo ln -s /opt/homebrew/bin/g++-14 /usr/local/bin/g++

# GUI
brew install --cask nikitabobko/tap/aerospace
brew install --cask anki
brew install --cask appcleaner
brew install --cask cloudflare-warp
brew install --cask coconutbattery
brew install --cask coteditor
brew install --cask clipy
brew install --cask cryptomator
brew install --cask drawio
brew install --cask espanso
brew install --cask firefox
brew install --cask iina
brew install --cask google-chrome
brew install --cask google-drive
brew install --cask keycastr
brew install --cask mathpix-snipping-tool
brew install --cask MonitorControl
brew install --cask rectangle
brew install --cask shottr
brew install --cask syntax-highlight
brew install --cask visual-studio-code
brew install --cask timac/vpnstatus/vpnstatus
brew install --cask xbar
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
