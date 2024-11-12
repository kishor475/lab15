#!/bin/bash

# Step 1: Process data to count age groups with heart disease
# Initialize counters for each age group
age_40_50=0
age_50_60=0
age_60_70=0
age_70_80=0

awk -F, '$8 == 1 { 
    if ($1 >= 40 && $1 < 50) age_40_50++;
    else if ($1 >= 50 && $1 < 60) age_50_60++;
    else if ($1 >= 60 && $1 < 70) age_60_70++;
    else if ($1 >= 70 && $1 < 80) age_70_80++;
} END {
    print "age_40_50=" age_40_50;
    print "age_50_60=" age_50_60;
    print "age_60_70=" age_60_70;
    print "age_70_80=" age_70_80;
}' heart.csv > age_group_counts.txt

# Read the counts from the output file into shell variables
source age_group_counts.txt

# Step 2: Calculate the total number of cases with heart disease
total=$((age_40_50 + age_50_60 + age_60_70 + age_70_80))

# Step 3: Calculate the percentages for each age group
p1=$(echo "scale=4; $age_40_50 / $total * 100" | bc)
p2=$(echo "scale=4; $age_50_60 / $total * 100" | bc)
p3=$(echo "scale=4; $age_60_70 / $total * 100" | bc)
p4=$(echo "scale=4; $age_70_80 / $total * 100" | bc)

# Create Gnuplot script
gnuplot_file="q4d.gp"
echo "set title 'Percentage of Age Groups with Heart Disease'" > $gnuplot_file
echo "set terminal png" >> $gnuplot_file
echo "set output '4d.png'" >> $gnuplot_file
echo "set style fill solid 1.0 border -1" >> $gnuplot_file
echo "set size square" >> $gnuplot_file
echo "set xrange [-1.5:1.5]" >> $gnuplot_file
echo "set yrange [-1.5:1.5]" >> $gnuplot_file

# Define the angles for each segment based on the percentages
echo "a1 = $p1 * 360 / 100" >> $gnuplot_file
echo "a2 = a1 + $p2 * 360 / 100" >> $gnuplot_file
echo "a3 = a2 + $p3 * 360 / 100" >> $gnuplot_file
echo "a4 = a3 + $p4 * 360 / 100" >> $gnuplot_file

# Draw pie chart with each age group segment
echo "set object 1 circle at 0,0 size 1 arc [0:a1] fillcolor rgb 'red'" >> $gnuplot_file
echo "set object 2 circle at 0,0 size 1 arc [a1:a2] fillcolor rgb 'blue'" >> $gnuplot_file
echo "set object 3 circle at 0,0 size 1 arc [a2:a3] fillcolor rgb 'green'" >> $gnuplot_file
echo "set object 4 circle at 0,0 size 1 arc [a3:a4] fillcolor rgb 'yellow'" >> $gnuplot_file

# Add labels with the percentages in the legend
echo "set key outside top box" >> $gnuplot_file
echo "plot NaN title sprintf('40-50 (%.2f%%)', $p1) with lines lc rgb 'red', \\" >> $gnuplot_file
echo "     NaN title sprintf('50-60 (%.2f%%)', $p2) with lines lc rgb 'blue', \\" >> $gnuplot_file
echo "     NaN title sprintf('60-70 (%.2f%%)', $p3) with lines lc rgb 'green', \\" >> $gnuplot_file
echo "     NaN title sprintf('70-80 (%.2f%%)', $p4) with lines lc rgb 'yellow'" >> $gnuplot_file

# Step 5: Execute the Gnuplot script
gnuplot $gnuplot_file

echo "Pie chart with percentages saved as 4d.png"

