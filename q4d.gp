set title 'Percentage of Age Groups with Heart Disease'
set terminal png
set output '4d.png'
set style fill solid 1.0 border -1
set size square
set xrange [-1.5:1.5]
set yrange [-1.5:1.5]
a1 = 32.6700 * 360 / 100
a2 = a1 + 42.4800 * 360 / 100
a3 = a2 + 20.9100 * 360 / 100
a4 = a3 + 3.9200 * 360 / 100
set object 1 circle at 0,0 size 1 arc [0:a1] fillcolor rgb 'red'
set object 2 circle at 0,0 size 1 arc [a1:a2] fillcolor rgb 'blue'
set object 3 circle at 0,0 size 1 arc [a2:a3] fillcolor rgb 'green'
set object 4 circle at 0,0 size 1 arc [a3:a4] fillcolor rgb 'yellow'
set key outside top box
plot NaN title sprintf('40-50 (%.2f%%)', 32.6700) with lines lc rgb 'red', \
     NaN title sprintf('50-60 (%.2f%%)', 42.4800) with lines lc rgb 'blue', \
     NaN title sprintf('60-70 (%.2f%%)', 20.9100) with lines lc rgb 'green', \
     NaN title sprintf('70-80 (%.2f%%)', 3.9200) with lines lc rgb 'yellow'
