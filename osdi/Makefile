default: paper.pdf

TMP_DVI_IMAGES = fig/figures_1.eps fig/figures_2.eps fig/figures_3.eps
DVI_IMAGES = $(TMP_DVI_IMAGES)
TMP_PDF_IMAGES = fig/figures_1.pdf fig/figures_2.pdf fig/figures_3.pdf
PDF_IMAGES = $(TMP_PDF_IMAGES)

OUTPUT_FILES = paper.dvi paper.ps paper.pdf paper.txt $(TMP_DVI_IMAGES)

TMP_FILES = $(TMP_PDF_IMAGES)

paper.dvi paper.pdf paper.txt: \
	paper.tex abstract.tex intro.tex chdescs.tex interfaces.tex softupdate.tex wbcache.tex opgroups.tex ufs.tex journal.tex linux.tex evaluation.tex future.tex paper.bib

bib:
	latex paper
	bibtex -min-crossrefs=100 paper

paper.dvi: $(DVI_IMAGES)
paper.pdf: $(PDF_IMAGES)

include Makefile_tex_base
