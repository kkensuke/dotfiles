# Setup fzf
# ---------
if [[ ! "$PATH" == */Users/kensuke/.fzf/bin* ]]; then
    PATH="${PATH:+${PATH}:}/Users/kensuke/.fzf/bin"
fi


# https://github.com/junegunn/fzf#respecting-gitignore
# https://zenn.dev/megeton/articles/c408511c66f45d
export FZF_DEFAULT_COMMAND='fd --type f --strip-cwd-prefix --hidden --follow'
export FZF_DEFAULT_OPTS='--height 70% --reverse --border --preview "head -100 {}"'


# Auto-completion
# ---------------
source "/Users/kensuke/.fzf/shell/completion.zsh"

# Key bindings
# ------------
source "/Users/kensuke/.fzf/shell/key-bindings.zsh"
