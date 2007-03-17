#!/usr/bin/env gnuplot

set terminal postscript eps enhanced
set output "rb_chdesc_size.eps"

set nokey
set xtics 4
set xlabel "Soft patch size (bytes)"
set ylabel "Number of patches"

plot "rb_chdesc_size.data" with points 2
