default: paper.pdf

TMP_DVI_IMAGES = fig/figures_1.eps fig/figures_2.eps fig/figures_3.eps \
				 fig/figures_4.eps fig/figures_5.eps fig/figures_6.eps \
				 fig/figures_7.eps fig/figures_8.eps fig/figures_9.eps \
				 fig/figures_10.eps
DVI_IMAGES = $(TMP_DVI_IMAGES)
TMP_PDF_IMAGES = fig/figures_1.pdf fig/figures_2.pdf fig/figures_3.pdf \
				 fig/figures_4.pdf fig/figures_5.pdf fig/figures_6.pdf \
				 fig/figures_7.pdf fig/figures_8.pdf fig/figures_9.pdf \
				 fig/figures_10.pdf
PDF_IMAGES = $(TMP_PDF_IMAGES)

OUTPUT_FILES = paper.dvi paper.ps paper.pdf paper.txt $(TMP_DVI_IMAGES)

TMP_FILES = $(TMP_PDF_IMAGES)

paper.dvi paper.pdf paper.txt: \
	paper.tex abstract.tex intro.tex consistency.tex journaling.tex softupdates.tex kudos.tex modules.tex interfaces.tex chdescs.tex ufs.tex implementation.tex evaluation.tex future.tex conclusion.tex ack.tex paper.bib kmaster.bib

bib:
	latex paper
	bibtex -min-crossrefs=100 paper

paper.dvi: $(DVI_IMAGES)
paper.pdf: $(PDF_IMAGES)

include Makefile_tex_base
