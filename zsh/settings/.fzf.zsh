# Setup fzf
# ---------
if [[ ! "$PATH" == */opt/homebrew/opt/fzf/bin* ]]; then
  PATH="${PATH:+${PATH}:}/opt/homebrew/opt/fzf/bin"
fi

source <(fzf --zsh)


# https://github.com/junegunn/fzf#respecting-gitignore
# https://zenn.dev/megeton/articles/c408511c66f45d
export FZF_DEFAULT_COMMAND='fd --type f --strip-cwd-prefix --hidden --follow'
export FZF_DEFAULT_OPTS='--height 70% --reverse --border --preview "head -100 {}"'
