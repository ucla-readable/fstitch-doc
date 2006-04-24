input elements;
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
  boxjoin(a.width = b.width);
  velementit.selector(btex \raise0.8ex\hbox{mount selector\strut}\strut etex, 1, 2, pull);
  velementit.uhfsa(btex UHFS\strut etex, 1, 1, pull);
  uhfsa.outpers[0] := 7;
  velementit.uhfsb(btex UHFS\strut etex, 1, 1, pull);
  uhfsb.outpers[0] := 7;
  velementit.ufsa(btex UFS-1\strut etex, 1, 1, 7);
  ufsa.outpers[0] := push;
  velementit.journal(btex \raise0.8ex\hbox{journal\strut}\strut etex, 1, 2, push);
  velementit.loopj(btex \raise0.8ex\hbox{loop\strut}\strut etex, 1, 1, push);
  velementit.loopd(btex \raise0.8ex\hbox{loop\strut}\strut etex, 1, 1, push);
  velementit.ufsb(btex UFS-0\strut etex, 1, 1, 7);
  ufsb.outpers[0] := push;
  velementit.wbcache(btex wb cache\strut etex, 1, 1, push);
  velementit.resizer(btex block resizer\strut etex, 1, 1, push);
  velementit.ide(btex IDE hda\strut etex, 1, 0, push);
  boxjoin();

  uhfsb.s - ufsa.n = ufsa.s - journal.n
  = uhfsa.s - ufsb.n = ufsb.s - wbcache.n = wbcache.s - resizer.n
  = resizer.s - ide.n
  = (0,20);
  loopd.w - loopj.e = (10,0);
  uhfsb.w - uhfsa.e = (60,0);
  %ypart(loopj.n - resizer.n) = ypart(loopd.n - resizer.n) = 0;
  journal.s - .5[loopj.n,loopd.n] = (0,20);
  selector.s - .5[uhfsa.n,uhfsb.n] = (0,25);

  fixelement (resizer,ide,wbcache,ufsa,ufsb,uhfsa,uhfsb,journal,loopj,loopd,selector);
  drawelement(resizer,ide,wbcache,ufsa,ufsb,uhfsa,uhfsb,journal,loopj,loopd,selector);
  drawconnect(uhfsa,0,0,ufsb) dashed evenly;
  drawconnect(uhfsb,0,0,ufsa) dashed evenly;
  drawconnect(ufsa,0,0,journal);
  drawconnect(journal,0,0,loopj);
  drawconnect(journal,1,0,loopd);
%  drawconnarrow loopj.out[1]{down} .. ufsa.nw - (10,0) .. ufsa.sw - (10,0) .. {down}jqueue.in[0] withcolor 0.7white;
% These loop -> ufs connection arraows are crazy
%  drawconnect(loopj,0,0,ufsb) dashed evenly;
%  drawconnect(loopd,0,0,ufsb) dashed evenly;
  drawconnect(ufsb,0,0,wbcache);
  drawconnect(wbcache,0,0,resizer);
  drawconnect(resizer,0,0,ide);
  drawconnarrow selector.in[0] + (0,15) -- selector.in[0] dashed evenly scaled 0.5;
  drawconnect(selector,0,0,uhfsa) dashed evenly scaled 0.5;
  drawconnect(selector,1,0,uhfsb) dashed evenly scaled 0.5;
  label.top(btex application etex, selector.in[0]+(0,15));
