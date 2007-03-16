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
  boxjoin(a.width = b.width = a.height; a.s = b.n + (0,30));
  patchit.sz1(btex $i_1'$\strut etex,0);
  patchit.sz2(btex $i_2'$\strut etex,0);
  patchit.sz3(btex $i_3'$\strut etex,0);
  patchit.sz4(btex $i_4'$\strut etex,0);

  boxjoin();
  patchit.bk1(btex $i_1$\strut etex,0);
  boxjoin(a.width = b.width = a.height; a.s = b.n + (0,30));
  patchit.bk2(btex $i_2$\strut etex,0);
  patchit.bk3(btex $i_3$\strut etex,0);
  patchit.bk4(btex $i_4$\strut etex,0);
  bk1.width = bk1.height = bk2.width; bk1.s = bk2.n + (0,23);

  boxjoin(a.width = b.width = a.height);
  patchit.d1(btex $d_1'$\strut etex, 0);
  patchit.d2(btex $d_2'$\strut etex, 0);
  patchit.d3(btex $d_3'$\strut etex, 0);
  patchit.d4(btex $d_4'$\strut etex, 0);
  patchit.i1(btex $d_1$\strut etex, 0);
  patchit.i2(btex $d_2$\strut etex, 0);
  patchit.i3(btex $d_3$\strut etex, 0);
  patchit.i4(btex $d_4$\strut etex, 0);
  d1.dx=10;

  boxjoin(a.width = b.width = a.height);
  patchit.bi1(btex $a_1$\strut etex, 0);
  patchit.bi2(btex $a_2$\strut etex, 0);
  patchit.bi3(btex $a_3$\strut etex, 0);
  patchit.bi4(btex $a_4$\strut etex, 0);
  %bia.squatness=bib.squatness=bic.squatness=bid.squatness=0.6;
  bi1.dx=4;

  boxjoin();
  patchit.mtime(btex $i''$\strut etex, 0);
  patchit.group(btex $g$\strut etex, 0);
  patchit.sblk(btex $s$\strut etex, 0);
  group.dx=10;group.width=sblk.width;

  i4.height=i4.width;bk4.height=bk4.width;sz4.height=sz4.width;bi4.height=bi4.width;
  mtime.height=mtime.width;group.height=group.width;sblk.height=sblk.width;

  .5[sz1.nw,(xpart sz1.nw,ypart bk4.sw)] - mtime.e = (10,0);
  mtime.width=sz1.width;
  group.s - sblk.n = (0,30);
  .5[group.w,sblk.w] - .5[bi1.ne,bi4.se] = (31,0);
  
  bk1.w = .4[sz1.s,sz2.n] + (20,0);

  forsuffixes $=1,2,3,4:
    d$.w-sz$.e+(0,ypart (sz4.e-bk4.e)/2) = (60,0);
    i$.w-d$.e = (20,0); bi$.w-i$.e = (32,0);
  endfor
  
  fixelement(bk1,bk2,bk3,bk4,sz1,sz2,sz3,sz4,d1,d2,d3,d4,i1,i2,i3,i4,bi1,bi2,bi3,bi4,mtime,sblk,group);

  d = 6;
  def blockbox(text t) = draw t withpen pencircle scaled 3 withcolor .9white enddef;
  ylab = ypart i1.ne + 3d;
  z1 = (xpart mtime.w,ypart sz1.nw)+(-1.2d,2d); z2 = bk4.se + (1.5d,-d);
  blockbox(z1 -- (x2,y1) -- z2 -- (x1,y2) -- cycle);

  blockbox(d1.nw+(-d,2d) -- i1.ne+(d,2d) -- i1.se+(d,-d) -- d1.sw+(-d,-d) -- cycle);
  forsuffixes $=2,3,4:
    blockbox(d$.nw+(-d,d) -- i$.ne+(d,d) -- i$.se+(d,-d) -- d$.sw+(-d,-d) -- cycle);
  endfor

  blockbox((xpart bi1.nw-2d,ypart d1.nw+2d) -- (xpart bi1.ne+2d,ypart d1.nw+2d) -- bi4.se+2(d,-d) -- bi4.sw+2(-d,-d) -- cycle);
  forsuffixes $=sblk,group:
    blockbox($.nw+(-d,d) -- $.ne+(d,d) -- $.se+(d,-d) -- $.sw+(-d,-d) -- cycle);
  endfor

  label.top(btex \mlabel{inode block}\strut etex scaled 0.9, (.5[x1,x2],ylab));
  label.top(btex \mlabel{data blocks}\strut etex scaled 0.9, (xpart .5[d1.nw,i1.ne],ylab));
  label.top(btex \mlabel{bitmap block}\strut etex scaled 0.9, (xpart bi1.c,ylab));
  
  drawelement(bk1,bk2,bk3,bk4,sz1,sz2,sz3,sz4,d1,d2,d3,d4,i1,i2,i3,i4,bi1,bi2,bi3,bi4,mtime,group,sblk);
  drawconnpatch(sz2,sz1)(..);
  drawconnpatch(sz3,sz2)(..);
  drawconnpatch(sz4,sz3)(..);
  drawconnpatch(bk2,bk1)(..);
  drawconnpatch(bk3,bk2)(..);
  drawconnpatch(bk4,bk3)(..);
  forsuffixes $=1,2,3,4:
    drawconnpatch(sz$,d$)({dir 10} .. {dir -10});
    drawconnpatch(d$,i$)(..);
    drawconnpatch(i$,bi$)(..);
  endfor
  drawconnpatch(bk1,i1)({dir -25} .. {dir 40});
  drawconnpatch(bk2,i2)({dir -25} .. {dir 45});
  drawconnpatch(bk3,i3)({dir -25} .. {dir 45});
  drawconnpatch(bk4,i4)({dir -25} .. {dir 45});
  drawconnpatch(i1,bi1)(..);
  drawconnpatch(i2,bi2)(..);
  drawconnpatch(i3,bi3)(..);
  drawconnpatch(i4,bi4)(..);
  drawconnpatch(group,sblk)(..);

  label.top(btex set size etex scaled 0.7, sz1.n);
  label.top(btex add block etex scaled 0.7, bk1.n);
  label.top(btex set mtime etex scaled 0.7, mtime.n);
  label.top(btex write data etex scaled 0.7, d1.n);
  label.top(btex zero data etex scaled 0.7, i1.n);
  label.top(btex alloc block etex scaled 0.7, bi1.n);
  label.top(btex \mlabel{group desc\\block} etex scaled 0.7, group.n+(0,d-1));
  label.bot(btex superblock etex scaled 0.7, sblk.s-(0,d));
endfig;



beginfig(2);
  numeric d;
  boxjoin(a.width = b.width = a.height; a.s = b.n + (0,30));
  patchit.sz1(btex $i_1'$\strut etex,0);
  patchit.sz2(btex $i_2'$\strut etex,0);
  patchit.sz3(btex $i_3'$\strut etex,0);
  patchit.sz4(btex $i_4'$\strut etex,0);
  
  boxjoin(a.width = b.width = a.height; a.s = b.n + (0,30));
  patchit.bk1(btex $i_1$\strut etex,0);
  patchit.bk2(btex $i_2$\strut etex,0);
  patchit.bk3(btex $i_3$\strut etex,0);
  patchit.bk4(btex $i_4$\strut etex,0);

  boxjoin(a.width = b.width = a.height);
  patchit.d1(btex $d_1'$\strut etex, 0);
  patchit.d2(btex $d_2'$\strut etex, 0);
  patchit.d3(btex $d_3'$\strut etex, 0);
  patchit.d4(btex $d_4'$\strut etex, 0);
  patchit.i1(btex $d_1$\strut etex, 0);
  patchit.i2(btex $d_2$\strut etex, 0);
  patchit.i3(btex $d_3$\strut etex, 0);
  patchit.i4(btex $d_4$\strut etex, 0);
  d1.dx=10;

  boxjoin(a.width = b.width = a.height);
  patchit.bi1(btex $a_1$\strut etex, 0);
  patchit.bi2(btex $a_2$\strut etex, 0);
  patchit.bi3(btex $a_3$\strut etex, 0);
  patchit.bi4(btex $a_4$\strut etex, 0);
  %bia.squatness=bib.squatness=bic.squatness=bid.squatness=0.6;
  bi1.dx=4;

  boxjoin();
  patchit.mtime(btex $i''$\strut etex, 0);
  patchit.group(btex $g$\strut etex, 0);
  patchit.sblk(btex $s$\strut etex, 0);
  group.dx=10;group.width=sblk.width;

  i4.height=i4.width;bk4.height=bk4.width;sz4.height=sz4.width;bi4.height=bi4.width;
  mtime.height=mtime.width;group.height=group.width;sblk.height=sblk.width;

  .5[sz1.nw,(xpart sz1.nw,ypart bk4.sw)] - mtime.e = (10,0);
  mtime.width=sz1.width;
  group.s - sblk.n = (0,30);
  .5[group.w,sblk.w] - .5[bi1.ne,bi4.se] = (31,0);
  
  bk1.w = .4[sz1.s,sz2.n] + (20,7);

  forsuffixes $=1,2,3,4:
    d$.w-(xpart sz$.e,ypart .5[sz$.e,bk$.e]) = (60,0);
    i$.w-d$.e = (20,0); bi$.w-i$.e = (32,0);
  endfor

  forsuffixes $=i1,i2,i3,i4,bi1,group,sblk,bk1,bk2,bk3,bk4,sz1,sz2,sz3,sz4,mtime:
    $.borderscale = hardborderscale;
  endfor
  
  
  fixelement(bk1,bk2,bk3,bk4,sz1,sz2,sz3,sz4,d1,d2,d3,d4,i1,i2,i3,i4,bi1,bi2,bi3,bi4,mtime,sblk,group);

  d = 6;
  def blockbox(text t) = draw t withpen pencircle scaled 3 withcolor .9white enddef;
  z1 = (xpart mtime.w,ypart sz1.nw)+(-1.2d,d); z2 = bk4.se + (1.5d,-d);
  blockbox(z1 -- (x2,y1) -- z2 -- (x1,y2) -- cycle);

  forsuffixes $=1,2,3,4:
    blockbox(d$.nw+(-d,d) -- i$.ne+(d,d) -- i$.se+(d,-d) -- d$.sw+(-d,-d) -- cycle);
  endfor

  blockbox(bi1.nw+2(-d,d) -- bi1.ne+2(d,d) -- bi4.se+2(d,-d) -- bi4.sw+2(-d,-d) -- cycle);
  forsuffixes $=sblk,group:
    blockbox($.nw+(-d,d) -- $.ne+(d,d) -- $.se+(d,-d) -- $.sw+(-d,-d) -- cycle);
  endfor
  
  drawelement(bk1,bk2,bk3,bk4,sz1,sz2,sz3,sz4,d1,d2,d3,d4,i1,i2,i3,i4,bi1,bi2,bi3,bi4,mtime,group,sblk);
  drawconnpatch(sz2,sz1)(..);
  drawconnpatch(sz3,sz2)(..);
  drawconnpatch(sz4,sz3)(..);
  drawconnpatch(bk2,bk1)(..);
  drawconnpatch(bk3,bk2)(..);
  drawconnpatch(bk4,bk3)(..);
  forsuffixes $=1,2,3,4:
    drawconnpatch(sz$,d$)({dir 10} .. {dir -10});
    drawconnpatch(d$,i$)(..);
    drawconnpatch(bk$,i$)({dir -25} .. {dir 45});
    drawconnpatch(i$,bi$)(..);
  endfor
  drawconnpatch(group,sblk)(..);
  drawconnpatch(bi2,bi1)(..);
  drawconnpatch(bi3,bi1)({dir 65}..{dir 120});
  drawconnpatch(bi4,bi1)({dir 70}..{dir 130});
endfig;



beginfig(3);
  numeric d;
  patchit.in(btex $i_{\text{1-4}}+i'_{\text{1-4}}+i''$\strut etex,0);

  boxjoin(a.width = b.width = a.height; a.s=b.n+(0,20));
  patchit.d1(btex $d_1'$\strut etex, 0);
  patchit.d2(btex $d_2'$\strut etex, 0);
  patchit.d3(btex $d_3'$\strut etex, 0);
  patchit.d4(btex $d_4'$\strut etex, 0);
  boxjoin(a.width = b.width = a.height; a.s=b.n+(0,20));
  patchit.i1(btex $d_1$\strut etex, 0);
  patchit.i2(btex $d_2$\strut etex, 0);
  patchit.i3(btex $d_3$\strut etex, 0);
  patchit.i4(btex $d_4$\strut etex, 0);
  d1.dx=10;

  boxjoin(a.width = b.width = a.height);
  patchit.bi1(btex $a_1$\strut etex, 0);
  patchit.bi2(btex $a_2$\strut etex, 0);
  patchit.bi3(btex $a_3$\strut etex, 0);
  patchit.bi4(btex $a_4$\strut etex, 0);
  %bia.squatness=bib.squatness=bic.squatness=bid.squatness=0.6;
  bi1.dx=4;

  boxjoin();
  patchit.group(btex $g$\strut etex, 0);
  patchit.sblk(btex $s$\strut etex, 0);
  group.dx=10;group.width=sblk.width;

  i4.height=i4.width=d4.height=d4.width;bi4.height=bi4.width;
  group.height=group.width;sblk.height=sblk.width;

  group.s - sblk.n = (0,30);
  .5[group.w,sblk.w] - .5[bi1.ne,bi4.se] = (31,0);

  in.e = .5[d1.w,d4.w] - (30,0);
  
  %bk1.w = .5[sz1.s,sz2.n] + (20,0);

  %d1.w-sz1.e = d2.w-sz2.e = d3.w-sz3.e = d4.w-sz4.e = (70,0);
  i1.w-d1.e = i2.w-d2.e = i3.w-d3.e = i4.w-d4.e = (20,0);
  bi1.w-i1.e = bi2.w-i2.e = bi3.w-i3.e = bi4.w-i4.e = (32,0);


  forsuffixes $=i1,i2,i3,i4,bi1,group,sblk,in:
    $.borderscale = hardborderscale;
  endfor
  
  
  fixelement(in,d1,d2,d3,d4,i1,i2,i3,i4,bi1,bi2,bi3,bi4,sblk,group);

  d = 6;
  def blockbox(text t) = draw t withpen pencircle scaled 3 withcolor .9white enddef;
  blockbox(in.nw+(-d,d) -- in.ne+(d,d) -- in.se+(d,-d) -- in.sw+(-d,-d) -- cycle);

  forsuffixes $=1,2,3,4:
    blockbox(d$.nw+(-d,d) -- i$.ne+(d,d) -- i$.se+(d,-d) -- d$.sw+(-d,-d) -- cycle);
  endfor

  blockbox(bi1.nw+2(-d,d) -- bi1.ne+2(d,d) -- bi4.se+2(d,-d) -- bi4.sw+2(-d,-d) -- cycle);
  forsuffixes $=sblk,group:
    blockbox($.nw+(-d,d) -- $.ne+(d,d) -- $.se+(d,-d) -- $.sw+(-d,-d) -- cycle);
  endfor
  
  drawelement(in,d1,d2,d3,d4,i1,i2,i3,i4,bi1,bi2,bi3,bi4,group,sblk);
  drawconnpatch(in,d1)(..);
  drawconnpatch(in,d2)(..);
  drawconnpatch(in,d3)(..);
  drawconnpatch(in,d4)(..);
  drawconnpatch(d1,i1)(..);
  drawconnpatch(d2,i2)(..);
  drawconnpatch(d3,i3)(..);
  drawconnpatch(d4,i4)(..);
  drawconnpatch(in,i1)(..);
  drawconnpatch(in,i2)({dir 15}..{dir 45});
  drawconnpatch(in,i3)({dir -15}..{dir -45});
  drawconnpatch(in,i4)(..);
  drawconnpatch(i1,bi1)(..);
  drawconnpatch(i2,bi2)(..);
  drawconnpatch(i3,bi3)(..);
  drawconnpatch(i4,bi4)(..);
  drawconnpatch(group,sblk)(..);
  drawconnpatch(bi2,bi1)(..);
  drawconnpatch(bi3,bi1)({dir 65}..{dir 120});
  drawconnpatch(bi4,bi1)({dir 70}..{dir 130});
endfig;


beginfig(4);
  patchit.i(btex inode\strut etex,0);
  
  boxjoin(a.width = b.width; a.s - b.n = (0,10));
  patchit.da(btex data 1\strut etex, 1);
  patchit.db(btex data 2\strut etex, 1);
  patchit.dc(btex data 3\strut etex, 1);
  patchit.dd(btex data 4\strut etex, 1);

  boxjoin();
  patchit.bi(btex bitmap\strut etex, 2);
  bi.squatness=0.6;
  bi.dx=12;

  boxjoin(a.width=b.width);
  patchit.group(btex group\strut etex, 3);
  patchit.sblk(btex superblk\strut etex, 3);

  .5[da.w,dd.w]-i.e = bi.w-.5[da.e,dd.e] = (40,0);
  group.s - sblk.n = (0,30);
  .5[group.w,sblk.w] - bi.e = (31,0);
  
  fixelement(i,da,db,dc,dd,bi,sblk,group);
  drawelement(i,da,db,dc,dd,bi,sblk,group);
  drawconnpatch(i,da)(..);
  drawconnpatch(i,db)(..);
  drawconnpatch(i,dc)(..);
  drawconnpatch(i,dd)(..);
  drawconnpatch(da,bi)(..);
  drawconnpatch(db,bi)(..);
  drawconnpatch(dc,bi)(..);
  drawconnpatch(dd,bi)(..);
  drawconnpatch(group,sblk)(..);
endfig;


beginfig(4);
  numeric d;
  patchit.in(btex $i_{\text{1-4}}+i'_{\text{1-4}}+i''$\strut etex,0);

  boxjoin(a.width = b.width; b.height = a.height; a.s=b.n+(0,20));
  patchit.d1(btex $d_1+d_1'$\strut etex, 0);
  patchit.d2(btex $d_2+d_2'$\strut etex, 0);
  patchit.d3(btex $d_3+d_3'$\strut etex, 0);
  patchit.d4(btex $d_4+d_4'$\strut etex, 0);
  d1.dx=10;

  boxjoin();
  patchit.bi(btex $a_{\text{1-4}}$\strut etex, 0);
  bi1.dx=4;

  patchit.group(btex $g$\strut etex, 0);
  patchit.sblk(btex $s$\strut etex, 0);
  group.dx=10;group.width=sblk.width;

  group.height=group.width;sblk.height=sblk.width;

  group.s - sblk.n = (0,30);
  .5[group.w,sblk.w] - bi.e = (31,0);

  .5[d1.w,d4.w] - in.e = bi.w - .5[d1.e,d4.e] = (30,0);

  forsuffixes $=d1,d2,d3,d4,bi,group,sblk,in:
    $.borderscale = hardborderscale;
  endfor
  
  
  fixelement(in,d1,d2,d3,d4,bi,sblk,group);

  d = 6;
  def blockbox(text t) = draw t withpen pencircle scaled 3 withcolor .9white enddef;

  forsuffixes $=d1,d2,d3,d4,in,bi,sblk,group:
    blockbox($.nw+(-d,d) -- $.ne+(d,d) -- $.se+(d,-d) -- $.sw+(-d,-d) -- cycle);
  endfor

  drawelement(in,d1,d2,d3,d4,bi,group,sblk);
  drawconnpatch(in,d1)(..);
  drawconnpatch(in,d2)(..);
  drawconnpatch(in,d3)(..);
  drawconnpatch(in,d4)(..);
  drawconnpatch(d1,bi)(..);
  drawconnpatch(d2,bi)(..);
  drawconnpatch(d3,bi)(..);
  drawconnpatch(d4,bi)(..);
  drawconnpatch(group,sblk)(..);
endfig;

end
