#!/usr/bin/env gnuplot

set terminal postscript eps enhanced
set xtics ("None" 1, "Hard Patches" 2, "Overlap Merging" 3, "Hard + Overlap" 4)

set output "opts-patches.eps"
set xlabel "Optimization"
set ylabel "# Patches"
plot [0.5:4.5] [0:] \
	"data/opts" using \
		($1-0.2):7:(0.4) index 0 title "untar" with boxes fs solid 0.2 lt 1, \
	"data/opts" using \
		($1+0.2):7:(0.4) index 1 title "rm" with boxes fs solid 0.6 lt 1

set logscale y
set output "opts-rollback.eps"
set xlabel "Optimization"
set ylabel "Rollback Data (MB)"
plot [0.5:4.5] \
	"data/opts" using \
		($1-0.2):($10/(1024*1024)):(0.4) \
		index 0 title "untar" with boxes fs solid 0.2 lt 1, \
	"data/opts" using \
		($1+0.2):($10/(1024*1024)):(0.4) \
		index 1 title "rm" with boxes fs solid 0.6 lt 1
