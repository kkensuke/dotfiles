#!/bin/bash

EDITOR_ID="com.microsoft.VSCode"

# Basic text types
duti -s $EDITOR_ID public.plain-text all
duti -s $EDITOR_ID public.text all
duti -s $EDITOR_ID public.source-code all

# Common file extensions
extensions=("txt" "md" "tex" "js" "jsx" "ts" "tsx" "py" "go" "rs" "c" "cpp" "h" "hpp" "css" "json" "yaml" "yml" "xml" "sh" "zsh" "bash")

for ext in "${extensions[@]}"; do
    duti -s $EDITOR_ID $ext all
done

echo "Default editor associations updated!"