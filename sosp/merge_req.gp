#!/usr/bin/env gnuplot

set terminal postscript eps enhanced color
set output "merge_req.eps"

set xlabel "Disk request size (sectors)"
set ylabel "Number of requests"

set logscale y
set xrange [0:1024]
set xtics 128
set size .8,.8

plot "data/merge_req" index 0 title "Linux ext2", "data/merge_req" index 2 title "Kudos ext2"
