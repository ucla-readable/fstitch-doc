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
	paper.tex abstract.tex intro.tex related.tex design.tex chdescs.tex interfaces.tex modules.tex wbcache.tex ufs.tex ext2.tex consistency.tex softupdate.tex journal.tex opgroups.tex implementation.tex evaluation.tex discussion.tex conclusion.tex paper.bib kmaster.bib

bib:
	latex paper
	bibtex -min-crossrefs=100 paper

paper.dvi: $(DVI_IMAGES)
paper.pdf: $(PDF_IMAGES)

include Makefile_tex_base
