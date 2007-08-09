input patches;
verbatimtex %&latex
\documentclass[12pt]{article}
\usepackage{elemfig,amsmath}

\begin{document}
etex;
picture emptyqueue; emptyqueue := btex \phantom{\elementlabel{Queue}} etex;
picture vemptyqueue; vemptyqueue := emptyqueue rotated 90 xscaled .4;
hardborderscale = 3;

beginfig(1);
  boxjoin(a.width = b.width = a.height);
  patchit.a(btex $d_1$\strut etex,0);
  patchit.b(btex $i$\strut etex,0);
  patchit.c(btex $d_2$\strut etex,0);
  c.height = c.width;

  c.s - a.n = (0,10);
  b.w - .5[a.e,c.e] = (30,0);

  a.borderscale = b.borderscale = hardborderscale;

  fixelement(a,b,c);

  save d; d = 6; d' = 11;
  def blockbox(text t) = draw t withpen pencircle scaled 3 withcolor .8white enddef;
  z1 = c.nw+(-d',d); z2 = (xpart c.e,ypart a.s)+(d',-d);
  blockbox(z1 -- (x2,y1) -- z2 -- (x1,y2) -- cycle);
  label.top(btex \mlabel{directory data}\strut etex scaled 0.8, (.5[x1,x2],y1-1));

  z3 = b.nw+(-d',d); z4 = b.se+(d',-d);
  blockbox((x3,y1) -- (x3,y2) -- (x4,y2) -- (x4,y1) -- cycle);
  label.top(btex \mlabel{inode block}\strut etex scaled 0.8, (.5[x3,x4],y1-1));

  drawelement(a,b,c);
  drawconnpatch(b,a)(..);
  drawconnpatch(c,a)(..);
  drawconnpatch(c,b)(..);
endfig;


beginfig(2);
  boxjoin(a.width = b.width = a.height);
  patchit.a(btex $d_1$\strut etex,0);
  patchit.b(btex $i$\strut etex,0);
  patchit.c(btex $d_2$\strut etex,0);
  patchit.cx(btex $d_2$\strut etex,0);
  cx.height = cx.width;

  c.s - a.n = (0,10);
  b.w - .5[a.e,c.e] = (30,0);
  cx.c = .5[a.c,c.c];

  a.borderscale = b.borderscale = hardborderscale;

  fixelement(a,b,c,cx);

  save d; d = 6; d' = 11;
  def blockbox(text t) = draw t withpen pencircle scaled 3 withcolor .8white enddef;
  z1 = c.nw+(-d',d); z2 = (xpart c.e,ypart a.s)+(d',-d);
  blockbox(z1 -- (x2,y1) -- z2 -- (x1,y2) -- cycle);
  %% label.top(btex \mlabel{directory data}\strut etex scaled 0.8, (.5[x1,x2],y1-1));

  z3 = b.nw+(-d',d); z4 = b.se+(d',-d);
  blockbox((x3,y1) -- (x3,y2) -- (x4,y2) -- (x4,y1) -- cycle);
  %% label.top(btex \mlabel{inode block}\strut etex scaled 0.8, (.5[x3,x4],y1-1));

  drawelement(b,cx);
  drawconnpatch(cx,b)(..);
endfig;


beginfig(3);
  boxjoin(a.width = b.width = a.height);
  patchit.a(btex $d_1$\strut etex,0);
  patchit.b(btex $i$\strut etex,0);
  patchit.c(btex $d_2$\strut etex,0);
  c.height = c.width;

  boxjoin();
  patchit.cx(btex \mlabel{$d_3$\\$+d_2$}\strut etex,0);

  c.s - a.n = (0,10);
  b.w - .5[a.e,c.e] = (30,0);
  cx.c = .5[a.c,c.c];

  a.borderscale = b.borderscale = cx.borderscale = hardborderscale;

  fixelement(a,b,c,cx);

  save d; d = 6; d' = 11;
  def blockbox(text t) = draw t withpen pencircle scaled 3 withcolor .8white enddef;
  z1 = c.nw+(-d',d); z2 = (xpart c.e,ypart a.s)+(d',-d);
  blockbox(z1 -- (x2,y1) -- z2 -- (x1,y2) -- cycle);
  %% label.top(btex \mlabel{directory data}\strut etex scaled 0.8, (.5[x1,x2],y1-1));

  z3 = b.nw+(-d',d); z4 = b.se+(d',-d);
  blockbox((x3,y1) -- (x3,y2) -- (x4,y2) -- (x4,y1) -- cycle);
  %% label.top(btex \mlabel{inode block}\strut etex scaled 0.8, (.5[x3,x4],y1-1));

  drawelement(b,cx);
  drawconnpatch(cx,b)(..);
endfig;


end
