default: related.dvi

OUTPUT_FILES = \
   related.dvi related.pdf related.pdf related.txt

related.dvi: \
	related.tex intro.tex \
	stackable.tex semantic.tex softupdates.tex journaling.tex \
	related.bib

related.pdf: related.dvi
	pdflatex related.tex

include Makefile_tex_base