% Slightly better loop -> ufs connections
  drawconnarrowna loopj.out[0] {down}
  .. loopj.out[0] - (24,15) {left}
  .. .5[loopj.sw,resizer.se] {up}
  .. (xpart .5[loopj.w,resizer.e], ypart ufsb.n) {up}
  .. .5[uhfsa.ne,ufsb.s] {left}
  .. {down}ufsb.in[0]
  dashed evenly;
  drawconnarrowna loopd.out[0] {down}
  .. loopd.out[0] - (24,15) {left}
  .. {left} loopj.out[0] - (17,15)
  dashed evenly;


  label.urt(btex VFS etex scaled 0.5, selector.in[0]);
  label.lrt(btex VFS etex scaled 0.5, selector.out[0]);
  label.llft(btex VFS etex scaled 0.5, selector.out[1]);
  label.ulft(btex VFS etex scaled 0.5, uhfsa.in[0]);
  label.urt(btex VFS etex scaled 0.5, uhfsb.in[0]);
  label.llft(btex LFS etex scaled 0.5, uhfsa.out[0]);
  label.lrt(btex LFS etex scaled 0.5, uhfsb.out[0]);
  label.urt(btex BD etex scaled 0.5, journal.in[0]);
  label.lrt(btex BD etex scaled 0.5, journal.out[0]);
  label.llft(btex BD etex scaled 0.5, journal.out[1]);
  label.urt(btex LFS etex scaled 0.5, ufsa.in[0]);
  label.lrt(btex BD etex scaled 0.5, ufsa.out[0]);
  label.ulft(btex LFS etex scaled 0.5, ufsb.in[0]);
  label.lrt(btex BD etex scaled 0.5, ufsb.out[0]);
  label.ulft(btex BD etex scaled 0.5, loopj.in[0]);
  label.lrt(btex LFS etex scaled 0.5, loopj.out[0]);
  label.urt(btex BD etex scaled 0.5, loopd.in[0]);
  label.lrt(btex LFS etex scaled 0.5, loopd.out[0]);
  label.urt(btex BD etex scaled 0.5, wbcache.in[0]);
  label.lrt(btex BD etex scaled 0.5, wbcache.out[0]);
  label.urt(btex BD etex scaled 0.5, resizer.in[0]);
  label.lrt(btex BD etex scaled 0.5, resizer.out[0]);
  label.urt(btex BD etex scaled 0.5, ide.in[0]);
  label.top(btex \texttt{/\strut} etex scaled 0.5, selector.out[0] + (0,2));
  label.top(btex \texttt{/loop\strut} etex scaled 0.5, selector.out[1] + (0,2));
  label.top(btex journal\strut etex scaled 0.5, journal.out[0] + (0,2));
  label.top(btex data\strut etex scaled 0.5, journal.out[1] + (0,2));
  label.top(btex \texttt{/fs.journal\strut} etex scaled 0.5, loopj.out[0] + (0,2));
  label.top(btex \texttt{/fs.img\strut} etex scaled 0.5, loopd.out[0] + (0,2));
endfig;


beginfig(2);
  boxjoin(a.width = b.width; a.height = b.height);
  elementit.crc(btex Complete etex scaled 0.8, 0, 0, pull);
  elementit.crcn(btex etex, 0, 0, pull);
  elementit.a(btex Clear etex scaled 0.8, 0, 0, pull);
  elementit.b(btex Alloc etex scaled 0.8, 0, 0, pull);
  elementit.c(btex Attach etex scaled 0.8, 0, 0, pull);
  elementit.d(btex Size etex scaled 0.8, 0, 0, pull);
  elementit.fn(btex etex, 0, 0, pull);
  elementit.cr(btex Commit etex scaled 0.8, 0, 0, pull);
  elementit.crn(btex etex, 0, 0, pull);
  elementit.aj(btex Clear\subj etex scaled 0.8, 0, 0, pull);
  elementit.bj(btex Alloc\subj etex scaled 0.8, 0, 0, pull);
  elementit.cj(btex Attach\subj etex scaled 0.8, 0, 0, pull);
  elementit.dj(btex Size\subj etex scaled 0.8, 0, 0, pull);
  crc.width = 1.2crc.height;

  a.s - b.n = aj.s - bj.n = cj.s - dj.n = (0,5);
  b.s - c.n = bj.s - cj.n = c.s - d.n = (0,5);
  .5[bj.w,cj.w] - crn.e = fn.w - .5[b.e,c.e] = .5[b.w,c.w] - crcn.e = (25, 0);
  crn.w - cr.e = cr.w - fn.e = crcn.w - crc.e = (12, 0);

  forsuffixes $ = crc, crcn, a, b, c, fn, cr, crn, aj, bj, cj, d, dj:
    pproc_.$ := "thecirc_";
  endfor;

  crc.dx = 2;
  drawelement(crc,cr,aj,crcn,a,b,c,d,fn,crn,bj,cj,dj);

  vardef ffff(suffix a,b) =
    drawconnarrow (a.c -- b.c) cutbefore bpath.a cutafter bpath.b
  enddef;

  %forsuffixes $ = crcn, fn, crn:
  %  draw (.2[$.sw,$.se] -- .8[$.nw,$.ne]) cutafter bpath.$ cutbefore bpath.$;
  %endfor;

  ffff(crc,crcn);
  ffff(crcn,a);
  ffff(crcn,b);
  ffff(crcn,c);
  ffff(crcn,d);
  ffff(a,fn);
  ffff(b,fn);
  ffff(c,fn);
  ffff(d,fn);
  ffff(fn,cr);
  ffff(cr,crn);
  ffff(crn,aj);
  ffff(crn,bj);
  ffff(crn,cj);
  ffff(crn,dj);

  linecap := butt;
  draw a.nw + (-10,10) -- a.ne + (10,10)
  -- d.se + (10,-10) -- d.sw + (-10,-10) -- cycle withpen pencircle scaled 2 dashed evenly;
  draw aj.nw + (-10,10) -- aj.ne + (10,10)
  -- dj.se + (10,-10) -- dj.sw + (-10,-10) -- cycle withpen pencircle scaled 2 dashed evenly;

  label.bot(btex Original FS data\strut etex, d.s - (0,12));
  label.bot(btex Journal data\strut etex, dj.s - (0,12));
