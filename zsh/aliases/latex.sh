# use latex template directory for report
mkrlt(){
	cp -r ~/.latex-template/latex-report-template ./"$1"
}

# use latex template directory for paper
mkplt(){
	cp -r ~/.latex-template/latex-paper-template ./"$1"
}

# use beamer template directory
mkbt(){
	cp -r ~/.latex-template/beamer-template ./"$1"
}
