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
