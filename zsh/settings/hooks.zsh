autoload -Uz add-zsh-hook

# Run after changing directory.
_after_cd() {
    gls --color --group-directories-first -F  -A
}

add-zsh-hook chpwd _after_cd