endfig;

beginfig(3);
  boxjoin(a.width = b.width; a.height = b.height);
  elementit.a(btex Clear etex scaled 0.8, 0, 0, pull);
  elementit.b(btex Alloc etex scaled 0.8, 0, 0, pull);
  elementit.c(btex Attach etex scaled 0.8, 0, 0, pull);
  elementit.d(btex Size etex scaled 0.8, 0, 0, pull);
  a.width = 1.2a.height;

  a.w - c.e = (12, 1.2*a.height);
  c.w - d.e = b.w - c.e = (12, 0);

  forsuffixes $ = a, b, c, d:
    pproc_.$ := "thecirc_";
  endfor;

  drawelement(a,b,c,d);

  vardef ffff(suffix a,b) =
    drawconnarrow (a.c -- b.c) cutbefore bpath.a cutafter bpath.b
  enddef;

  ffff(c,a);
  ffff(c,b);
  ffff(d,c);
endfig;

beginfig(4);
  boxjoin();
  elementit.a(btex Base etex scaled 1.2, 0, 0, pull);
  boxjoin(a.width = b.width; a.height = b.height);
  elementit.b(btex Alloc etex scaled 0.8, 0, 0, pull);
  elementit.c(btex DirEnt etex scaled 0.8, 0, 0, pull);
  elementit.d(btex CylGrp etex scaled 0.8, 0, 0, pull);
  elementit.e(btex Super etex scaled 0.8, 0, 0, pull);
  a.width = 1.2a.height;

  a.w - b.e = (12, -1.2*b.height);
  a.w - c.e = (12, 1.2*b.height);
  a.e - d.w = (-12, -1.2*b.height);
  a.e - e.w = (-12, 1.2*b.height);

  forsuffixes $ = a, b, c, d, e:
    pproc_.$ := "thecirc_";
  endfor;

  drawelement(a,b,c,d,e);

  vardef ffff(suffix a,b) =
    drawconnarrow (a.c -- b.c) cutbefore bpath.a cutafter bpath.b
  enddef;

  ffff(b,a);
  ffff(c,a);
  ffff(d,a);
  ffff(e,a);
endfig;

