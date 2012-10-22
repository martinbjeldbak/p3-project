Report.pdf: rapport.tex
	pdflatex rapport.tex
	bibtex rapport
	pdflatex rapport.tex
	pdflatex rapport.tex > texoutput
	grep Warning -i --color -n texoutput

