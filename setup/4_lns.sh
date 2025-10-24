#!/bin/bash

set -e
set -u


# dotfiles
cd ~/Desktop/github/dotfiles/home/
for i in .[a-z]*
do
	ln -sf ~/Desktop/github/dotfiles/home/"$i" ~/"$i"
done

# .zshenv
ln -sf ~/Desktop/github/dotfiles/zsh/.zshenv ~/.zshenv

# espanso
ln -sf ~/Desktop/github/espanso/ ~/Library/Application\ Support/

# others
ln -sf ~/Desktop/github/dotfiles/script/plugins /Users/kensuke/Library/Application\ Support/xbar/
ln -sf ~/Desktop/github/dotfiles/vscode/settings.json ~/Library/Application\ Support/Code/User/settings.json
ln -sf ~/My\ Drive/backup/Open\ in\ VSCode.workflow ~/Library/Services/Open\ in\ VSCode.workflow
ln -sf ~/myLibrary/Application\ Support/Firefox ~/Library/Application\ Support/Firefox
ln -sf ~/myLibrary/Application\ Support/Zotero ~/Library/Application\ Support/Zotero