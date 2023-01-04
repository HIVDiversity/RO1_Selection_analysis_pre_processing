#!/bin/bash
declare -a array=( $(ls 04_Lineage_partitioned_NT_alignments/V703*/V703*/V703*FUBAR*.json.csv) )

arraylength=${#array[@]}

for ((i=0; i<${arraylength}; i++));
do

x=${array[$i]} #full path to a single json file (MEME or FUBAR or any other json file in the folders)

#The next line removes the "" characters in headers so fie can be parsed correctly
#sed -i 's/"//g' ${x}
y=$(basename -- "$x")
j=0
while read line; do
     # modify $whatYouWantToAppend
     echo "${line} ${j} ${y}" >> FUBAR_combined_2022-11-21.csv
     j=$((j+1))
 done < ${x}
j=0
echo "processed ${x}"
done
