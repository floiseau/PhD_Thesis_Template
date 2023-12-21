.PHONY: pdfs/PhD_thesis.pdf pdfs/titlepage.pdf

pdfs/PhD_thesis.pdf: pdfs/titlepage.pdf chapters/*.tex
	mkdir -p build/build
	latexmk --shell-escape -logfilewarnings -pdf --output-directory=build PhD_Thesis.tex
	cp build/PhD_Thesis.pdf pdfs/

pdfs/titlepage.pdf: chapters/titlepage/titlepage.tex
	cd chapters/titlepage && latexmk --shell-escape -pdf --output-directory=../../build titlepage.tex
	cp build/titlepage.pdf pdfs/titlepage.pdf

