default: paper.pdf

TMP_DVI_IMAGES = kfsgraph_journal.eps kfsgraph_su_on_su.eps kfsgraph_journal_on_su.eps kfsgraph_mount.eps nakedsanta.eps loc_graph.eps journal_diagram.eps
DVI_IMAGES = $(TMP_DVI_IMAGES)
TMP_PDF_IMAGES = kfsgraph_journal.pdf kfsgraph_su_on_su.pdf kfsgraph_journal_on_su.pdf kfsgraph_mount.pdf
PDF_IMAGES = $(TMP_PDF_IMAGES) nakedsanta.pdf loc_graph.pdf journal_diagram.pdf

OUTPUT_FILES = paper.dvi paper.pdf paper.pdf paper.txt $(TMP_DVI_IMAGES)

TMP_FILES = $(TMP_PDF_IMAGES)

paper.dvi paper.pdf paper.txt: \
	paper.tex intro.tex problem.tex solution.tex solution-arch.tex \
	solution-impl.tex related.tex groups.tex evaluation.tex \
	future.tex conclusion.tex paper.bib

paper.dvi: $(DVI_IMAGES)
paper.pdf: $(PDF_IMAGES)

include Makefile_tex_base


# HACK: the pdf files are the originals here, convert pdf to eps and leave
# the original pdfs alone.
# TODO: how can we remove the %.pdf : %.eps rule for these three?

nakedsanta.eps: nakedsanta.pdf
	$(call convert-to-eps,$<,$@)
loc_graph.eps: loc_graph.pdf
	$(call convert-to-eps,$<,$@)
journal_diagram.eps: journal_diagram.pdf
	$(call convert-to-eps,$<,$@)

nakedsanta.pdf: nakedsanta.pdf
	echo $<
loc_graph.pdf: loc_graph.pdf
	echo $<
journal_diagram.pdf: journal_diagram.pdf
	echo $<
