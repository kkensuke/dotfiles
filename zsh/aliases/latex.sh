# use latex template directory for article
mkalt(){
	cp -r ~/.latex-template/article-template ./"$1"
}

# use latex template directory for report
mkrlt(){
	cp -r ~/.latex-template/report-template ./"$1"
}

# use latex template directory for revtex4-2
mkvlt(){
	cp -r ~/.latex-template/revtex4-2-template ./"$1"
}

# use beamer template directory
mkbt(){
	cp -r ~/.latex-template/beamer-template ./"$1"
}
