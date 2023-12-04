#!/bin/bash
declare -a array=( $(ls Morgane_codon_aligned_lineages/70*_Codon_aligned_lineages/V70*.na/V70*/V70*_*na*.fasta) )

arraylength=${#array[@]}

for ((i=0; i<${arraylength}; i++));
do

x=${array[$i]} 



#Run the hyphy datafile tool that strips stop codons (only strip stop codons at the end of the file, dont discard any sequences
#If I wanted to keep only unique sequences and discard duplicates i need to change it to (3):[Yes/No] Filter duplicate sequences but keep all sites

hyphy rmv "Universal" ${x} "Disallow stops" ${x%%.fasta}_filtered.fasta #Removes stop codons and duplicates and writes to a new file with the extension "filtered.fasta"
echo ${i}
done

