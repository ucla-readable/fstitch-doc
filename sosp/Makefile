LATEX = latex
BIBTEX = bibtex
METAPOST = mpost
FIG2DEV = fig2dev
GNUPLOT = gnuplot
DVIPS = dvips -j0
PS2PDF = ps2pdf14
EPS2PDF = epstopdf
PDFLATEX = pdflatex

MAINFILE = paper.tex

TEXSRCS = abstract.tex acknowledge.tex conclusion.tex evaluation.tex \
	implementation.tex optimizations.tex intro.tex journal.tex \
	modules.tex noop.tex nrb.tex merge.tex misc.tex opgroups.tex \
	paper.tex readylist.tex related.tex using.tex wbcache.tex \
	patch.tex svnversion.tex

BIBS = paper.bib kmaster.bib

TMP_PDF_IMAGES = fig/figures_1.pdf fig/figures_2.pdf fig/figures_3.pdf \
        fig/figures_4.pdf fig/figures_5.pdf fig/figures_6.pdf \
	fig/figures_7.pdf fig/pg_1.pdf fig/pg_2.pdf fig/pg_3.pdf \
	fig/opt_1.pdf fig/opt_2.pdf fig/opt_3.pdf fig/opt_4.pdf \
	fig/softhard_1.pdf fig/softhard_2.pdf fig/softhard_3.pdf \
	fig/examples_1.pdf fig/examples_2.pdf \
	fig/examplesb_1.pdf fig/examplesb_2.pdf fig/examplesb_3.pdf \
	fig/examplesb_4.pdf
TMP_DVI_IMAGES = $(TMP_PDF_IMAGES:.pdf=.eps)

PDF_IMAGES = $(TMP_PDF_IMAGES)
DVI_IMAGES = $(TMP_DVI_IMAGES)

PDF_PRIMARY =

all: paper.pdf paper.dvi

paper.dvi: $(MAINFILE) $(MAINFILE:.tex=.bbl) $(DVI_IMAGES) svnversion.tex
	$(LATEX) $<
	@while grep Rerun paper.log >/dev/null 2>&1; do echo $(LATEX) $<; $(LATEX) $<; done
	touch -r paper.bbl paper.aux

paper.pdf: $(MAINFILE) $(MAINFILE:.tex=.bbl) $(PDF_IMAGES) svnversion.tex
	$(PDFLATEX) $<
	@while grep Rerun paper.log >/dev/null 2>&1; do echo $(PDFLATEX) $<; $(PDFLATEX) $<; done
	touch -r paper.bbl paper.aux

svnversion.tex: svnversion.tmpl always
	sed "s/SVNVERSION/`svnversion .`/" svnversion.tmpl > svnversion.tmp
	cmp -s svnversion.tmp svnversion.tex && rm svnversion.tmp || mv svnversion.tmp svnversion.tex

%.aux: %.tex $(TEXSRCS) $(DVI_IMAGES) fonts.sty
	$(LATEX) $<
bib: $(MAINFILE:.tex=.aux) $(BIBS)
	$(BIBTEX) -min-crossrefs=1000 $<
%.bbl: %.aux $(BIBS)
	$(MAKE) bib

%.ps: %.dvi
	TEXCONFIG=.:`kpsewhich --show-path 'dvips config'` \
		$(DVIPS) -Pmathpical $< -o $@

%.pdf: %.ps
	$(EPS2PDF) $< -o $@
%.pdf: %.eps
	$(EPS2PDF) $< -o $@
# $(PDF_PRIMARY): %.eps: %.pdf
#	epstopdf $< > $@

%.eps: %.gif
	giftopnm $< | pnmtops -noturn -nosetpage > $@
%.eps: %.png
	pngtopnm $< | pnmtops -noturn -nosetpage > $@
%.eps: %.jpg
	jpegtopnm $< | pnmtops -noturn -nosetpage > $@
%.eps: %.neato
	neato -Tps $< > $@
%.eps: %.gp data/%
	(cd `dirname "$<"`; ./$<)
%.eps: %.dia
	dia --nosplash --export=$@ $<
%.eps: %.dot
	dot -Tps $< > $@

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
	grammar.tab.c grammar.output .fonts.sty svnversion.tex paper.out paper.ps paper.pdf paper.dvi

cleanfig:
	/bin/rm -f $(TMP_PDF_IMAGES) $(TMP_DVI_IMAGES) \
	fig/*.log fig/*.aux fig/*.dvi fig/*.mpx

.PHONY: all bib clean cleanfig clean-all always
