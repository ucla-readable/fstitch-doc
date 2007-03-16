input patches;
verbatimtex %&latex
\documentclass[12pt]{article}
\usepackage{elemfig,amsmath}
\def\subj{\setbox0\hbox{$_{\mbox{J}}$}\dp0=0pt\box0}
\begin{document}
etex;
picture emptyqueue; emptyqueue := btex \phantom{\elementlabel{Queue}} etex;
picture vemptyqueue; vemptyqueue := emptyqueue rotated 90 xscaled .4;

beginfig(1);
  boxjoin(a.width = b.width; a.s = b.n + (0,40));
  patchit.sza(btex size\strut etex,0);
  patchit.szb(btex size\strut etex,0);
  patchit.szc(btex size\strut etex,0);
  patchit.szd(btex size\strut etex,0);
  
  boxjoin(a.width = b.width; a.s = b.n + (0,40));
  patchit.bka(btex blockptr\strut etex,0);
  patchit.bkb(btex blockptr\strut etex,0);
  patchit.bkc(btex blockptr\strut etex,0);
  patchit.bkd(btex blockptr\strut etex,0);

  boxjoin(a.width = b.width);
  patchit.da(btex data 1\strut etex, 1);
  patchit.db(btex data 2\strut etex, 1);
  patchit.dc(btex data 3\strut etex, 1);
  patchit.dd(btex data 4\strut etex, 1);
  patchit.ia(btex zero 1\strut etex, 1);
  patchit.ib(btex zero 2\strut etex, 1);
  patchit.ic(btex zero 3\strut etex, 1);
  patchit.id(btex zero 4\strut etex, 1);

  boxjoin(a.width = b.width);
  patchit.bia(btex bitmap\strut etex, 2);
  patchit.bib(btex bitmap\strut etex, 2);
  patchit.bic(btex bitmap\strut etex, 2);
  patchit.bid(btex bitmap\strut etex, 2);
  bia.squatness=bib.squatness=bic.squatness=bid.squatness=0.6;
  bia.dx=12;

  boxjoin();
  patchit.mtime(btex mtime\strut etex, 0);
  patchit.group(btex group\strut etex, 3);
  patchit.sblk(btex superblk\strut etex, 3);

  mtime.n = .5[szd.c,bkd.c] - (0,40);
  ypart group.c = ypart mtime.c;
  sblk.w - group.e = (30,0);
  xpart .5[sblk.c,group.c] = xpart .5[dd.c,bid.c];
  
  bka.width = sza.width = mtime.width; group.width=sblk.width;
  bka.w = .3[sza.s,szb.n] + (20,0);

  da.w-sza.e = db.w-szb.e = dc.w-szc.e = dd.w-szd.e = (70,0);
  ia.w-da.e = ib.w-db.e = ic.w-dc.e = id.w-dd.e = (20,0);
  bia.w-ia.e = bib.w-ib.e = bic.w-ic.e = bid.w-id.e = (30,0);
  
  
  fixelement(bka,bkb,bkc,bkd,sza,szb,szc,szd,da,db,dc,dd,ia,ib,ic,id,bia,bib,bic,bid,mtime,sblk,group);
  drawelement(bka,bkb,bkc,bkd,sza,szb,szc,szd,da,db,dc,dd,ia,ib,ic,id,bia,bib,bic,bid,mtime,group,sblk);
  drawconnpatch(szb,sza)(..);
  drawconnpatch(szc,szb)(..);
  drawconnpatch(szd,szc)(..);
  drawconnpatch(bkb,bka)(..);
  drawconnpatch(bkc,bkb)(..);
  drawconnpatch(bkd,bkc)(..);
  drawconnpatch(sza,da)(..);
  drawconnpatch(szb,db)(..);
  drawconnpatch(szc,dc)(..);
  drawconnpatch(szd,dd)(..);
  drawconnpatch(da,ia)(..);
  drawconnpatch(db,ib)(..);
  drawconnpatch(dc,ic)(..);
  drawconnpatch(dd,id)(..);
  drawconnpatch(bka,ia)(..{right}(xpart ia.w,ypart bka.c).. {up});
  drawconnpatch(bkb,ib)(..{right}(xpart ib.w,ypart bkb.c).. {up});
  drawconnpatch(bkc,ic)(..{right}(xpart ic.w,ypart bkc.c).. {up});
  drawconnpatch(bkd,id)(..{right}(xpart id.w,ypart bkd.c).. {up});
  drawconnpatch(ia,bia)(..);
  drawconnpatch(ib,bib)(..);
  drawconnpatch(ic,bic)(..);
  drawconnpatch(id,bid)(..);
  drawconnpatch(group,sblk)(..);
endfig;


beginfig(2);
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
  dd.s - .5[group.n,sblk.n] = (0,20);
  sblk.w - group.e = (30,0);
  
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

end
