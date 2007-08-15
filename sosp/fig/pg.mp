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

  z1 = a.c - (60,0);
  label.top(btex \mlabel{\textit{pg}\texttt{ =}\\\texttt{pg\char`\_create()}} etex scaled textscale, .5[z1,a.w]);
  drawconnarrow z1 -- a.c cutafter bpath.a;

  label(btex \mlabel{\texttt{pg\char`\_engage(}\textit{pg}\texttt{)}\\\lower1.5ex\hbox{~}} etex scaled textscale rotated angle(b.c-a.c), .5[b.c,a.c]);
  drawconnpatch(a,b)(..);

  label(btex \mlabel{\texttt{pg\char`\_depend(*,} \textit{pg}\texttt{)}\\\lower1.5ex\hbox{~}} etex scaled textscale rotated angle(d.c+(0,.9)-c.c), .5[c.c,d.c+(0,.9)]);
  drawconnpatch(c,d)(..d.c+(0,.9)--);

  label.top(btex \mlabel{\texttt{pg\char`\_disengage(}\textit{pg}\texttt{)}} etex scaled textscale, .5[b.c,c.c]+(0,2));
  drawconnpatch(b,c)({dir 15}..);

  label.bot(btex \mlabel{\texttt{pg\char`\_engage(}\textit{pg}\texttt{)}} etex scaled textscale, .5[b.c,c.c]-(0,2));
  drawconnpatch(c,b)({dir -165}..);

  label.bot(btex \mlabel{\texttt{pg\char`\_depend(*,} \textit{pg}\texttt{)}} etex scaled textscale, .5[a.c,d.c]+(0,-9));
  drawconnpatch(a,d)(.. .5[a.c,d.c]+(0,-11) ..);

  label.bot(btex \mlabel{\texttt{pg\char`\_depend(}\textit{pg}\texttt{,} \texttt{*)}} etex scaled textscale, a.c-(0,11));
  drawconnpatch(a,a)({dir -165}..a.c-(10,10)..a.c-(0,13)..a.c-(-10,10)..{dir 165});

  label.bot(btex \mlabel{\texttt{pg\char`\_depend(*,} \textit{pg}\texttt{)}} etex scaled textscale, d.c-(0,11));
  drawconnpatch(d,d)({dir -165}..d.c-(10,10)..d.c-(0,13)..d.c-(-10,10)..{dir 165});

  z2 = b.c - (20,-14);
  label.lft(btex \lmlabel{\emph{Engaged} state} etex scaled 0.75, z2);
  drawconnarrowna z2 {right} .. {dir -45} b.nw withpen connectionpen scaled 2 dashed withdots scaled 0.5;
endfig;

beginfig(2);
  boxjoin(a.width = b.width; a.height = b.height; a.s - b.n = (0,8));
  elementit.a(btex \mlabel{write copy\strut} etex, 0, 0, push);
  elementit.b(btex \mlabel{write copy\strut} etex, 0, 0, push);
  elementit.c(btex \mlabel{write copy\strut} etex, 0, 0, push);
  a.dx = 10; a.dy = 2;

  boxjoin();
  elementit.d(btex \mlabel{delete\\originals} etex, 0, 0, push);
  d.width = c.width;
  c.sw - d.ne = (20,5);

  drawelement(a,b,c,d);
  
endfig;

end
