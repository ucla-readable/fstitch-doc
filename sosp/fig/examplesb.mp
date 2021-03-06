input patches;
verbatimtex %&latex
\documentclass[12pt]{article}
\usepackage{elemfig,amsmath}
\def\S{}
%\def\S{_1}

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

vardef drawconnpatchy(suffix $,$$)(text conn) text rest =
  save oahlength; oahlength = ahlength; ahlength := oahlength/3;
  drawconnpatch($,$$)(conn) withpen connectionpen scaled 3 withcolor white;
  ahlength := oahlength;
  drawconnpatch($,$$)(conn) rest
enddef;

beginfig(1);
  save d,e,height,width;
  
  boxjoin(a.width = b.width = a.height);
  patchit.d1(btex $d\S$\strut etex, 0);
  d1.dx=10;

  boxjoin(a.width = b.width = a.height);
  patchit.bk1(btex $i\S$\strut etex, 0);
  patchit.sz1(btex $i\S'$\strut etex, 0);
  bk1.dx=6;

  boxjoin(a.width = b.width = a.height);
  patchit.bi1(btex $b\S$\strut etex, 0);
  bi1.dx=4;

  boxjoin(a.width = b.width = a.height);
  patchit.jd1(btex $d_{1\text{J}}$\strut etex, 0);
  patchit.ji1(btex $i_{1\text{J}}$\strut etex, 0);
  patchit.jb1(btex $b_{1\text{J}}$\strut etex, 0);
  patchit.jc1(btex $\textit{cmt}\S$\strut etex, 0);
  jd1.dx=10;

  jc1.height=jc1.width; bi1.height=bi1.width; d1.height=d1.width; sz1.height=sz1.width;
  ji1.w - jd1.e = jc1.w - jb1.e = (21,0); ji1.s - jc1.n = (0,35);

  bk1.s - sz1.n = (-10,2);
  bi1.c - .5[bk1.c,sz1.c] = (0,75);
  d1.w - .5[bi1.c,.5[bk1.c,sz1.c]] = (50,0);
  .5[bi1.c,.5[bk1.c,sz1.c]] - .5[jd1.c,jc1.c] = (110,10);
  
  drawelement(d1,bk1,sz1,bi1,jd1,ji1,jb1,jc1);

  d = e = 8; d'=22;
  forsuffixes $=jd1,ji1,jb1,jc1:
    blockbox($.nw+(-e,d') -- $.ne+(e,d') -- $.se+(e,-d) -- $.sw+(-e,-d) -- cycle);
  endfor;
  z.a = (jd1.nw+(-e,d')+(-e,d')); z.b = (jc1.se+(e,-d)+(e,-d));
  draw z.a -- (x.a,y.b) -- z.b -- (x.b,y.a) -- cycle withpen connectionpen scaled .5;
  height = jd1.height + d' + d;
  width = jd1.width + 2e;
  
  label.top(btex \textsc{Journal} etex, .5[jd1.nw+(0,d'),ji1.ne+(0,d')]+(0,5));
  label.top(btex \mlabel{journaled\\data block} etex scaled 0.65, jd1.n-(0,2));
  label.top(btex \mlabel{journaled\\inode block} etex scaled 0.65, ji1.n-(0,2));
  label.top(btex \mlabel{journaled\\bitmap block} etex scaled 0.65, jb1.n-(0,2));
  label.top(btex \mlabel{commit\\record} etex scaled 0.65, jc1.n-(0,2));

  linecap := butt;

  height := .85height;
  z1 = bi1.c + (-width,height)/2;  z2 = bi1.c - (-width,height)/2;
  blockbox((x1,y1) -- (x2,y1) -- (x2,y2) -- (x1,y2) -- cycle);
  label.top(btex \mlabel{bitmap block}\strut etex scaled 0.9, (.5[x1,x2],y1-1));

  z3 = .5[bk1.c,sz1.c] + (-width,height)/2;  z4 = .5[bk1.c,sz1.c] - (-width,height)/2;
  blockbox((x3,y3) -- (x4,y3) -- (x4,y4) -- (x3,y4) -- cycle);
  label.top(btex \mlabel{inode block}\strut etex scaled 0.9, (.5[x3,x4],y3-1));

  z5 = d1.c + (-width,height)/2;  z6 = d1.c - (-width,height)/2;
  blockbox((x5,y5) -- (x6,y5) -- (x6,y6) -- (x5,y6) -- cycle);
  label.top(btex \mlabel{data block}\strut etex scaled 0.9, (.5[x5,x6],y5-1));

  drawconnpatch(jc1,jd1)(..);
  drawconnpatch(jc1,ji1)({dir 45}..);
  drawconnpatch(jc1,jb1)(..);
  drawconnpatch(d1,jc1)({down}..{dir 125});
  drawconnpatch(sz1,jc1)(..);
  drawconnpatch(bk1,jc1)(..);
  drawconnpatch(bi1,jc1)(..);
endfig;

beginfig(2);
  save d,e,height,width,jx; pair jx[].nw,jx[].ne,jx[].sw,jx[].se,jx[].c,jx[].w;
  
  boxjoin(a.width = b.width = a.height);
  patchit.d1(btex $d\S$\strut etex, 0);
  d1.dx=10;

  boxjoin(a.width = b.width = a.height);
  patchit.bk1(btex $i\S$\strut etex, 0);
  patchit.sz1(btex $i\S'$\strut etex, 0);
  bk1.dx=6;

  boxjoin(a.width = b.width = a.height);
  patchit.bi1(btex $b\S$\strut etex, 0);
  bi1.dx=4;

  boxjoin(a.width = b.width = a.height);
  patchit.jd1(btex $d_{\text{J}}$\strut etex, 0);
  patchit.ji1(btex $i_{\text{J}}$\strut etex, 0);
  patchit.jb1(btex $b_{\text{J}}$\strut etex, 0);
  patchit.jc1(btex $\textit{cmt}\S$\strut etex, 0);
  patchit.jcp1(btex $\textit{cmp}\S$\strut etex, 0);
  jd1.dx=10;

  jcp1.height=jcp1.width; bi1.height=bi1.width; d1.height=d1.width; sz1.height=sz1.width;
  jx1.nw=(xpart ji1.nw,ypart jb1.nw);jx1.ne=(xpart ji1.ne,ypart jb1.ne);
  jx1.sw=(xpart ji1.sw,ypart jb1.sw);jx1.se=(xpart ji1.se,ypart jb1.se);
  jx1.c=(xpart ji1.c,ypart jb1.c);jx1.w=(xpart ji1.w,ypart jb1.w);
  ji1.w - jd1.e = jx1.w - jb1.e = (21,0); jd1.s - jb1.n = (0,35);
  jcp1.c = jx1.c + (3,-4); jc1.c = jx1.c - (3,-17);

  bk1.s - sz1.n = (-18,2);
  jx2.c = .5[bk1.c,sz1.c] + (-2,5);
  bi1.c - jx2.c = (0,75);
  d1.w - .5[bi1.c,jx2.c] = (50,0);
  .5[bi1.c,jx2.c] - .5[jd1.c,jx1.c] = (110,5);
  
  fixelement(d1,bk1,sz1,bi1,jd1,ji1,jb1,jc1,jcp1);

  vardef wogna =
    drawelement(jc1);
    drawconnpatch(d1,jc1)(--d1.c-(.3,0){dir -110}..sz1.w-(0,20)..{dir 125}) scaled 0.8;
  enddef;

  % Clip cmt\S vs. cmp\S
  color oldarrow; oldarrow = blockcolor;
  save pk, pp; picture pk[]; path pp[]; pk1 = nullpicture;
  wogna;
  clip currentpicture to bpath.jcp1;
  addto pk1 also currentpicture withcolor oldarrow;
  currentpicture := nullpicture;

  % Block boxes
  d = e = 8; d'=22;
  forsuffixes $=jd1,ji1,jx1:
    blockbox($.nw+(-e,d') -- $.ne+(e,d') -- $.se+(e,-d) -- $.sw+(-e,-d) -- cycle);
  endfor;

  height = .85(jd1.height + d' + d);
  width = jd1.width + 2e;
  z1 = bi1.c + (-width,height)/2;  z2 = bi1.c - (-width,height)/2;
  blockbox((x1,y1) -- (x2,y1) -- (x2,y2) -- (x1,y2) -- cycle);
  z3 = jx2.c + (-width,height)/2;  z4 = jx2.c - (-width,height)/2;
  blockbox((x3,y3) -- (x4,y3) -- (x4,y4) -- (x3,y4) -- cycle);
  z5 = d1.c + (-width,height)/2;  z6 = d1.c - (-width,height)/2;
  blockbox((x5,y5) -- (x6,y5) -- (x6,y6) -- (x5,y6) -- cycle);

  % Journal box
  z.a = (jd1.nw+(-e,d')+(-e,d')); z.b = (jx1.se+(e,-d)+(e,-2.8d));
  draw z.a -- (x.a,y.b) -- z.b -- (x.b,y.a) -- cycle withpen connectionpen scaled .75;
  
  % Finish clipping
  pp1 := jcp1.c -- jcp1.c-(0,100);
  pp2 := bpath.jcp1 cutbefore pp1;
  pp3 := jcp1.c -- jcp1.c-(100,0);
  pp4 := pp2 & (bpath.jcp1 cutafter pp3);
  pp5 := pp4 -- (point infinity of pp4) - (100, 0)
  -- (point infinity of pp4) - (100,-200)
  -- (point infinity of pp4) - (-500,-200)
  -- (point infinity of pp4) - (-500,200)
  -- (point infinity of pp4) - (0,200) -- cycle;
  drawconnpatchy(d1,jc1)(--d1.c-(.3,0){dir -110}..sz1.w-(0,20)..{dir 125}) scaled 0.8;
  wogna;
  clip currentpicture to pp5;
  addto currentpicture also pk1 withcolor oldarrow;

  % Fix up blockboxes
  blockbox(jb1.nw+(-e,d') -- jb1.ne+(e,d') -- jb1.se+(e,-d) -- jb1.sw+(-e,-d) -- cycle);
  blockbox(jx1.nw+(-e,d') -- jx1.sw+(-e,-d) -- jx1.se+(e,-d));
  
  drawelement(jd1,ji1,jb1);
  draw (x.b,y.a) -- z.a -- (x.a,y.b) -- z.b withpen connectionpen scaled .75;
  
  label.top(btex \textsc{Journal} etex, .5[jd1.nw+(0,d'),ji1.ne+(0,d')]+(0,5));
  label.top(btex \mlabel{journaled\\data block} etex scaled 0.65, jd1.n-(0,2));
  label.top(btex \mlabel{journaled\\inode block} etex scaled 0.65, ji1.n-(0,2));
  label.top(btex \mlabel{journaled\\bitmap block} etex scaled 0.65, jb1.n-(0,2));
  label.llft(btex \mlabel{commit/completion\\record} etex scaled 0.65, jx1.se+(1.8e,-d));
  linecap := butt;

  label.top(btex \mlabel{bitmap block}\strut etex scaled 0.9, (.5[x1,x2],y1-1));
  label.top(btex \mlabel{inode block}\strut etex scaled 0.9, (.5[x3,x4],y3-1));
  label.top(btex \mlabel{data block}\strut etex scaled 0.9, (.5[x5,x6],y5-1));

  drawconnpatch(jc1,jd1)(..);
  drawconnpatch(jc1,ji1)(..);
  drawconnpatch(jc1,jb1)(..);
  drawconnpatchy(sz1,jc1)(--sz1.c+(0,.7)..) scaled 0.8;
  drawconnpatchy(bk1,jc1)(..) scaled 0.8;
  drawconnpatchy(bi1,jc1)(--bi1.c+(0,.7)..) scaled 0.8;
  
  drawconnpatchx(jcp1,bi1)(..bi1.c-(0,.7)--) scaled 1.5;
  drawconnpatchx(jcp1,sz1)(..sz1.c-(0,.7)--) scaled 1.5;
  drawconnpatchx(jcp1,bk1)(..) scaled 1.5;
  drawconnpatchx(jcp1,d1)({dir -45}..sz1.w-(0,25)..{dir 80}d1.c+(.7,0)--) scaled 1.5;
  drawconnpatch(jcp1,jc1)({dir -170} .. .5[jcp1.w,jc1.w]-(5,3) .. {dir 80});

  drawelement(jcp1,bi1,bk1,sz1,d1);

  label.top(btex \mlabel{alloc block} etex scaled 0.65, bi1.n-(0,2));
  label.top(btex \mlabel{clear data} etex scaled 0.65, d1.n-(0,2));
  label.top(btex \mlabel{attach} etex scaled 0.65, bk1.n-(0,2));
  label.top(btex \mlabel{size} etex scaled 0.65, sz1.n-(0,2));
endfig;

beginfig(3);
  save d,e,height,width,jx; pair jx[].nw,jx[].ne,jx[].sw,jx[].se,jx[].c,jx[].w;
  
  boxjoin(a.width = b.width = a.height);
  patchit.d1(btex $d\S$\strut etex, 0);
  d1.dx=10;

  boxjoin(a.width = b.width = a.height);
  patchit.bk1(btex $i\S$\strut etex, 0);
  patchit.sz1(btex $i\S'$\strut etex, 0);
  bk1.dx=6;

  boxjoin(a.width = b.width = a.height);
  patchit.bi1(btex $b\S$\strut etex, 0);
  bi1.dx=4;

  bi1.height=bi1.width; d1.height=d1.width; sz1.height=sz1.width;
  bk1.s - sz1.n = (-12,12);
  bi1.c - .5[bk1.c,sz1.c] = (-3,75);
  d1.w - .5[bi1.c,.5[bk1.c,sz1.c]] = (50,0);

  fixelement(d1,bk1,sz1,bi1);

  % Block boxes
  d = e = 8; d'=22;
  height = .85(d1.height + d' + d);
  width = d1.width + 2e;
  z1 = bi1.c + (-width,height)/2;  z2 = bi1.c - (-width,height)/2;
  blockbox((x1,y1) -- (x2,y1) -- (x2,y2) -- (x1,y2) -- cycle);
  z3 = .5[bk1.c,sz1.c] + (-1.3width,1.2height)/2;  z4 = .5[bk1.c,sz1.c] - (-width,1.4height)/2;
  blockbox((x3,y3) -- (x4,y3) -- (x4,y4) -- (x3,y4) -- cycle);
  z5 = d1.c + (-width,1.1height)/2;  z6 = d1.c - (-width,1height)/2;
  blockbox((x5,y5) -- (x6,y5) -- (x6,y6) -- (x5,y6) -- cycle);

  drawelement(d1,bk1,sz1,bi1);

  linecap := butt;

  label.top(btex \mlabel{bitmap block}\strut etex scaled 0.9, (.5[x1,x2],y1-1));
  label.bot(btex \mlabel{inode block}\strut etex scaled 0.9, (.5[x3,x4],y4-1));
  label.top(btex \mlabel{data block}\strut etex scaled 0.9, (.5[x5,x6],y5-1));

  label.top(btex \mlabel{alloc block} etex scaled 0.65, bi1.n-(0,2));
  label.top(btex \mlabel{clear data} etex scaled 0.65, d1.n-(0,2));
  label.bot(btex \mlabel{attach block} etex scaled 0.65, bk1.s-(0,-1.5));
  label.bot(btex \mlabel{set size} etex scaled 0.65, sz1.s-(0,-1.5));
  
  drawconnpatch(bk1,bi1)(..);
  drawconnpatch(bk1,d1)(..);
  drawconnpatch(d1,bi1)(..);
  drawconnpatch(sz1,d1)(..);
endfig;

beginfig(4);
  save d,e,height,width,jx; pair jx[].nw,jx[].ne,jx[].sw,jx[].se,jx[].c,jx[].w;
  save addblockcolor; color addblockcolor; addblockcolor = black;
  save addblockfillcolor; color addblockfillcolor; addblockfillcolor = white;
  save addblocklabcolor; color addblocklabcolor; addblocklabcolor = black;
  save delblockfillcolor; color delblockfillcolor; delblockfillcolor = white;
    
  boxjoin(a.width = b.width = a.height);
  patchit.d1(image(draw btex $d\S$\strut etex withcolor addblockcolor), 0);
  d1.dx=10;

  boxjoin(a.width = b.width = a.height);
  patchit.bk1(image(draw btex $i\S$\strut etex withcolor addblockcolor), 0);
  patchit.sz1(image(draw btex $i\S'$\strut etex withcolor addblockcolor), 0);
  patchit.de1(btex $i_2$\strut etex, 0);
  bk1.dx=6;

  boxjoin(a.width = b.width = a.height);
  patchit.bi1(image(draw btex $b\S$\strut etex withcolor addblockcolor), 0);
  patchit.bi2(btex $b_2$\strut etex, 0);
  bi2.dx=2;

  bi2.height=bi2.width; d1.height=d1.width; de1.height=de1.width;
  bk1.s - sz1.n = (0,12);
  jx2.c = .37[.5[bk1.c,sz1.c],de1.c];
  jx1.c - jx2.c = (-3,75);
  d1.w - .5[jx1.c,jx2.c] = (50,0);
  bi1.w - bi2.e = (4,15);
  .5[bi1.c,bi2.c] = jx1.c - (0,5);
  .5[bk1.w,sz1.w] - de1.e = (8,0);

  fixelement(d1,bk1,sz1,bi1,de1,bi2);
  fillelement(d1,bk1,sz1,bi1)(addblockfillcolor);
  fillelement(bi2,de1)(delblockfillcolor);

  % Block boxes
  d = e = 8; d'=22;
  height = .85(d1.height + d' + d);
  width = d1.width + 2e;
  z1 = jx1.c + (-width,height)/2;  z2 = jx1.c - (-width,height)/2;
  blockbox((x1,y1) -- (x2,y1) -- (x2,y2) -- (x1,y2) -- cycle);
  z3 = jx2.c + (-1.3width,1.2height)/2;  z4 = jx2.c - (-width,1.4height)/2;
  blockbox((x3,y3) -- (x4,y3) -- (x4,y4) -- (x3,y4) -- cycle);
  z5 = d1.c + (-width,1.1height)/2;  z6 = d1.c - (-width,1height)/2;
  blockbox((x5,y5) -- (x6,y5) -- (x6,y6) -- (x5,y6) -- cycle);

  drawelement(d1,bk1,sz1,bi1) withcolor addblockcolor;
  drawelement(de1,bi2);

  linecap := butt;

  label.top(btex \mlabel{bitmap block}\strut etex scaled 0.9, (.5[x1,x2],y1-1));
  label.bot(btex \mlabel{inode block}\strut etex scaled 0.9, (.5[x3,x4],y4-1));
  label.top(btex \mlabel{data block}\strut etex scaled 0.9, (.5[x5,x6],y5-1));

  label.top(image(draw btex \mlabel{alloc} etex withcolor addblocklabcolor) scaled 0.65, bi1.n-(0,2));
  label.top(btex \mlabel{free\\block} etex scaled 0.65, bi2.n-(0,2));
  label.top(image(draw btex \mlabel{clear data} etex withcolor addblocklabcolor) scaled 0.65, d1.n-(0,2));
  label.bot(image(draw btex \mlabel{attach} etex withcolor addblocklabcolor) scaled 0.65, bk1.s-(0,-1.8));
  label.bot(image(draw btex \mlabel{size} etex withcolor addblocklabcolor) scaled 0.65, sz1.s-(0,-1.8));
  label.bot(btex \mlabel{erase\\inode} etex scaled 0.65, de1.s-(0,-1.5));
  
  drawconnpatch(bk1,bi1)(..);
  drawconnpatch(bk1,d1)(..);
  drawconnpatch(d1,bi1)(..);
  drawconnpatch(sz1,d1)(..);
  drawconnpatch(bi2,de1)(..);
endfig;

end
