#!/bin/bash

set -e
set -u


export GITHUB="$HOME/github"
export DOTFILES="$GITHUB/dotfiles"


# dotfiles
cd $DOTFILES/home/
for i in .[a-z]*
do
    ln -sf $DOTFILES/home/"$i" ~/"$i"
done

# .zshenv
ln -sf $DOTFILES/zsh/.zshenv ~/.zshenv

# espanso
ln -sf $GITHUB/espanso/ ~/Library/Application\ Support/

# others
mkdir -p ~/Library/Application\ Support/xbar && ln -sf $DOTFILES/script/plugins ~/Library/Application\ Support/xbar/

# vscode
ln -sf $DOTFILES/vscode/settings.json ~/Library/Application\ Support/Code/User/settings.json

# Quick Actions
ln -sf $DOTFILES/script/Open\ in\ VSCode.workflow ~/Library/Services/Open\ in\ VSCode.workflow
ln -sf $DOTFILES/script/Open\ in\ Preview.workflow ~/Library/Services/Open\ in\ Preview.workflow

# reload
exec ${SHELL} -l