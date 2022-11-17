#!/bin/bash
declare -a array=( $(ls 04_Lineage_partitioned_NT_alignments/V703*/V703*/V703*json.csv) )

arraylength=${#array[@]}

for ((i=1; i<${arraylength}; i++));
do

x=${array[$i]} #full path to a single json file (MEME or FUBAR or any other json file in the folders)
#rename 's/_noHXB2//g' ${x} #first round of renameing
rename 's/_filtered.fasta//g' ${x} #second round of renaming


done
