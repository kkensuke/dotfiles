#!/bin/bash

set -e
set -u


# dotfiles
cd ~/My\ Drive/app/github/dotfiles/home/
for i in .[a-z]*
do
	ln -sf ~/My\ Drive/app/github/dotfiles/home/"$i" ~/"$i"
done

# .zshenv
ln -sf ~/My\ Drive/app/github/dotfiles/zsh/.zshenv ~/.zshenv

# firefox
ln -sf ~/My\ Drive/app/github/dotfiles/backup/firefox-userChrome.css ~/Library/Application\ Support/Firefox/Profiles/ozg3hll2.default-release/chrome/userChrome.css