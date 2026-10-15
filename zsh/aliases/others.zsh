replace_buffer_with_its_output(){
    BUFFER=$(sed -e $'s/\x1b\[[0-9;]*m//g' <<< $(eval $BUFFER))
    CURSOR=0 # ${#BUFFER}
    zle redisplay
}
zle -N replace_buffer_with_its_output
bindkey "^j" replace_buffer_with_its_output


url(){
    echo "[InternetShortcut]\nURL=$1" > "$2".url
}


zipen() {
    if [ $# -lt 1 ]; then
        echo "Usage: zipen <file-or-folder>"
    return 1
    fi

    local target="$1"
    local base="$(basename "$target")"
    zip -er "enc_${base}.zip" "$target"
}


# Get charger wattage
WATTAGE=$(system_profiler SPPowerDataType | grep "Wattage" | awk '{print $3}')
alias wat='echo "⚡${WATTAGE}W"'


memo() {
    if [ $# -lt 1 ]; then
        printf 'Usage: memo <text>\n'
        return 1
    fi

    printf '\n- %s\n' "$*" >> ~/MyDrive/temp/memo.md
}
alias cm='cat ~/MyDrive/temp/memo.md'
alias om='code ~/MyDrive/temp/memo.md'


ignore() {
    if [ $# -lt 1 ]; then
        echo "Usage: ignore <file-or-folder>"
        return 1
    fi

    local REPO_NAME=$(basename "$(git rev-parse --show-toplevel)")
    mkdir -p ~/github/ignore/$REPO_NAME
    mv $1 ~/github/ignore/$REPO_NAME/
    ln -sf ~/github/ignore/$REPO_NAME/$1 $1
}



wf() {
  local ports=$(networksetup -listallhardwareports 2>/dev/null)
  local wifi_dev=$(awk '/Wi-Fi|AirPort/{getline; print $2; exit}' <<<"$ports")
  local power=$(networksetup -getairportpower "${wifi_dev:-en0}" 2>/dev/null)
  printf 'Wi-Fi: %s\n' "${power##*: }"

  local iface=$( (route -n get default; route -n get -inet6 default) 2>/dev/null | awk '/interface:/{print $2; exit}')
  [[ -z $iface ]] && { printf 'Connection: None (no default route)\n'; return; }

  local conn=$(awk -v d="$iface" '/Hardware Port:/{p=substr($0,16)} $2==d{print p; exit}' <<<"$ports")
  printf 'Connection: %s\n' "${conn:-VPN or Other}"

  if [[ $iface == "$wifi_dev" ]]; then
    local ssid=$(ipconfig getsummary "$iface" 2>/dev/null | awk -F' : ' '/^[[:space:]]*SSID :/{print $2; exit}')
    [[ -z $ssid || $ssid == "<redacted>" ]] && ssid="Unavailable"
    printf 'SSID: %s\n' "$ssid"
  fi

  local ip=$(ipconfig getifaddr "$iface" 2>/dev/null)
  [[ -n $ip ]] && printf 'IPv4: %s\n' "$ip"
}