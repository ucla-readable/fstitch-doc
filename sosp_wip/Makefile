default: abstract.pdf

TMP_DVI_IMAGES = fig/whatevs_1.eps fig/whatevs_2.eps fig/whatevs_3.eps
DVI_IMAGES = $(TMP_DVI_IMAGES) rollback_sequence.eps
TMP_PDF_IMAGES = fig/whatevs_1.pdf fig/whatevs_2.pdf fig/whatevs_3.pdf
PDF_IMAGES = $(TMP_PDF_IMAGES) rollback_sequence.pdf

OUTPUT_FILES = abstract.dvi abstract.ps abstract.pdf abstract.txt $(TMP_DVI_IMAGES)

TMP_FILES = $(TMP_PDF_IMAGES)

abstract.dvi abstract.pdf abstract.txt: \
	abstract.tex intro.tex interfaces.tex chdescs.tex kfsgraph.tex future.tex abstract.bib sigmin.sty

bib:
	latex abstract
	bibtex -min-crossrefs=100 abstract

abstract.dvi: $(DVI_IMAGES)
abstract.pdf: $(PDF_IMAGES)

include Makefile_tex_base
