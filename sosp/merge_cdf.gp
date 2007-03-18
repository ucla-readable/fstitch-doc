#!/usr/bin/env gnuplot

set terminal postscript eps enhanced
set output "merge_cdf.eps"

set xlabel "Disk request size (sectors)"
set ylabel "Cumulative number of requests"

set key left
set xrange [0:1024]
set yrange [0:]
set xtics 128

plot "data/merge_cdf" index 0 title "Linux ext2" with lines lt 3, "data/merge_cdf" index 2 title "Kudos ext2" with lines lt 1
