#!/bin/bash

set -e
set -u

# dotfiles
cd ~/My\ Drive/app/github/programming/setting/.home/

for i in .*
do
	if [[ ! -f ~/"$i" ]] && [[ ! -d ~/"$i" ]]; then
		ln -s ~/My\ Drive/app/github/programming/setting/.home/"$i" ~/"$i"
	else
		echo "~/$i already exists."
	fi
done

if [[ ! -f ~/.zshenv ]]; then
	ln -s ~/My\ Drive/app/github/programming/setting/.zsh/.zshenv ~/.zshenv
else
	echo "~/.zshenv already exists."
fi


# firefox
if [[ -d ~/Library/Application\ Support/Firefox ]] && [[ ! -f ~/Library/Application\ Support/Firefox/Profiles/ozg3hll2.default-release/chrome/userChrome.css ]]; then
	ln -s ~/My\ Drive/app/github/programming/setting/backup/firefox-userChrome.css ~/Library/Application\ Support/Firefox/Profiles/ozg3hll2.default-release/chrome/userChrome.css
else
	echo "firefox-userChrome.css already exists."
fi

## zotero
# if [[ -d ~/Library/Application\ Support/Zotero ]] && [[ ! -f ~/Library/Application\ Support/Firefox/Profiles/ozg3hll2.default-release/chrome/userChrome.css ]]; then
# 	ln -s ~/My\ Drive/app/github/programming/setting/backup/zotero-userChrome.css ~/Library/Application\ Support/Zotero/Profiles/rcymn1zx.default/chrome/userChrome.css
# else
# 	echo "zotero-userChrome.css already exists."
# fi