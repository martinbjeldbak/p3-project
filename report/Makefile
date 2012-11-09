Report.pdf: rapport.tex
	xelatex rapport.tex
	bibtex rapport
	xelatex rapport.tex
	xelatex rapport.tex > texoutput
	grep Warning -i --color -n texoutput

