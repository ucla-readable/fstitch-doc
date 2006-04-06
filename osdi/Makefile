default: paper.pdf

TMP_DVI_IMAGES =
DVI_IMAGES = $(TMP_DVI_IMAGES)
TMP_PDF_IMAGES =
PDF_IMAGES = $(TMP_PDF_IMAGES)

OUTPUT_FILES = paper.dvi paper.ps paper.pdf paper.txt $(TMP_DVI_IMAGES)

TMP_FILES = $(TMP_PDF_IMAGES)

paper.dvi paper.pdf paper.txt: \
	paper.tex abstract.tex opgroups.tex wbcache.tex ufs.tex journal.tex linux.tex paper.bib

bib:
	latex paper
	bibtex -min-crossrefs=100 paper

paper.dvi: $(DVI_IMAGES)
paper.pdf: $(PDF_IMAGES)

include Makefile_tex_base
