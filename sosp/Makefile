default: paper.pdf

TMP_DVI_IMAGES = fig/figures_1.eps fig/figures_2.eps fig/figures_3.eps \
				 fig/figures_4.eps fig/figures_5.eps fig/figures_6.eps \
				 fig/figures_7.eps opgroup_transitions.eps \
				 nrb_merge.eps
DVI_IMAGES = $(TMP_DVI_IMAGES)
TMP_PDF_IMAGES = fig/figures_1.pdf fig/figures_2.pdf fig/figures_3.pdf \
				 fig/figures_4.pdf fig/figures_5.pdf fig/figures_6.pdf \
				 fig/figures_7.pdf opgroup_transitions.pdf \
				 nrb_merge.pdf
PDF_IMAGES = $(TMP_PDF_IMAGES)

OUTPUT_FILES = paper.dvi paper.ps paper.pdf paper.txt $(TMP_DVI_IMAGES)

TMP_FILES = $(TMP_PDF_IMAGES)

paper.dvi paper.pdf paper.txt: \
	abstract.tex chdescs.tex conclusion.tex discussion.tex \
	evaluation.tex ext2.tex implementation.tex interfaces.tex \
	intro.tex journal.tex modules.tex opgroups.tex paper.tex \
	related.tex softupdate.tex ufs.tex uhfs.tex using.tex \
	wbcache.tex paper.bib kmaster.bib

bib:
	latex paper
	bibtex -min-crossrefs=100 paper

paper.dvi: $(DVI_IMAGES)
paper.pdf: $(PDF_IMAGES)

include Makefile_tex_base
