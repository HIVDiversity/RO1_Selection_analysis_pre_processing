#!/bin/bash
declare -a array=( $(ls 04_Lineage_partitioned_NT_alignments/V703*/V703*/*na*_filtered.fasta) )

arraylength=${#array[@]}

for ((i=0; i<${arraylength}; i++));
do

x=${array[$i]} 


fasttree -gtr < ${x} > ${x%%.fasta}.nwk
done

