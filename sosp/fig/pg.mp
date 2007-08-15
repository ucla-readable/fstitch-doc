input patches;
verbatimtex %&latex
\documentclass[12pt]{article}
\usepackage{elemfig,amsmath}
\def\subj{\setbox0\hbox{$_{\mbox{J}}$}\dp0=0pt\box0}
\begin{document}
etex;
picture emptyqueue; emptyqueue := btex \phantom{\elementlabel{Queue}} etex;
picture vemptyqueue; vemptyqueue := emptyqueue rotated 90 xscaled .4;

personalitycolor[7] = 0.9white;

beginfig(1);
  boxjoin(a.width = b.width; a.height = b.height);
  patchit.a(btex etex, 0);
  patchit.b(btex etex, 0);
  patchit.c(btex etex, 0);
  patchit.d(btex etex, 0);

  d.width = d.height;
  d.dx = -10;

  d.c - a.c = (240,0);
  c.c - b.c = (80,0);
  .5[c.c,b.c] - .5[a.c,d.c] = (0,9);

  fillelement(b)(0.5white);
  drawelement(a,b,c,d);

  save textscale; textscale = 0.7;

  z1 = a.c - (65,0);
  label.top(btex \mlabel{\pgPg\ \texttt{=} \texttt{pg\char`\_create()}} etex scaled textscale, .5[z1,a.w]);
  drawconnarrow z1 -- a.c cutafter bpath.a;

  label(btex \mlabel{\texttt{pg\char`\_engage(\pgPg)}\\\lower1.5ex\hbox{~}} etex scaled textscale rotated angle(b.c-a.c), .5[b.c,a.c]);
  drawconnpatch(a,b)(..);

  label(btex \mlabel{\texttt{pg\char`\_depend(*, \pgPg)}\\\lower1.5ex\hbox{~}} etex scaled textscale rotated angle(d.c+(0,.9)-c.c), .5[c.c,d.c+(0,.9)]);
  drawconnpatch(c,d)(..d.c+(0,.9)--);

  label.top(btex \mlabel{\texttt{pg\char`\_disengage(\pgPg)}} etex scaled textscale, .5[b.c,c.c]+(0,2));
  drawconnpatch(b,c)({dir 15}..);

  label.bot(btex \mlabel{\texttt{pg\char`\_engage(\pgPg)}} etex scaled textscale, .5[b.c,c.c]-(0,2));
  drawconnpatch(c,b)({dir -165}..);

  label.bot(btex \mlabel{\texttt{pg\char`\_depend(*, \pgPg)}} etex scaled textscale, .5[a.c,d.c]+(0,-9));
  drawconnpatch(a,d)(.. .5[a.c,d.c]+(0,-11) ..);

  label.bot(btex \mlabel{\texttt{pg\char`\_depend(\pgPg, *)}} etex scaled textscale, a.c-(0,11));
  drawconnpatch(a,a)({dir -155}..a.c-(10,10)..a.c-(0,13)..a.c-(-10,10)..{dir 155});

  label.bot(btex \mlabel{\texttt{pg\char`\_depend(*, \pgPg)}} etex scaled textscale, d.c-(0,11));
  drawconnpatch(d,d)({dir -155}..d.c-(10,10)..d.c-(0,13)..d.c-(-10,10)..{dir 155});

  z2 = b.c - (20,-14);
  label.lft(btex \lmlabel{\emph{Engaged} state} etex scaled 0.75, z2);
  drawconnarrowna z2 {right} .. {dir -45} b.nw withpen connectionpen scaled 2 dashed withdots scaled 0.5;
endfig;

