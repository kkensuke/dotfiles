# Setup fzf
# ---------
if [[ ! "$PATH" == */Users/kensuke/.fzf/bin* ]]; then
    PATH="${PATH:+${PATH}:}/Users/kensuke/.fzf/bin"
fi

# Auto-completion
# ---------------
source "/Users/kensuke/.fzf/shell/completion.zsh"

# Key bindings
# ------------
source "/Users/kensuke/.fzf/shell/key-bindings.zsh"
