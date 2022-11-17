#!/bin/bash
declare -a array=( $(ls 04_Lineage_partitioned_NT_alignments/V703*/V703*/V703*_filtered*fasta*.json) )

arraylength=${#array[@]}

for ((i=1; i<${arraylength}; i++));
do

x=${array[$i]} #full path to a single json file (MEME or FUBAR or any other json file in the folders)
jq '(.["MLE"]["headers"] | map (. | .[0])) as $headers | $headers, .["MLE"]["content"]["0"][] | @csv' -r ${x} > ${x}.csv

#Be WARNED, WINDOWS CANNOT OPEN CSV FILES IN EXCEL IF THE FILEPATH NAME IS TOO LONG< MIGHT HAVE TO RUN ANOTHER SCRIPT TO RENAME FILES TO SHORTEN IT
done
