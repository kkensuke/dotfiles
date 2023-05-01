# show files
#alias ls='ls -F'
alias ls='gls --color -F'
alias l='ls'
alias la='ls -A'
alias ll='ls -AhlS'
alias pwd='sed "s/ /\\\ /g" <<< ${PWD/#$HOME/"~"}'
alias p='pwd'
alias path='echo -e ${PATH//:/\\n}'

# `tre` with hidden files and color enabled, ignoring the `.git` directory, listing directories first.
# The output gets piped into `less` with options to preserve color and line numbers, unless the output is
# small enough for one screen.
tre() { tree -ahC -L "$2" -I '.git|venv|.DS_Store' --dirsfirst "$1"}

# change directory
cs() { cd $@ && la }
alias cd='cs'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias cb='cd -'
alias d='cd ~/Desktop'
alias dl='cd ~/Downloads'
alias h='cd ~'
alias /='cd /'
alias github='cd ~/My\ Drive/app/github'
alias gj='cd ~/My\ Drive/app/github/programming/jupyterbook/myjb'
alias gq='cd ~/My\ Drive/app/github/physics/qc'
alias s='cd ~/My\ Drive/app/github/programming/setting; open .'

# Change working directory to the top-most Finder window location. cdf short for `cd finder`
cdf() { cd "$(osascript -e 'tell app "Finder" to POSIX path of (insertion location as alias)')" }

# edit
alias cp='cp -iv'
alias mv='mv -iv'
alias rm='rm -iv'
alias rf='rm -rf'
alias v='vi'

# search
fb() { find . -size +$2M -type f -name $1 -exec ls -lhS "{}" \; | awk '{print $5,$9}' }
fd() { find . -name "*.$1" -type f -delete }
rn() { for filename in *.$1; do mv -f "$filename" $(echo "$filename" | sed -e "s/$2//g"); done }
dif(){ diff --color -u $1 $2 }
alias imgopt='open -a ImageOptim .'
alias grep='grep --color'

# others
alias b='brew'
alias his='history'
alias lns='ln -s'
alias rl='exec ${SHELL} -l' #reload
alias ne='2>|/dev/null'
alias no='&>|/dev/null'
alias eo='>|/dev/null'

# open apps
alias here='open .'
alias c='open /Applications/CotEditor.app'
alias vs='code .'
alias vsjs='c ~/Library/Application\ Support/Code/User/settings.json'
alias opjb='gj; open /Applications/Firefox.app _build/html/index.html'
alias fire='open /Applications/Firefox.app'
