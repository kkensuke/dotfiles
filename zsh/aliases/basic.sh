## show files and directories ##
# alias ls='ls -F'
# use gls to use the same color as `tree`
alias ls='gls --color --group-directories-first -F'
alias l='ls'
alias la='ls -A'
alias ll='ls -AhlS'
alias ds='du -d 1 -h 2>/dev/null | sort -h'
alias pwd='sed "s/ /\\\ /g" <<< ${PWD/#$HOME/"~"}'
alias p='pwd'
alias path='echo -e ${PATH//:/\\n}'
tre() { tree -ahC -L "$2" -I '.git|venv|.DS_Store' --dirsfirst "$1"}

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
alias gj='cd ~/My\ Drive/app/github/jupyterbook/myjb'
alias gq='cd ~/My\ Drive/app/github/physics/qc'
alias s='cd ~/My\ Drive/app/github/dotfiles; open .'

# Change working directory to the top-most Finder window location.
cdf() { cd "$(osascript -e 'tell app "Finder" to POSIX path of (insertion location as alias)')" }

## edit ##
alias mv='mv -iv'
alias rm='rm -iv'
alias rf='rm -rf'
alias v='vi'

## global aliases ##
alias -g G='| grep'
alias -g H='| head'
alias -g T='| tail'
alias -g EO='>/dev/null'
alias -g NE='2>/dev/null'
alias -g NO='&>/dev/null'

## search ##
alias grep='grep --color'
fb() { find . -size +$2M -type f -name $1 -exec ls -lhS "{}" \; | awk '{print $5,$9}' }
fd() { find . -name "*.$1" -type f -delete }
rn() { for filename in *.$1; do mv -f "$filename" $(echo "$filename" | sed -e "s/$2//g"); done }
dif(){ diff --color -u $1 $2 }

## make ##
tc() { touch $1 && c $1 }
mkc() { mkdir $1 && cd $1}

## open apps ##
alias hr='open .'
alias c='open /Applications/CotEditor.app'
alias vs='code .'
alias vj='code ~/Library/Application\ Support/Code/User/settings.json'
alias cpvj='cp -fv ~/Library/Application\ Support/Code/User/settings.json ~/My\ Drive/app/github/dotfiles/vscode/settings.json;
			cp -fv ~/Library/Application\ Support/Code/User/settings.json ~/My\ Drive/app/github//latex-template/settings.json;
			cp -fv ~/.vscode/extensions/extensions.json ~/My\ Drive/app/github/dotfiles/vscode/extensions.json'
alias opjb='gj; open /Applications/Firefox.app _build/html/index.html'
alias fire='open /Applications/Firefox.app'

## others ##
alias pb='pbcopy'
alias his='history'
alias rl='exec ${SHELL} -l' #reload
alias imgopt='open -a ImageOptim .'
alias -s py=python
alias -s html=fire