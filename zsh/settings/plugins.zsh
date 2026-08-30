# zsh-git-prompt
source /opt/homebrew/opt/zsh-git-prompt/zshrc.sh
#ZSH_THEME_GIT_PROMPT_CHANGED="%{$fg[green]%}%{✚%G%}"

# zsh-syntax-highlighting
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# zsh-completions, zsh-autosuggestions
if type brew &>/dev/null; then
    FPATH=$(brew --prefix)/share/zsh-completions:$FPATH
    source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
    autoload -Uz compinit
    compinit
fi
