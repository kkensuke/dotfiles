# zsh-git-prompt
. "/opt/homebrew/opt/zsh-git-prompt/zshrc.sh"

# zsh-completions, zsh-autosuggestions
if type brew &>/dev/null; then
	FPATH=$(brew --prefix)/share/zsh-completions:$FPATH
	. /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
	autoload -Uz compinit
	compinit
fi


setopt auto_cd
setopt inc_append_history
setopt share_history
setopt hist_ignore_dups