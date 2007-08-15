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
  boxjoin(a.width = b.width);
  velementit.vfsiface(btex \raise1.5ex\hbox{VFS interface\strut}\strut etex, 1, 2, pull);
  velementit.uhfsa(btex UHFS\strut etex, 1, 1, pull);
  uhfsa.outpers[0] := 7;
  velementit.uhfsb(btex UHFS\strut etex, 1, 1, pull);
  uhfsb.outpers[0] := 7;
  velementit.ufsa(btex ext2-1\strut etex, 1, 1, 7);
  ufsa.outpers[0] := push;
  velementit.journal(btex \raise1.5ex\hbox{journal\strut}\strut etex, 1, 2, push);
  velementit.loopd(btex \raise1.5ex\hbox{loop\strut}\strut etex, 1, 1, push);
  velementit.loopj(btex \raise1.5ex\hbox{loop\strut}\strut etex, 1, 1, push);
  velementit.ufsb(btex ext2-0\strut etex, 1, 1, 7);
  ufsb.outpers[0] := push;
  velementit.wbcache(btex cache\strut etex, 1, 1, push);
  velementit.resizer(btex block resizer\strut etex, 1, 1, push);
  velementit.ide(btex SATA sda\strut etex, 1, 0, push);
  boxjoin();

  uhfsb.s - ufsa.n = ufsa.s - journal.n
  = uhfsa.s - ufsb.n = ufsb.s - wbcache.n = wbcache.s - resizer.n
  = resizer.s - ide.n
  = (0,20);
  loopj.w - loopd.e = (10,0);
  uhfsb.w - uhfsa.e = (60,0);
  %ypart(loopd.n - resizer.n) = ypart(loopj.n - resizer.n) = 0;
  journal.s - .5[loopd.n,loopj.n] = (0,20);
  vfsiface.s - .5[uhfsa.n,uhfsb.n] = (0,25);

  fixelement (resizer,ide,wbcache,ufsa,ufsb,uhfsa,uhfsb,journal,loopd,loopj,vfsiface);
  drawelement(resizer,ide,wbcache,ufsa,ufsb,uhfsa,uhfsb,journal,loopd,loopj,vfsiface);
  drawconnect(uhfsa,0,0,ufsb) dashed evenly;
  drawconnect(uhfsb,0,0,ufsa) dashed evenly;
  drawconnect(ufsa,0,0,journal);
  drawconnect(journal,0,0,loopd);
  drawconnect(journal,1,0,loopj);
%  drawconnarrow loopd.out[1]{down} .. ufsa.nw - (10,0) .. ufsa.sw - (10,0) .. {down}jqueue.in[0] withcolor 0.7white;
% These loop -> ufs connection arraows are crazy
%  drawconnect(loopd,0,0,ufsb) dashed evenly;
%  drawconnect(loopj,0,0,ufsb) dashed evenly;
  drawconnect(ufsb,0,0,wbcache);
  drawconnect(wbcache,0,0,resizer);
  drawconnect(resizer,0,0,ide);
  drawconnarrow vfsiface.in[0] + (0,15) -- vfsiface.in[0] dashed evenly scaled 0.5;
  drawconnect(vfsiface,0,0,uhfsa) dashed evenly scaled 0.5;
  drawconnect(vfsiface,1,0,uhfsb) dashed evenly scaled 0.5;
  label.top(btex application etex, vfsiface.in[0]+(0,15));
