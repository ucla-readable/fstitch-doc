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
  patchit.a(btex $p_h$\strut etex,0);
  patchit.b(btex $q_h$\strut etex,0);
  patchit.c(btex $p_1$\strut etex,0);
  patchit.x(btex $p_2$\strut etex,0);
  patchit.e(btex $p_3$\strut etex,0);
  e.height = e.width;

  x.s - e.n = (0,5);
  c.w - .5[x.e,e.e] = (10,0);
  .5[c.c,e.c] - a.n = (0,25);
  b.w - c.e = (20,-20);

  a.borderscale = b.borderscale = hardborderscale;

  fixelement(a,b,c,x,e);

  save d; d = 6;
  def blockbox(text t) = draw t withpen pencircle scaled 3 withcolor .8white enddef;
  z1 = x.nw+(-d,d); z2 = (xpart c.e,ypart a.s)+(d,-d);
  blockbox(z1 -- (x2,y1) -- z2 -- (x1,y2) -- cycle);
  z3 = b.nw+(-d,d); z4 = b.se+(d,-d);
  blockbox((x3,y1) -- (x3,y2) -- (x4,y2) -- (x4,y1) -- cycle);

  drawelement(a,b,c,x,e);
  drawconnpatch(b,a)(..);
  drawconnpatch(c,a)(..);
  drawconnpatch(e,a)(..);
  drawconnpatch(c,b)(..);
  drawconnpatch(x,c)(..);
  drawconnpatch(e,c)(..);
endfig;

beginfig(2);
  boxjoin(a.width = b.width = a.height);
  patchit.b(btex $q_h$\strut etex,0);
  patchit.c(btex $p_1$\strut etex,0);
  patchit.x(btex $p_2$\strut etex,0);
  patchit.e(btex $p_3$\strut etex,0);
  e.height = e.width;

  x.s - e.n = (0,5);
  c.w - .5[x.e,e.e] = (10,0);
  b.w - c.e = (20,0);

  b.borderscale = hardborderscale;

  fixelement(b,c,x,e);

  save d; d = 6;
  def blockbox(text t) = draw t withpen pencircle scaled 3 withcolor .8white enddef;
  z1 = x.nw+(-d,d); z2 = (xpart c.e,ypart e.s)+(d,-d);
  blockbox(z1 -- (x2,y1) -- z2 -- (x1,y2) -- cycle);
  z3 = b.nw+(-d,d); z4 = b.se+(d,-d);
  blockbox((x3,y1) -- (x3,y2) -- (x4,y2) -- (x4,y1) -- cycle);

  drawelement(b,c,x,e);
  drawconnpatch(c,b)(..);
  drawconnpatch(x,c)(..);
  drawconnpatch(e,c)(..);
endfig;


beginfig(3);
  boxjoin(a.width = b.width = a.height);
  patchit.b(btex $q_h$\strut etex,0);
  patchit.c(btex $p_1$\strut etex,0);
  patchit.x(btex $p_2$\strut etex,0);
  patchit.e(btex $p_3$\strut etex,0);
  e.height = e.width;

  boxjoin();
  patchit.aa(btex \mlabel{$p_1+p_2$\\$+p_3+p_h'$} etex,0);
  aa.dy=10;

  x.s - e.n = (0,5);
  c.w - .5[x.e,e.e] = (10,0);
  b.w - c.e = (20,0);
  aa.c = .5[x.nw,(xpart c.e,ypart e.s)];

  aa.borderscale = b.borderscale = hardborderscale;

  fixelement(b,c,x,e,aa);

  save d; d = 6;
  def blockbox(text t) = draw t withpen pencircle scaled 3 withcolor .8white enddef;
  z1 = x.nw+(-d,d); z2 = (xpart c.e,ypart e.s)+(d,-d);
  blockbox(z1 -- (x2,y1) -- z2 -- (x1,y2) -- cycle);
  z3 = b.nw+(-d,d); z4 = b.se+(d,-d);
  blockbox((x3,y1) -- (x3,y2) -- (x4,y2) -- (x4,y1) -- cycle);

  drawelement(aa,b);
  drawconnpatch(aa,b)(..);
endfig;


end
