#!/usr/bin/env bash

failed=0

# VS Code
EDITOR_ID="com.microsoft.VSCode"

types=(
    public.plain-text public.text public.source-code
    txt md tex js jsx ts tsx py go rs c cpp h hpp
    css json yaml yml xml sh zsh bash
)

for type in "${types[@]}"; do
    duti -s "$EDITOR_ID" "$type" all || {
        echo "Failed (VS Code): $type" >&2
        failed=1
    }
done

# Chrome: local files
BROWSER_ID="com.google.Chrome"

for ext in html xhtml php pdf; do
    duti -s "$BROWSER_ID" "$ext" all || {
        echo "Failed (Chrome): $ext" >&2
        failed=1
    }
done

(( failed )) && exit 1
echo "Default associations updated!"