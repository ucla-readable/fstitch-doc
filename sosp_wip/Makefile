default: abstract.pdf

TMP_DVI_IMAGES = fig/whatevs_1.eps fig/whatevs_2.eps
DVI_IMAGES = $(TMP_DVI_IMAGES)
TMP_PDF_IMAGES = fig/whatevs_1.pdf fig/whatevs_2.pdf
PDF_IMAGES = $(TMP_PDF_IMAGES) 

OUTPUT_FILES = abstract.dvi abstract.pdf abstract.txt $(TMP_DVI_IMAGES)

TMP_FILES = $(TMP_PDF_IMAGES)

abstract.dvi abstract.pdf abstract.txt: \
	abstract.tex intro.tex interfaces.tex chdescs.tex kfsgraph.tex future.tex abstract.bib sigplan-proc.cls

bib:
	latex abstract
	bibtex -min-crossrefs=100 abstract

abstract.dvi: $(DVI_IMAGES)
abstract.pdf: $(PDF_IMAGES)

include Makefile_tex_base
