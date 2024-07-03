## show files and directories ##
# alias ls='ls -F'
# use gls to use the same color as `tree`
alias ls='gls --color --group-directories-first -F'
alias l='ls'
alias la='ls -A'
alias ll='ls -AhlS'
alias lg='ls | grep -i'
alias ds='du -d 1 -h 2>/dev/null | sort -h'
alias pwd='sed "s/ /\\\ /g" <<< ${PWD/#$HOME/"~"}'
alias p='pwd; pwd | pbcopy'
alias path='echo -e ${PATH//:/\\n}'
tre() { tree -ahC -L "$2" -I '.git|venv|node_modules|.DS_Store' --dirsfirst "$1"}

## change directory ##
cs() { cd $@ && la }
alias cd='cs'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias cb='cd -'
alias d='cd ~/Desktop'
alias h='cd ~'
alias /='cd /'
alias github='cd ~/My\ Drive/app/github'
alias gj='cd ~/My\ Drive/app/github/jupyterbook/myjb-en'
alias gq='cd ~/My\ Drive/app/github/physics/qc'
alias s='cd ~/My\ Drive/app/github/dotfiles; open .'

# Change working directory to the top-most Finder window location.
cdf() { cd "$(osascript -e 'tell app "Finder" to POSIX path of (insertion location as alias)')" }

## edit ##
alias mv='mv -iv'
alias rm='rm -iv'
alias rf='rm -rf'
alias v='vi'
resizepdf169() {gs -o "resized_$1" -sDEVICE=pdfwrite -dDEVICEWIDTHPOINTS=1920 -dDEVICEHEIGHTPOINTS=1080 -dPDFFitPage -dFIXEDMEDIA -dCompatibilityLevel=1.4 $1}
resizepdf43() {gs -o "resized_$1" -sDEVICE=pdfwrite -dDEVICEWIDTHPOINTS=1024 -dDEVICEHEIGHTPOINTS=768 -dPDFFitPage -dFIXEDMEDIA -dCompatibilityLevel=1.4 $1}

## search ##
alias grep='grep --color'
alias fu='fzf'
fb() { find . -size +$2M -type f -name $1 -exec ls -lhS "{}" \; | awk '{print $5,$9}' }
fd() { find . -name "*.$1" -type f -delete }
rn() { for filename in *.$1; do mv -f "$filename" $(echo "$filename" | sed -e "s/$2//g"); done }
dif(){ diff --color -u $1 $2 }

## global aliases ##
alias -g C='| pbcopy'
alias -g G='| grep'
alias -g H='| head'
alias -g T='| tail'
alias -g EO='>/dev/null'
alias -g NE='2>/dev/null'
alias -g NO='&>/dev/null'

## open apps ##
alias o='open'
alias hr='open .'
alias c='open /Applications/CotEditor.app'
alias vs='code .'
alias vj='code ~/Library/Application\ Support/Code/User/settings.json'
alias espn='open ~/Library/Application\ Support/espanso/'
alias espnb='c  ~/Library/Application\ Support/espanso/match/base.yml'
alias espnd='c  ~/Library/Application\ Support/espanso/config/default.yml'
alias cpvj='cp -fv ~/myLibrary/Application\ Support/Code/User/settings.json ~/My\ Drive/app/github/dotfiles/vscode/settings.json'
alias fire='open /Applications/Firefox.app'

## make ##
alias m='mkdir'
alias test='touch ~/Desktop/asdf.ipynb; code ~/Desktop/asdf.ipynb'
tc() { touch $1 && c $1 }
mkc() { mkdir $1 && cd $1}

## others ##
alias mat='cmatrix'
alias his='history'
alias rl='echo ""; exec ${SHELL} -l' #reload
alias imgopt='open -a ImageOptim .'
alias sshadd='ssh-add ~/.ssh/id_ed25519'
alias -s py=python
alias -s {html,pdf}=fire