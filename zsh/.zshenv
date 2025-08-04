# ref: https://github.com/mathiasbynens/dotfiles/blob/main

# https://www.cyberciti.biz/faq/apple-mac-osx-terminal-color-ls-output-option/
export CLICOLOR=true
# export LSCOLORS=GxFxCxDxBxegedabagaced
export LS_COLORS='no=00:fi=00:di=00;96:ln=01;35:*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.gz=01;31:*.jar=01;31:*.jpg=01;35:*.jpeg=01;35:*.gif=01;35:*.png=01;35:*.mp3=01;35:*.wav=01;35:'

export LANG=ja_JP.UTF-8

export ZDOTDIR="$HOME/My Drive/app/github/dotfiles/zsh"

export VOLTA_HOME="$HOME/.volta"
export PATH="$VOLTA_HOME/bin:$PATH"


# c++
export "PATH=/usr/local/bin:$PATH"
export CPATH=/opt/homebrew/include/