% Slightly better loop -> ufs connections
  drawconnarrowna loopd.out[0] {down}
  .. loopd.out[0] - (24,15) {left}
  .. .5[loopd.sw,resizer.se] {up}
  .. (xpart .5[loopd.w,resizer.e], ypart ufsb.n) {up}
  .. .5[uhfsa.ne,ufsb.s] {left}
  .. {down}ufsb.in[0]
  dashed evenly;
  drawconnarrowna loopj.out[0] {down}
  .. loopj.out[0] - (24,15) {left}
  .. {left} loopd.out[0] - (17,15)
  dashed evenly;


  save xscal; xscal = 0.7;
  label.rt(btex L2FS etex scaled xscal rotated -90, .5[.5[loopd.sw,resizer.se], (xpart .5[loopd.w,resizer.e], ypart ufsb.n)]);
  label.urt(btex VFS etex scaled xscal, vfsiface.in[0]+(0,1));
  label.top(btex CFS etex scaled xscal, .5[vfsiface.out[0],uhfsa.in[0]]);
  label.top(btex CFS etex scaled xscal, .5[vfsiface.out[1],uhfsb.in[0]]);
  label.lft(btex L2FS etex scaled xscal, .5[uhfsa.out[0],ufsb.in[0]]);
  label.rt(btex L2FS etex scaled xscal, .5[uhfsb.out[0],ufsa.in[0]]);
  label.rt(btex BD etex scaled xscal, .5[ufsa.out[0],journal.in[0]]);
  label.rt(btex BD etex scaled xscal, .5[ufsb.out[0],wbcache.in[0]]);
  label.lft(btex BD etex scaled xscal, .5[journal.out[0],loopd.in[0]]+(-2,3));
  label.rt(btex BD etex scaled xscal, .5[journal.out[1],loopj.in[0]]+(2,3));
  label.rt(btex BD etex scaled xscal, .5[wbcache.out[0],resizer.in[0]]);
  label.rt(btex BD etex scaled xscal, .5[resizer.out[0],ide.in[0]]);
  label.top(btex \texttt{/\strut} etex scaled xscal, vfsiface.out[0] + (0,2));
  label.top(btex \texttt{/loop\strut} etex scaled xscal, vfsiface.out[1] + (0,2));
  label.top(btex data\strut etex scaled xscal, journal.out[0] + (0,2));
  label.top(btex journal\strut etex scaled xscal, journal.out[1] + (0,2));
  label.top(btex \texttt{/fs.img\strut} etex scaled xscal, loopd.out[0] + (0,2));
  label.top(btex \texttt{/fs.journal\strut} etex scaled xscal, loopj.out[0] + (0,2));
endfig;


