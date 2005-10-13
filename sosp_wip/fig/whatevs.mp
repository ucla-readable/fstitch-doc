input elements;
verbatimtex %&latex
\documentclass[12pt]{article}
\usepackage{elemfig}
\begin{document}
etex;
picture emptyqueue; emptyqueue := btex \phantom{\elementlabel{Queue}} etex;
picture vemptyqueue; vemptyqueue := emptyqueue rotated 90 xscaled .4;

personalitycolor[7] = 0.9white;

beginfig(1);
  boxjoin(a.width = b.width);
  velementit.classifier(btex \raise0.8ex\hbox{classif{}ier\strut}\strut etex, 1, 2, pull);
  velementit.uhfsa(btex uhfs\strut etex, 1, 1, pull);
  uhfsa.outpers[0] := 7;
  velementit.uhfsb(btex uhfs\strut etex, 1, 1, pull);
  uhfsb.outpers[0] := 7;
  velementit.josfsa(btex josfs-1\strut etex, 1, 1, 7);
  josfsa.outpers[0] := push;
  velementit.journal(btex \raise0.8ex\hbox{journal\strut}\strut etex, 1, 2, push);
  velementit.loopj(btex \raise0.8ex\hbox{loop\strut}\strut etex, 1, 1, push);
  velementit.loopd(btex \raise0.8ex\hbox{loop\strut}\strut etex, 1, 1, push);
  velementit.josfsb(btex josfs-0\strut etex, 1, 1, 7);
  josfsb.outpers[0] := push;
  velementit.wbcache(btex wbcache\strut etex, 1, 1, push);
  velementit.resizer(btex block\_resizer\strut etex, 1, 1, push);
  velementit.ide(btex ide\_hda\strut etex, 1, 0, push);
  boxjoin();

  uhfsb.s - josfsa.n = josfsa.s - journal.n
  = uhfsa.s - josfsb.n = josfsb.s - wbcache.n = wbcache.s - resizer.n
  = resizer.s - ide.n
  = (0,20);
  loopd.w - loopj.e = (10,0);
  uhfsb.w - uhfsa.e = (60,0);
  %ypart(loopj.n - resizer.n) = ypart(loopd.n - resizer.n) = 0;
  journal.s - .5[loopj.n,loopd.n] = (0,20);
  classifier.s - .5[uhfsa.n,uhfsb.n] = (0,25);

  fixelement (resizer,ide,wbcache,josfsa,josfsb,uhfsa,uhfsb,journal,loopj,loopd,classifier);
  drawelement(resizer,ide,wbcache,josfsa,josfsb,uhfsa,uhfsb,journal,loopj,loopd,classifier);
  drawconnarrow uhfsa.out[0]{down} .. loopj.nw - (15,0) .. loopj.sw - (15,0) .. {down}josfsb.in[0] dashed evenly;
  drawconnect(uhfsb,0,0,josfsa) dashed evenly;
  drawconnect(josfsa,0,0,journal);
  drawconnect(journal,0,0,loopj);
  drawconnect(journal,1,0,loopd);
%  drawconnarrow loopj.out[1]{down} .. josfsa.nw - (10,0) .. josfsa.sw - (10,0) .. {down}jqueue.in[0] withcolor 0.7white;
% These loop -> josfs connection arraows are crazy
%  drawconnect(loopj,0,0,josfsb) dashed evenly;
%  drawconnect(loopd,0,0,josfsb) dashed evenly;
  drawconnect(josfsb,0,0,wbcache);
  drawconnect(wbcache,0,0,resizer);
  drawconnect(resizer,0,0,ide);
  drawconnarrow classifier.in[0] + (0,15) -- classifier.in[0] dashed evenly scaled 0.5;
  drawconnect(classifier,0,0,uhfsa) dashed evenly scaled 0.5;
  drawconnect(classifier,1,0,uhfsb) dashed evenly scaled 0.5;
  label.top(btex application etex, classifier.in[0]+(0,15));
% Slightly better loop -> josfs connections
  drawconnarrowna loopj.out[0] {down}
  .. loopj.out[0] - (24,15) {left}
  .. .5[loopj.sw,resizer.se] {up}
  .. (xpart .5[loopj.w,resizer.e], ypart josfsb.n) {up}
  .. .5[uhfsa.ne,josfsb.s] {left}
  .. {down}josfsb.in[0]
  dashed evenly;
  drawconnarrowna loopd.out[0] {down}
  .. loopd.out[0] - (24,15) {left}
  .. {left} loopj.out[0] - (17,15)
  dashed evenly;


  label.urt(btex VFS etex scaled 0.5, classifier.in[0]);
  label.lrt(btex VFS etex scaled 0.5, classifier.out[0]);
  label.llft(btex VFS etex scaled 0.5, classifier.out[1]);
  label.ulft(btex VFS etex scaled 0.5, uhfsa.in[0]);
  label.urt(btex VFS etex scaled 0.5, uhfsb.in[0]);
  label.llft(btex LFS etex scaled 0.5, uhfsa.out[0]);
  label.lrt(btex LFS etex scaled 0.5, uhfsb.out[0]);
  label.urt(btex BD etex scaled 0.5, journal.in[0]);
  label.lrt(btex BD etex scaled 0.5, journal.out[0]);
  label.llft(btex BD etex scaled 0.5, journal.out[1]);
  label.urt(btex LFS etex scaled 0.5, josfsa.in[0]);
  label.lrt(btex BD etex scaled 0.5, josfsa.out[0]);
  label.ulft(btex LFS etex scaled 0.5, josfsb.in[0]);
  label.lrt(btex BD etex scaled 0.5, josfsb.out[0]);
  label.ulft(btex BD etex scaled 0.5, loopj.in[0]);
  label.lrt(btex LFS etex scaled 0.5, loopj.out[0]);
  label.urt(btex BD etex scaled 0.5, loopd.in[0]);
  label.lrt(btex LFS etex scaled 0.5, loopd.out[0]);
  label.urt(btex BD etex scaled 0.5, wbcache.in[0]);
  label.lrt(btex BD etex scaled 0.5, wbcache.out[0]);
  label.urt(btex BD etex scaled 0.5, resizer.in[0]);
  label.lrt(btex BD etex scaled 0.5, resizer.out[0]);
  label.urt(btex BD etex scaled 0.5, ide.in[0]);
  label.top(btex \texttt{/\strut} etex scaled 0.5, classifier.out[0] + (0,2));
  label.top(btex \texttt{/loop\strut} etex scaled 0.5, classifier.out[1] + (0,2));
  label.top(btex journal\strut etex scaled 0.5, journal.out[0] + (0,2));
  label.top(btex data\strut etex scaled 0.5, journal.out[1] + (0,2));
  label.top(btex \texttt{/fs.journal\strut} etex scaled 0.5, loopj.out[0] + (0,2));
  label.top(btex \texttt{/fs.img\strut} etex scaled 0.5, loopd.out[0] + (0,2));
endfig;

end
