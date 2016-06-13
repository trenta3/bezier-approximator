# Makefile per la compilazione del progetto LaTeX
# Creato lun 13 giu 2016, 15.28.42, CEST

.PHONY: alldocuments reference 

alldocuments: 
	wget https://github.com/trenta3/stdmdoc/raw/master/stdmdoc.cls -O stdmdoc.cls
	pdflatex --shell-escape reference.tex
	rm -f *.aux *.log *.out

reference:
	wget https://github.com/trenta3/stdmdoc/raw/master/stdmdoc.cls -O stdmdoc.cls
	pdflatex --shell-escape reference.tex
	rm -f *.aux *.log *.out

# Fine del Makefile
