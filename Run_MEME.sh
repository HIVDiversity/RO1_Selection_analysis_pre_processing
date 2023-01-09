#!/bin/bash
declare -a array=( $(ls 04_Lineage_partitioned_NT_alignments/V703*/V703*/*na*_filtered.fasta) )

arraylength=${#array[@]}

for ((i=0; i<${arraylength}; i++));
do

x=${array[$i]} #full path to a single input fasta file used in step 1.
treefile=${x%%.fasta}.nwk

hyphy meme ${x} ${treefile} #runs hyphy and if all goes well meme saves the outut to the same directory taht conatin sthe fasta file/ treefile

done
