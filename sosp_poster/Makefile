default: abstract.pdf

TMP_DVI_IMAGES = 
DVI_IMAGES = $(TMP_DVI_IMAGES)
TMP_PDF_IMAGES = 
PDF_IMAGES = $(TMP_PDF_IMAGES) 

OUTPUT_FILES = abstract.dvi abstract.pdf abstract.txt $(TMP_DVI_IMAGES)

TMP_FILES = $(TMP_PDF_IMAGES)

abstract.dvi abstract.pdf abstract.txt: \
	abstract.tex interfaces.tex chdescs.tex examples.tex abstract.bib

abstract.dvi: $(DVI_IMAGES)
abstract.pdf: $(PDF_IMAGES)

include Makefile_tex_base
