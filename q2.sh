#!/bin/bash
CSV_FILE="heart.csv"

if [ ! -f "$CSV_FILE" ]; then
    echo "File $CSV_FILE not found!"
    exit 1
fi

TEX_FILE="output.tex"

echo "\documentclass{article}" > "$TEX_FILE"
echo "\usepackage[utf8]{inputenc}" >> "$TEX_FILE"
echo "\usepackage{longtable}" >> "$TEX_FILE"
echo "\usepackage[a4paper, left=0.6in, right=1in, top=1in, bottom=1in]{geometry}" >> "$TEX_FILE" 
echo "\begin{document}" >> "$TEX_FILE"
echo "\begin{longtable}{|c|c|c|c|c|c|c|c|c|c|c|c|c|c|}" >> "$TEX_FILE"  
IFS=',' read -r -a headers < "$CSV_FILE"
for i in "${!headers[@]}"; do
    if [ $i -eq $((${#headers[@]} - 1)) ]; then
        echo -n "\textbf{${headers[$i]}}" >> "$TEX_FILE"
    else
        echo -n "\textbf{${headers[$i]}} & " >> "$TEX_FILE"
    fi
done
echo "\\\\" >> "$TEX_FILE"  

tail -n +2 "$CSV_FILE" | while IFS=',' read -r -a row; do
    for i in "${!row[@]}"; do
        if [ $i -eq $((${#row[@]} - 1)) ]; then
            echo -n "${row[$i]}" >> "$TEX_FILE"
        else
            echo -n "${row[$i]} & " >> "$TEX_FILE"
        fi
    done
    echo "\\\\" >> "$TEX_FILE" 
done

echo "\end{longtable}" >> "$TEX_FILE"
echo "\end{document}" >> "$TEX_FILE"
