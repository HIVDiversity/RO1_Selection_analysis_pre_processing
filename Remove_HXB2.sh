#!/bin/bash
## Array job for multiple multifasta files
##Removes sequences from fasta files based on list of headers to discard
#This tool uses "samtools faidx" to remove sequences with a specific header


set -euo pipefail



declare -a array=( $(ls 00_Codon_aligned_files/Env/V703*.fasta) )
arraylength=${#array[@]}
for ((i=1; i<${arraylength}+1; i++));
do
echo  ${array[$i-1]}
x=${array[$i-1]}

y=${x##*/}
echo "${y}"

samtools faidx ${x}
remove_ids=($(awk '{print $1}' ${x}.fai | grep -v -f Sequences_to_remove.txt))
samtools faidx -o ./03_Codon_aligned_noHXB2/${y}_noHXB2.fasta ${x} "${remove_ids[@]}"
rm -rf ${x}.fai
done
