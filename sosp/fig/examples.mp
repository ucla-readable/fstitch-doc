input patches;
verbatimtex %&latex
\documentclass[12pt]{article}
\usepackage{elemfig,amsmath}

\begin{document}
etex;
picture emptyqueue; emptyqueue := btex \phantom{\elementlabel{Queue}} etex;
picture vemptyqueue; vemptyqueue := emptyqueue rotated 90 xscaled .4;
hardborderscale = 3;
color blockcolor; blockcolor = 0.8white;
def blockbox(text t) = draw t withpen pencircle scaled 3 withcolor blockcolor enddef;

vardef drawconnpatchx(suffix $,$$)(text conn) text rest =
  save oahlength; oahlength = ahlength; ahlength := oahlength/3;
  drawconnpatch($,$$)(conn) withpen connectionpen scaled 5 withcolor white;
  ahlength := oahlength;
  drawconnpatch($,$$)(conn) rest
enddef;

beginfig(1);
  boxjoin(a.width = b.width = a.height);
  patchit.d1(btex $d_1$\strut etex, 0);
  d1.dx=10;

  boxjoin(a.width = b.width = a.height);
  patchit.bk1(btex $i_1$\strut etex, 0);
  patchit.sz1(btex $i_1'$\strut etex, 0);
  bk1.dx=6;

  boxjoin(a.width = b.width = a.height);
  patchit.bi1(btex $b_1$\strut etex, 0);
  bi1.dx=4;

  boxjoin(a.width = b.width = a.height; b.w - a.e = (21,0));
  patchit.jd1(btex $d_{1\text{J}}$\strut etex, 0);
  patchit.ji1(btex $i_{1\text{J}}$\strut etex, 0);
  patchit.jb1(btex $b_{1\text{J}}$\strut etex, 0);
  patchit.jc1(btex $\textit{cmt}_1$\strut etex, 0);
  jd1.dx=10;

  jc1.height=jc1.width; bi1.height=bi1.width; d1.height=d1.width; sz1.height=sz1.width;

  bk1.s - sz1.n = (0,5);
  .5[bk1.w,sz1.w] - bi1.e = (47.5,0);
  d1.w - .5[bk1.e,sz1.e] = (47.5,0);

  .5[jd1.s,jc1.s] - (xpart .5[bi1.w,d1.e], ypart bk1.n) = (0,36);
  
  drawelement(d1,bk1,sz1,bi1,jd1,ji1,jb1,jc1);

  d = e = 8; d'=22;
  forsuffixes $=jd1,ji1,jb1,jc1:
    blockbox($.nw+(-e,d') -- $.ne+(e,d') -- $.se+(e,-d) -- $.sw+(-e,-d) -- cycle);
  endfor;
  y3=ypart(jc1.s+(0,-d));
  label.top(btex \textsc{Journal} etex, .5[jd1.nw+(0,d'),jc1.ne+(0,d')]+(0,5));
  label.top(btex \mlabel{journaled\\data block} etex scaled 0.65, jd1.n-(0,2));
  label.top(btex \mlabel{journaled\\inode block} etex scaled 0.65, ji1.n-(0,2));
  label.top(btex \mlabel{journaled\\bitmap block} etex scaled 0.65, jb1.n-(0,2));
  label.top(btex \mlabel{commit\\record} etex scaled 0.65, jc1.n-(0,2));
  label.rt(btex \dots etex scaled 0.7, jc1.e+(e,5));

  y1=(ypart bk1.n)+6; y2=(ypart sz1.s)-6;

  linecap := butt;
  draw (xpart jd1.w-20,.5[y1,y3]) -- (xpart jc1.e+20,.5[y1,y3]) withpen connectionpen scaled .5 withcolor blockcolor;

  x1=(xpart bi1.w)-8; x2=(xpart bi1.e)+8;
  %label.bot(btex \textsc{Main File System} etex, .5[(xpart jd1.s,y2),(xpart jc1.s,y2)]-(0,16));
  blockbox((x1,y1) -- (x2,y1) -- (x2,y2) -- (x1,y2) -- cycle);
  label.bot(btex \mlabel{bitmap block}\strut etex scaled 0.9, (.5[x1,x2],y2-1));

  x1:=(xpart bk1.w)-6; x2:=(xpart bk1.e)+6;
  blockbox((x1,y1) -- (x2,y1) -- (x2,y2) -- (x1,y2) -- cycle);
  label.bot(btex \mlabel{inode block}\strut etex scaled 0.9, (.5[x1,x2],y2-1));

  d := 8; e := 8;
  x1:=(xpart d1.w)-8; x2:=(xpart d1.e)+8;
  blockbox((x1,y1) -- (x2,y1) -- (x2,y2) -- (x1,y2) -- cycle);
  label.bot(btex \mlabel{data block}\strut etex scaled 0.9, (.5[x1,x2],y2-1));

  drawconnpatch(jc1,jd1)({dir -135}..{dir 155});
  drawconnpatch(jc1,ji1)({dir -145}..{dir 135});
  drawconnpatch(jc1,jb1)(..);
  drawconnpatch(d1,jc1)(..{dir 85});
  drawconnpatch(sz1,jc1)(..{dir 75});
  drawconnpatch(bk1,jc1)(..{dir 62});
  drawconnpatch(bi1,jc1)({dir 60}..{dir 55});
endfig;

beginfig(2);
  boxjoin(a.width = b.width = a.height);
  patchit.d1(btex $d_1$\strut etex, 0);
  d1.dx=10;

  boxjoin(a.width = b.width = a.height);
  patchit.bk1(btex $i_1$\strut etex, 0);
  patchit.sz1(btex $i_1'$\strut etex, 0);
  bk1.dx=6;

  boxjoin(a.width = b.width = a.height);
  patchit.bi1(btex $b_1$\strut etex, 0);
  bi1.dx=4;

  boxjoin(a.width = b.width = a.height; b.w - a.e = (21,0));
  patchit.jd1(btex $d_{1\text{J}}$\strut etex, 0);
  patchit.ji1(btex $i_{1\text{J}}$\strut etex, 0);
  patchit.jb1(btex $b_{1\text{J}}$\strut etex, 0);
  patchit.jc1(btex $\textit{cmt}_1$\strut etex, 0);
  boxjoin();
  patchit.jcp1(btex $\textit{cmp}_1$\strut etex, 0);
  jd1.dx=10;
  jc1.width=jcp1.width;jc1.height=jcp1.height;

  jc1.height=jc1.width; bi1.height=bi1.width; d1.height=d1.width; sz1.height=sz1.width;

  bk1.s - sz1.n = (0,5);
  .5[bk1.w,sz1.w] - bi1.e = (47.5,0);
  d1.w - .5[bk1.e,sz1.e] = (47.5,0);

  .5[jd1.s,jc1.s] - (xpart .5[bi1.w,d1.e], ypart bk1.n) = (0,36);
  jcp1.c = jc1.c + (2,14);
  
  fixelement(d1,bk1,sz1,bi1,jd1,ji1,jb1,jc1,jcp1);

  save p; picture p; p = nullpicture;
  drawelement(jc1);
  clip currentpicture to bpath.jcp1;
  addto p also currentpicture withcolor 0.9white;
  currentpicture := nullpicture;
  drawelement(jc1);
  path pp[];
  pp1 := jc1.n+(0,3) -- jc1.nw+(-10,3);
  pp2 := reverse (reverse bpath.jcp1 cutafter pp1);
  pp3 := pp2 -- ((point infinity of pp2) - (0,100)) -- ((point 0 of pp2) - (100,100)) -- cycle;
  clip currentpicture to pp3;
  addto currentpicture also p;

  d := 8; e := 8; d' := 22;
  forsuffixes $=jd1,ji1,jb1,jc1:
    blockbox($.nw+(-e,d') -- $.ne+(e,d') -- $.se+(e,-d) -- $.sw+(-e,-d) -- cycle);
  endfor;
  y3=ypart(jc1.s+(0,-d));
  label.top(btex \textsc{Journal} etex, .5[jd1.nw+(0,d'),jc1.ne+(0,d')]+(0,5));
  label.top(btex \mlabel{journaled\\data block} etex scaled 0.65, jd1.n-(0,2));
  label.top(btex \mlabel{journaled\\inode block} etex scaled 0.65, ji1.n-(0,2));
  label.top(btex \mlabel{journaled\\bitmap block} etex scaled 0.65, jb1.n-(0,2));
  %label.top(btex \mlabel{commit\\record} etex scaled 0.65, jc1.n-(0,2));
  label.rt(btex \dots etex scaled 0.7, jc1.e+(e,5));
  label.top(btex \mlabel{completion record} etex scaled 0.65, jcp1.n+(3,8));
  draw (jcp1.n+(3,11) -- jcp1.c) cutafter bpath.jcp1 withpen connectionpen scaled 0.5;
  
  
  y1=(ypart bk1.n)+6; y2=(ypart sz1.s)-6;

  linecap := butt;
  draw (xpart jd1.w-20,.5[y1,y3]) -- (xpart jc1.e+20,.5[y1,y3]) withpen connectionpen scaled .5 withcolor blockcolor;

  x1=(xpart bi1.w)-8; x2=(xpart bi1.e)+8;
  %label.bot(btex \textsc{Main File System} etex, .5[(xpart jd1.s,y2),(xpart jc1.s,y2)]-(0,16));
  blockbox((x1,y1) -- (x2,y1) -- (x2,y2) -- (x1,y2) -- cycle);
  label.bot(btex \mlabel{bitmap block}\strut etex scaled 0.9, (.5[x1,x2],y2-1));

  x1:=(xpart bk1.w)-6; x2:=(xpart bk1.e)+6;
  blockbox((x1,y1) -- (x2,y1) -- (x2,y2) -- (x1,y2) -- cycle);
  label.bot(btex \mlabel{inode block}\strut etex scaled 0.9, (.5[x1,x2],y2-1));

  d := 8; e := 8;
  x1:=(xpart d1.w)-8; x2:=(xpart d1.e)+8;
  blockbox((x1,y1) -- (x2,y1) -- (x2,y2) -- (x1,y2) -- cycle);
  label.bot(btex \mlabel{data block}\strut etex scaled 0.9, (.5[x1,x2],y2-1));

  color oldarrow; oldarrow = .9white;
  drawconnpatch(jc1,jd1)({dir -135}..{dir 155}) scaled .5;
  drawconnpatch(jc1,ji1)({dir -145}..{dir 135}) scaled .5;
  drawconnpatch(jc1,jb1)(..) scaled .5;
  drawconnpatch(d1,jc1)(..{dir 85}) scaled .5;
  drawconnpatch(sz1,jc1)(..{dir 75}) scaled .5;
  drawconnpatch(bk1,jc1)(..{dir 62}) scaled .5;
  drawconnpatch(bi1,jc1)({dir 60}..{dir 55}) scaled .5;

  drawelement(jd1,ji1,jb1);
  
  drawconnpatchx(jcp1,bi1)(.. jb1.s-(0,5) ..{dir -100}) scaled 1.5;
  drawconnpatchx(jcp1,sz1)(..{dir -150}) scaled 1.5;
  drawconnpatchx(jcp1,bk1)({dir -120}..{dir -150}) scaled 1.5;
  drawconnpatchx(jcp1,d1)(..) scaled 1.5;
  drawconnpatch(jcp1,jc1)({dir -10} .. .5[jcp1.e,jc1.e]+(5,0) .. {dir 180});

  drawelement(d1,bk1,sz1,bi1,jcp1);

endfig;


end
