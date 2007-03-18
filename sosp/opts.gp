#!/usr/bin/env gnuplot

set terminal postscript eps enhanced
set xtics ("None" 1.5, "Hard Patches" 3.5, "Overlap Merging" 5.5, "Hard + Overlap" 7.5)
#set xtics ("None u" 1, "rm" 2, "Hard Patches" 3, "Hard Patches" 4, "Overlap Merging" 5, "Overlap Merging" 6, "Hard + Overlap" 7, "Hard + Overlap" 8)

set output "opts-patches.eps"
set xlabel "Optimization"
set ylabel "# Patches"
plot \
	[0.5:8.5] [0:] \
	"data/opts" using 1:7 index 0 title "untar" with boxes fs solid 0.2 lt 1, \
	"data/opts" using 1:7 index 1 title "rm" with boxes fs solid 0.6 lt 1

set logscale y
set output "opts-rollback.eps"
set xlabel "Optimization"
set ylabel "Rollback Data (MB)"
#plot [0.5:8.5] "opts.data" using 1:($10/(1024*1024)) with boxes title ""
plot \
	[0.5:8.5] \
	"data/opts" using 1:($10/(1024*1024)) index 0 title "untar" with boxes fs solid 0.2 lt 1, \
	"data/opts" using 1:($10/(1024*1024)) index 1 title "rm" with boxes fs solid 0.6 lt 1
