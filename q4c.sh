#!/bin/bash
awk -F, '$8 == 0' heart.csv | sort -t, -k1,1n > heart_sorted.csv

gnuplot -persist <<-EOF
    set datafile separator ","
    set title "Correlation between Age and Cholesterol (No Heart Disease)"
    set xlabel "Age"
    set ylabel "Cholesterol"
    set grid
    set terminal png
    set output '4c.png'
    plot "heart_sorted.csv" using 1:5 with linespoints title "Age vs Cholesterol"
EOF


