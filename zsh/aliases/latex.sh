# use latex template directory for article
mkalt(){
    cp -r ~/.latex-template/article ./"$1"
}

# use latex template directory for report
mkrlt(){
    cp -r ~/.latex-template/report ./"$1"
}

# use latex template directory for revtex4-2
mkvlt(){
    cp -r ~/.latex-template/revtex4-2 ./"$1"
}

# use beamer template directory
mkbt(){
    cp -r ~/.latex-template/beamer ./"$1"
}

alias tbuild="cp ../main.pdf main.pdf; jb build .; gmtn; ghp-import -n -p -f _build/html"