beginfig(2);
  boxjoin(a.width = b.width; a.height = b.height);
  patchit.crc(btex Complete\strut etex scaled 0.8, 0);
  patchit.a(btex Clear\strut etex, 0);
  patchit.b(btex Alloc\strut etex, 0);
  patchit.c(btex Attach\strut etex, 0);
  patchit.d(btex Size\strut etex, 0);
  patchit.cr(btex Commit\strut etex scaled 0.8, 0);
  patchit.aj(btex Clear\subj\strut etex, 0);
  patchit.bj(btex Alloc\subj\strut etex, 0);
  patchit.cj(btex Attach\subj\strut etex, 0);
  patchit.dj(btex Size\subj\strut etex, 0);
  crc.width = 1.2crc.height;

  boxjoin(a.width = a.height);
  patchit.crcn(btex etex, 0);
  patchit.fn(btex etex, 0);
  patchit.crn(btex etex, 0);
  crcn.width = fn.width = crn.width = crn.height = 0.6crc.width;
  
  b.w - a.e = d.w - c.e = bj.w - aj.e = dj.w - cj.e = (10,0);
  b.s - d.n = bj.s - dj.n = (0,10);
  .5[aj.w,cj.w] - crn.e = fn.w - .5[b.e,d.e] = .5[a.w,c.w] - crcn.e = (25, 0);
  crn.w - cr.e = cr.w - fn.e = crcn.w - crc.e = (12, 0);

  drawelement(crc,cr,aj,crcn,a,b,c,d,fn,crn,bj,cj,dj);

  vardef ffff(suffix a,b) =
    drawconnpatch(a,b)(..)
  enddef;

  %forsuffixes $ = crcn, fn, crn:
  %  draw (.2[$.sw,$.se] -- .8[$.nw,$.ne]) cutafter bpath.$ cutbefore bpath.$;
  %endfor;

  ffff(crc,crcn);
  ffff(crcn,a);
  ffff(crcn,c);
  drawconnpatch(crcn,b)(-- crcn.c + (0,2) .. tension 2 .. .3[a.s,c.n] .. );
  drawconnpatch(crcn,d)(-- crcn.c - (0,2) .. tension 2 .. .7[a.s,c.n] ..);
  ffff(b,fn);
  ffff(d,fn);
  drawconnpatch(a,fn)(.. .3[b.s,d.n] .. tension 2 .. fn.c + (0,2) --);
  drawconnpatch(c,fn)(.. .7[b.s,d.n] .. tension 2 .. fn.c - (0,2) --);
  ffff(fn,cr);
  ffff(cr,crn);
  ffff(crn,aj);
  ffff(crn,cj);
  drawconnpatch(crn,bj)(-- crn.c + (0,2) .. tension 2 .. .3[aj.s,cj.n] .. );
  drawconnpatch(crn,dj)(-- crn.c - (0,2) .. tension 2 .. .7[aj.s,cj.n] ..);

  linecap := butt;
  draw a.nw + (-10,10) -- b.ne + (10,10)
  -- d.se + (10,-10) -- c.sw + (-10,-10) -- cycle withpen pencircle scaled 2 dashed evenly;
  draw aj.nw + (-10,10) -- bj.ne + (10,10)
  -- dj.se + (10,-10) -- cj.sw + (-10,-10) -- cycle withpen pencircle scaled 2 dashed evenly;

  label.bot(btex Original FS data\strut etex, .5[c.s,d.s] - (0,12));
  label.bot(btex Journal data\strut etex, .5[cj.s,dj.s] - (0,12));
endfig;

beginfig(3);
  boxjoin(a.width = b.width; a.height = b.height);
  patchit.a(btex Clear etex scaled 0.8, 0);
  patchit.b(btex Alloc etex scaled 0.8, 0);
  patchit.c(btex Attach etex scaled 0.8, 0);
  patchit.d(btex Size etex scaled 0.8, 0);
  a.width = 1.2a.height;

  a.w - c.e = (12, 1.2*a.height);
  c.w - d.e = b.w - c.e = (12, 0);

  drawelement(a,b,c,d);

  drawconnpatch(c,a)(..);
  drawconnpatch(c,b)(..);
  drawconnpatch(d,c)(..);
endfig;

beginfig(4);
  boxjoin(a.width = b.width; a.height = b.height);
  patchit.a(btex $s$\strut etex, 0);
  patchit.b(btex $r$\strut etex, 0);
  patchit.c(btex $q$\strut etex, 0);
  patchit.d(btex $p$\strut etex, 0);
  a.width=a.height;

  d.w-c.e=c.w-b.e=b.w-a.e=(10,0);

  drawelement(a,b,c,d);
  drawconnpatch(a,b)(..);
  drawconnpatch(a,c)({dir 50}..);
  drawconnpatch(a,d)({dir 52}..{dir -40});
endfig;

beginfig(6);
  boxjoin(a.width = b.width; a.height = b.height);
  patchit.a(btex $s$\strut etex, 0);
  patchit.b(btex $r$\strut etex, 0);
  patchit.c(btex $q$\strut etex, 0);
  patchit.d(btex $p$\strut etex, 0);
  a.width=a.height;

  d.w-c.e=c.w-b.e=b.w-a.e=(10,0);

  drawelement(a,b,c,d);
  drawconnpatch(a,b)(..);
  drawconnpatch(b,c)(..);
  drawconnpatch(c,d)(..);
endfig;


