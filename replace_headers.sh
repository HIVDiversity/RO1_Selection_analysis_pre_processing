#This script takes the following input1
#1  a list of all fasta files in a directory
#2 A text file with two columns, first column is the original fasta header, second column is the new header that is the replacement

#!/bin/bash

declare -a array=( $(ls ./03_Codon_aligned_noHXB2/*V703*noHXB2.fasta) ) #searches current directory for fasta files and add their names to an array
arraylength=${#array[@]}

for ((i=0; i<${arraylength}; i++));
do
x=${array[$i]} #full path to a single input fasta file used in step 1.
#strip file prefeix and suffix, to create a variable that is the baseame of the input file and can be used to name output files
y=${x%%.fasta}_lineages.fasta

#first create a duplicate file with a new name, the headers will be updated in the new file
#cp -v ${x} ${y}_lineages.fasta
cp -v ${x} ${y}


## this part reads each line in the pattern file and searches the fasta file for the pattern and does "in line" replacing with sed -i
##WARNING THIS MODIES THE INPUT FILE< SO MAKE SURE YOU COPIED THE ORIGINALS ELSEHWERE FOR BACKUP or that you are working in a copy

while IFS=$'\t' read old new; do   #this reads each line and uses a tab seperator to split into two columns and assign the variables old and new
#echo ${new}
sed -i "s/$old/$new/g" "${y}"   #note here hpw I use variables old and new in the sed command
done < V703_ENV_Lineage_headers.txt

done
