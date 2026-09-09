source_if_exists() {
    [[ -r "$1" ]] && source "$1"
}

for file in "$ZDOTDIR"/settings/*.zsh; do
    source_if_exists "$file"
done

for file in "$ZDOTDIR"/aliases/*.zsh; do
    source_if_exists "$file"
done

for file in "$ZDOTDIR"/ignore/*.zsh; do
    source_if_exists "$file"
done

source_if_exists "$HOME/.local/bin/env"