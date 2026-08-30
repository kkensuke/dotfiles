autoload -Uz add-zsh-hook

# Run after changing directory.
_after_cd() {
    la
}

add-zsh-hook chpwd _after_cd