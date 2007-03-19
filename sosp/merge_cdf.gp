#!/usr/bin/env gnuplot

set terminal postscript eps enhanced
set output "merge_cdf.eps"

set xlabel "Disk request size (sectors)"
set ylabel "Cumulative # requests"

set key bottom
set xrange [0:1024]
set yrange [0:]
set xtics 128
set size .7,.5

plot "data/merge_cdf" index 2 title "Dodder ext2 with soft updates" with lines lt 1, "data/merge_cdf" index 0 title "Linux ext2" with lines lt 3
