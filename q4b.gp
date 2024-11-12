set terminal png
set output '4b.png'
set datafile separator ","
set title "Age v/s Blood Pressure"
set xlabel "Age"
set ylabel "Blood Pressure"
set grid

plot "heart.csv" using 1:4 with points title "Age vs Blood Pressure"

