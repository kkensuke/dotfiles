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

# others
ln -s ~/My\ Drive/tmp ~/Desktop/tmp
ln -s ~/My\ Drive/app/github ~/github
ln -s ~/My\ Drive/app/github/dotfiles ~/dotfiles
