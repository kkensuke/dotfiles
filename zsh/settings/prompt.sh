# put a blank line before prompt
precmd() { precmd() { echo } }

# color:  https://en.wikipedia.org/wiki/ANSI_escape_code#8-bit
PS1='%F{46} $(pwd)%f %# $(git_super_status) '
RPROMPT='%T'