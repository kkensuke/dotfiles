#!/bin/bash

set -e
set -u


# dotfiles
cd ~/My\ Drive/app/github/programming/dotfiles/home/
for i in .*
do
	ln -sf ~/My\ Drive/app/github/programming/dotfiles/home/"$i" ~/"$i"
done

# .zshenv
ln -sf ~/My\ Drive/app/github/programming/dotfiles/zsh/.zshenv ~/.zshenv

# firefox
ln -sf ~/My\ Drive/app/github/programming/dotfiles/backup/firefox-userChrome.css ~/Library/Application\ Support/Firefox/Profiles/ozg3hll2.default-release/chrome/userChrome.css