beginfig(5);
  boxjoin(a.width = b.width; a.height = b.height);
  patchit.h(btex $h_p$ etex, 0);
  patchit.t(btex $t_p$ etex, 0);
  patchit.hq(btex $h_q$ etex, 0);
  patchit.tq(btex $t_q$ etex, 0);

  patchit.aa(btex $a_1$ etex, 0);
  patchit.ab(btex $a_2$ etex, 0);
  patchit.ac(btex $a_3$ etex, 0);
  patchit.b(btex $b$ etex, 0);
  patchit.c(btex $c$ etex, 0);
  h.width = h.height;

  t.w - h.e = (3h.width,0);
  .5[t.c,h.c] - .5[b.c,ab.c] = (0,25);

  hq.w - t.e = (h.width,0);
  tq.w - hq.e = (2h.width,0);
  .5[tq.c,hq.c] - c.c = (0,25);

  ab.w - b.e = (0.5*h.width, 0);
  ac.w - aa.e = (0.5*h.width, 0);
  ab.s - ac.n = (0, h.height/2);

  fillelement(hq,tq,c)(.9white);
  drawelement(h,t,aa,ab,ac,b,hq,tq,c);

  vardef ffff(suffix a,b) =
    drawconnpatch(a,b)(..)
  enddef;

  ffff(h,t);

  ffff(h,aa);
  ffff(h,b);

  ffff(ab,t);
  ffff(ac,t);
  drawconnpatch(b,t)(.. ab.nw ..);

  ffff(b,aa);

  ffff(aa,ab);
  ffff(aa,ac);

  drawconnpatch(t,hq)(..) withpen connectionpen scaled 3;
  drawconnpatch(hq,tq)(..);
  drawconnpatch(hq,c)(..);
  drawconnpatch(c,tq)(..);
endfig;


beginfig(7);
  boxjoin(a.width = b.width; a.height = b.height);
  patchit.hp(btex $h_\textit{pg}$ etex, 0);
  patchit.tp(btex $t_\textit{pg}$ etex, 0);
  patchit.hx(btex $h_\textit{xg}$ etex, 0);
  patchit.tq(btex $t_\textit{qg}$ etex, 0);

  tq.width = tq.height;

  hp.w - tq.e = hx.w - tp.e = (50,0);
  tp.w - hp.e = (120,0);

  drawelement(hp,tp,hx,tq);

  label(btex \mlabel{f{}ile system changes\\written during\\\texttt{pg\char`\_engage(}\textit{pg}\texttt{)}} etex scaled 0.8, .5[hp.c,tp.c]);
  label.top(btex \mlabel{\texttt{pg\char`\_depend}\\\texttt{(}\textit{qg}\texttt{,} \textit{pg}\texttt{)}} etex scaled 0.8, .5[tq.c,hp.c]);
  label.top(btex \mlabel{\texttt{pg\char`\_depend}\\\texttt{(}\textit{pg}\texttt{,} \textit{xg}\texttt{)}} etex scaled 0.8, .5[tp.c,hx.c]);
  drawconnpatch(tq,hp)(..);
  drawconnpatch(tp,hx)(..);
  drawconnarrow hp.c -- hp.c + (35,10) cutbefore bpath.hp;
  drawconnarrow hp.c -- hp.c + (42,-2) cutbefore bpath.hp;
  drawconnarrow hp.c -- hp.c + (30,-10) cutbefore bpath.hp;
  drawconnarrow tp.c + (-35,10) -- tp.c cutafter bpath.tp;
  drawconnarrow tp.c + (-42,3) -- tp.c cutafter bpath.tp;
  drawconnarrow tp.c + (-40,-4) -- tp.c cutafter bpath.tp;
  drawconnarrow tp.c + (-38,-14) -- tp.c cutafter bpath.tp;
  drawconnarrow tq.w - (10,5) -- tq.c cutafter bpath.tq;
  drawconnarrow tq.w - (12,-2) -- tq.c cutafter bpath.tq;
  drawconnarrow hx.c -- hx.e + (10,0) cutbefore bpath.hx;
endfig;

end
