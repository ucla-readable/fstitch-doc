default: paper.dvi paper.pdf

OUTPUT_FILES = \
   paper.dvi paper.pdf paper.pdf paper.txt

paper.dvi paper.pdf paper.txt: \
	paper.tex intro.tex problem.tex solution.tex solution-arch.tex \
	solution-impl.tex related.tex groups.tex evaluation.tex \
	future.tex conclusion.tex paper.bib

include Makefile_tex_base
