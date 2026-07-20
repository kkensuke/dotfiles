zipen() {
  if [ $# -lt 1 ]; then
    echo "Usage: zipen <file-or-folder>"
    return 1
  fi

  local target="$1"
  local base="$(basename "$target")"
  zip -er "enc_${base}.zip" "$target"
}
