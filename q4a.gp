set terminal pngcairo enhanced font 'Verdana,10'
set output '4a.png'
set title 'Heart Disease by Gender'
set xlabel 'Gender'
set ylabel 'Number of People with Heart Disease'
set boxwidth 0.5
set style fill solid
set xtics ('Male' 1, 'Female' 2)
set yrange [0:*]
plot 'processed_data.txt' using 2:xtic(1) with boxes title 'Heart Disease'
