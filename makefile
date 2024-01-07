.PHONY: main titlepage

main:
	mkdir -p build/build
	latexmk --shell-escape -logfilewarnings -pdf --output-directory=build PhD_Thesis.tex
	cp build/PhD_Thesis.pdf pdfs/

titlepage:
	cd chapters/titlepage && latexmk --shell-escape -pdf --output-directory=../../build titlepage.tex
	cp build/titlepage.pdf pdfs/titlepage.pdf

