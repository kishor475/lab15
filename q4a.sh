#!/bin/bash

CSV_FILE="heart.csv"

if [ ! -f "$CSV_FILE" ]; then
    echo "File $CSV_FILE not found!"
    exit 1
fi

PROCESSED_DATA="processed_data.txt"

awk -F, 'NR > 1 {if ($2 == "1" && $8 == 1) m_heart++; if ($2 == "0" && $8 == 1) f_heart++} END {print "M", m_heart; print "F", f_heart}' "$CSV_FILE" > "$PROCESSED_DATA"

if [ ! -f "$PROCESSED_DATA" ]; then
    echo "Error processing data."
    exit 1
fi

GNUPLOT_SCRIPT="q4a.gp"

cat << EOF > "$GNUPLOT_SCRIPT"
set terminal pngcairo enhanced font 'Verdana,10'
set output '4a.png'
set title 'Heart Disease by Gender'
set xlabel 'Gender'
set ylabel 'Number of People with Heart Disease'
set boxwidth 0.5
set style fill solid
set xtics ('Male' 1, 'Female' 2)
set yrange [0:*]
plot '$PROCESSED_DATA' using 2:xtic(1) with boxes title 'Heart Disease'
EOF

gnuplot "$GNUPLOT_SCRIPT"
