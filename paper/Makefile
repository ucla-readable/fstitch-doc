default: paper.dvi paper.pdf

DVI_IMAGES = \
	kfsgraph_journal.eps kfsgraph_su_on_su.eps kfsgraph_journal_on_su.eps \
	kfsgraph_mount_pre.eps kfsgraph_mount_post.eps
PDF_IMAGES = \
	kfsgraph_journal.pdf kfsgraph_su_on_su.pdf kfsgraph_journal_on_su.pdf \
	kfsgraph_mount_pre.pdf kfsgraph_mount_post.pdf

OUTPUT_FILES = \
	paper.dvi paper.pdf paper.pdf paper.txt \
	$(DVI_IMAGES)

TMP_FILES = \
	$(PDF_IMAGES)

paper.dvi paper.pdf paper.txt: \
	paper.tex intro.tex problem.tex solution.tex solution-arch.tex \
	solution-impl.tex related.tex groups.tex evaluation.tex \
	future.tex conclusion.tex paper.bib

paper.dvi: $(DVI_IMAGES)
paper.pdf: $(PDF_IMAGES)

include Makefile_tex_base
