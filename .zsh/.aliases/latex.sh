# use latex template directory for report
mkrlt(){
	cp -r ~/.latex-report-template ./"$1"
}

# use latex template directory for paper
mkplt(){
	cp -r ~/.latex-paper-template ./"$1"
}

# use beamer template directory
mkbt(){
	cp -r ~/.beamer-template ./"$1"
}