beginfig(2);
  boxjoin(a.width = b.width; a.height = b.height; a.s - b.n = (0,22));
  elementit.a(btex \mlabel{write copy\strut} etex, 0, 0, push);
  elementit.b(btex \mlabel{write copy\strut} etex, 0, 0, push);
  elementit.c(btex \mlabel{write copy\strut} etex, 0, 0, push);
  a.dx = 10; a.dy = 2;

  boxjoin();
  elementit.d(btex \mlabel{delete\\originals} etex, 0, 0, push);
  d.width = c.width;
  c.sw - d.ne = (20,28);

  drawelement(a,b,c,d);
  label.bot(btex \texttt{fsync} etex scaled 0.8, a.s);
  label.bot(btex \texttt{fsync} etex scaled 0.8, b.s);
  label.bot(btex \texttt{fsync} etex scaled 0.8, c.s);
  label.bot(btex \texttt{fsync} etex scaled 0.8, d.s);

  label.lft(btex \texttt{COPY}$_1$ $\Bigg\{$ etex scaled 0.85, .5[a.nw,a.sw-(0,14)]);
  label.lft(btex \texttt{COPY}$_2$ $\Bigg\{$ etex scaled 0.85, .5[b.nw,b.sw-(0,14)]);
  label.lft(btex \texttt{COPY}$_3$ $\Bigg\{$ etex scaled 0.85, .5[c.nw,c.sw-(0,14)]);

  label.rt(btex $\left.\vcenter to 46pt{}\right\}$ \texttt{EXPUNGE} etex scaled 0.85, d.e);
  label.rt(btex \kern2pt$\}$\kern3pt~\texttt{CHECK} etex scaled 0.85, d.se - (0,7));
  
  label.top(btex \texttt{mailbox.dst} etex, a.n + (0,4));
  label.top(btex \texttt{mailbox.src} etex, (xpart d.n,ypart a.n) + (0,4));

  z1 = (xpart d.w - 10, ypart a.n);
  z2 = (x1, ypart d.s - 4);
  drawconnarrow z1 -- z2;
  label.lft(btex Time etex rotated 90, .5[z1,z2]);
endfig;

beginfig(3);
  boxjoin(a.width = b.width; a.height = b.height; a.s - b.n = (0,22));
  elementit.a(btex \mlabel{write copy\strut} etex, 0, 0, push);
  elementit.b(btex \mlabel{write copy\strut} etex, 0, 0, push);
  elementit.c(btex \mlabel{write copy\strut} etex, 0, 0, push);
  a.dx = 10; a.dy = 2;

  boxjoin();
  elementit.d(btex \mlabel{delete\\originals} etex, 0, 0, push);
  d.width = c.width;
  c.sw - d.ne = (20,28);

  drawelement(a,b,c,d);
  label.bot(btex \texttt{pg\char`\_sync(EXPUNGE)} etex scaled 0.8, d.s);

  label.lft(btex \texttt{COPY}$_1$ $\Big\{$ etex scaled 0.85, .5[a.nw,a.sw]);
  label.lft(btex \texttt{COPY}$_2$ $\Big\{$ etex scaled 0.85, .5[b.nw,b.sw]);
  label.lft(btex \texttt{COPY}$_3$ $\Big\{$ etex scaled 0.85, .5[c.nw,c.sw]);

  label.rt(btex $\left.\vcenter to 46pt{}\right\}$ \texttt{EXPUNGE} etex scaled 0.85, d.e);
  label.rt(btex \kern2pt$\}$\kern3pt~\texttt{CHECK} etex scaled 0.85, d.se - (0,7));
  
  label.top(btex \texttt{mailbox.dst} etex, a.n + (0,4));
  label.top(btex \texttt{mailbox.src} etex, (xpart d.n,ypart a.n) + (0,4));

  z1 = (xpart d.w - 10, ypart a.n);
  z2 = (x1, ypart d.s - 4);
  drawconnarrow z1 -- z2;
  label.lft(btex Time etex rotated 90, .5[z1,z2]);

  drawconnpatch(b,a)(..);
  label.lft(btex \texttt{pg\char`\_depend(COPY}$_2$\texttt{, COPY}$_1$\texttt{)}\strut etex scaled 0.8, .5[a.s,b.n]-(4,0));
  
  drawconnpatch(c,b)(..);
  label.lft(btex \texttt{pg\char`\_depend(COPY}$_3$\texttt{, COPY}$_2$\texttt{)}\strut etex scaled 0.8, .5[b.s,c.n]-(4,0));

  drawconnpatch(d,c)(..d.n{up}..tension 1.5 and 3..{up}c.s..);
  label.lrt(btex \lmlabel{\texttt{pg\char`\_depend}\\\quad\texttt{(EXPUNGE, COPY}$_3$\texttt{)}} etex scaled 0.8, c.sw-(10,5));
endfig;

end
