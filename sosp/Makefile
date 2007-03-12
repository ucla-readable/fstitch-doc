LATEX = latex
BIBTEX = bibtex
METAPOST = mpost
FIG2DEV = fig2dev
GNUPLOT = gnuplot
DVIPS = dvips -j0
PS2PDF = ps2pdf14
PDFLATEX = pdflatex

MAINFILE = paper.tex

TEXSRCS = abstract.tex chdescdiscuss.tex chdescs.tex conclusion.tex \
	discussion.tex evaluation.tex ext2.tex implementation.tex \
	interfaces.tex intro.tex journal.tex model.tex \
	modules.tex noop.tex nrbmerge.tex nrb.tex \
	opgroups.tex overlapmerge.tex paper.tex readylist.tex \
	related.tex softupdate.tex ufs.tex uhfs.tex \
	using.tex wbcache.tex

BIBS = paper.bib kmaster.bib

TMP_PDF_IMAGES = fig/figures_1.pdf fig/figures_2.pdf fig/figures_3.pdf \
	fig/figures_4.pdf fig/figures_5.pdf fig/figures_6.pdf \
	fig/figures_7.pdf opgroup_transitions.pdf \
	nrb_merge.pdf svn_opgroups.pdf
TMP_DVI_IMAGES = $(TMP_PDF_IMAGES:.pdf=.eps)

PDF_IMAGES = $(TMP_PDF_IMAGES)
DVI_IMAGES = $(TMP_DVI_IMAGES)

PDF_PRIMARY =

all: paper.dvi

paper.dvi: $(MAINFILE) $(MAINFILE:.tex=.bbl) $(DVI_IMAGES) always
	$(LATEX) $<
	@while grep Rerun paper.log >/dev/null 2>&1; do echo $(LATEX) $<; $(LATEX) $<; done

paper.pdf: $(MAINFILE) $(MAINFILE:.tex=.bbl) $(PDF_IMAGES) always
	$(PDFLATEX) $<
	@while grep Rerun paper.log >/dev/null 2>&1; do echo $(PDFLATEX) $<; $(PDFLATEX) $<; done

%.aux: %.tex $(TEXSRCS) $(DVI_IMAGES) fonts.sty
	$(LATEX) $<
bib: $(MAINFILE:.tex=.aux) always
	$(BIBTEX) -min-crossrefs=1000 $<
%.bbl: %.aux $(BIBS)
	$(MAKE) bib

%.ps: %.dvi
	$(DVIPS) $< -o $@

%.pdf: %.ps
	$(PS2PDF) $< $@
%.pdf: %.eps
	$(PS2PDF) $< $@
$(PDF_PRIMARY): %.eps: %.pdf
	epstopdf $< > $@

%.eps: %.gif
	giftopnm $< | pnmtops -noturn -nosetpage > $@
%.eps: %.png
	pngtopnm $< | pnmtops -noturn -nosetpage > $@
%.eps: %.jpg
	jpegtopnm $< | pnmtops -noturn -nosetpage > $@
%.ps: %.neato
	neato -Tps $< > $@
%.eps: %.dia
	dia --nosplash --export=$@ $<
%.eps: %.dot
	dot -Tps $< -o $@

%.pdf: %.dot
	dot -Tps2 $< | epstopdf -f > $@


# after making the figure, run perl to fix Computer Modern font names to
# uppercase
fig/%_1.eps fig/%_2.eps fig/%_3.eps fig/%_4.eps fig/%_5.eps fig/%_6.eps fig/%_7.eps fig/%_8.eps: fig/%.mp fig/elements.mp fig/elemfig.sty .fonts.sty
	cd fig ; TEX=$(LATEX) $(METAPOST) $(subst fig/,,$<)
	perl -pi -e 'next if $$x; $$x = 1 if /%%EndProlog/; s=/([a-z][a-z0-9]+) def=/\U$$1\E def= if !/^%%/; s=\b([a-z][a-z0-9]+)\b=\U$$1\E=g if /^%%DocumentFonts/ || /^%%\+/;' $(subst .mp,,$<).[0-9]*
	for i in $(subst .mp,,$<).[0-9]*; do mv $$i `echo "$$i" | sed 's/\.\([0-9]*\)$$/_\1.eps/'`; done

fonts.sty:
	echo '\usepackage{times,mathptmx}' >fonts.sty

.fonts.sty: fonts.sty
	rm -f fig/*.mpx
	cp fonts.sty .fonts.sty

clean: cleanfig
	/bin/rm -f *.log *.aux *.dvi *.bbl *.blg *.lof *.lot *.toc *~ \
	grammar.tab.c grammar.output

cleanfig:
	/bin/rm -f $(TMP_PDF_IMAGES) $(TMP_DVI_IMAGES) \
	fig/*.log fig/*.aux fig/*.dvi fig/*.mpx

.PHONY: all bib clean cleanfig clean-all always