beginfig(5);
  label.top(btex Chdesc A etex, (15,25));
  boxjoin(a.width = b.width; a.height = b.height; a.s - b.n = (0,20));
  elementit.a(btex \quad Inode 17 \quad etex, 0, 0, pull);
  elementit.b(btex \quad Inode 17 \quad etex, 0, 0, pull);
  label.bot(btex Chdesc B etex, (50,-55));

  fixelement(a,b);

  fill a.nw -- .2[a.nw,a.ne] -- .2[a.sw,a.se] -- a.sw -- cycle withcolor .8white;
  fill b.ne -- .2[b.ne,b.nw] -- .2[b.se,b.sw] -- b.se -- cycle withcolor .8white;

  drawelement(a,b);
endfig;

beginfig(6);
  boxjoin(a.width = b.width; a.height = b.height);
  elementit.a(btex Noop etex scaled 0.8, 0, 0, pull);
  elementit.b(btex C1 etex scaled 0.8, 0, 0, pull);
  elementit.c(btex C2 etex scaled 0.8, 0, 0, pull);
  elementit.d(btex C3 etex scaled 0.8, 0, 0, pull);

  elementit.e(btex Noop etex scaled 0.8, 0, 0, pull);
  elementit.f(btex C1 etex scaled 0.8, 0, 0, pull);
  elementit.g(btex C2 etex scaled 0.8, 0, 0, pull);
  elementit.h(btex C3 etex scaled 0.8, 0, 0, pull);
  a.width = 1.2a.height;

  a.s - b.n = (1.2*a.width, 0.6*a.height);
  a.s - c.n = (0, 0.6*a.height);
  a.s - d.n = (-1.2*a.width, 0.6*a.height);

  e.s - a.s = (150, 0);
  e.s - f.n = (1.2*a.width, 0.6*a.height);
  e.s - g.n = (0, 0.6*a.height);
  e.s - h.n = (-1.2*a.width, 0.6*a.height);

  forsuffixes $ = a, b, c, d, e, f, g, h:
    pproc_.$ := "thecirc_";
  endfor;

  drawelement(a,b,c,d,e,f,g,h);

  vardef ffff(suffix a,b) =
    drawconnarrow (a.c -- b.c) cutbefore bpath.a cutafter bpath.b
  enddef;

  ffff(a,b);
  ffff(a,c);
  ffff(a,d);

  ffff(e,h);
  ffff(h,g);
  ffff(g,f);

endfig;

beginfig(7);
  boxjoin(a.width = b.width; a.height = b.height);
  elementit.hk(btex HK etex scaled 0.8, 0, 0, pull);
  elementit.tk(btex TK etex scaled 0.8, 0, 0, pull);
  elementit.h(btex H etex scaled 0.8, 0, 0, pull);
  elementit.t(btex T etex scaled 0.8, 0, 0, pull);

  elementit.aa(btex 1 etex scaled 0.8, 0, 0, pull);
  elementit.ab(btex 1 etex scaled 0.8, 0, 0, pull);
  elementit.ac(btex 1 etex scaled 0.8, 0, 0, pull);
  elementit.b(btex 2 etex scaled 0.8, 0, 0, pull);
  h.width = 1.2h.height;

  h.w - hk.e = (0.8*h.width, 0);
  t.w - tk.e = (0.8*h.width, 0);
  h.s - t.n = (0, 4*h.height);

  aa.w - b.e = (1.2*h.width, 0);
  ac.w - ab.e = (1.2*h.width, 0);
  aa.s - ac.n = (0, 1*h.height);
  h.nw - b.se = (-2.5*h.width, 2.5*h.height);

  forsuffixes $ = hk, tk, h, t, aa, ab, ac, b:
    pproc_.$ := "thecirc_";
  endfor;

  drawelement(hk,tk,h,t,aa,ab,ac,b);

  vardef ffff(suffix a,b) =
    drawconnarrow (a.c -- b.c) cutbefore bpath.a cutafter bpath.b
  enddef;

  ffff(h,hk);
  ffff(t,tk);
  ffff(h,t);

  ffff(h,aa);
  ffff(h,b);

  ffff(ab,t);
  ffff(ac,t);
  ffff(b,t);

  ffff(b,aa);

  ffff(aa,ab);
  ffff(aa,ac);

endfig;

end
