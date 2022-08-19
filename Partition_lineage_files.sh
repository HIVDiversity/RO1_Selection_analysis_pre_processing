#!/bin/bash

##what does this script do: Partition fasta files based on sequence headers
#creates an array of fasta files
#uses another input file with substrings from a fasta header
#does a grep search to see if substring is in header of the fasta file
#if the substring is found, a new fasta file is created with that particular header and the sequence on the line below it
#the temp file is deleted

declare -a array=( $(ls *V703*noHXB2*lineages.fasta) ) #searches current directory for fasta files and add their names to an array
arraylength=${#array[@]}

for ((i=1; i<${arraylength}+1; i++));
	do
		
		x=${array[$i-1]}
		echo "Now doing:"
		echo ${x}
		##strip suffix
		y=${x%%.fasta}
		echo ${y}
		#create a temporary fasta file where the newline characters are sptripped out so the entire sequence is on a single line
		awk '!/^>/ { printf "%s", $0; n = "\n" } /^>/ { print n $0; n = "" } END { printf "%s", n }' ${x} > ${x}_tempfile

		#outdir=mkdir ../Partitioned_lineages/${y:0:24} #outdir where partitioned lineage files will be saved
	mkdir ./${y:0:24}
#Use as input the file with lineage names, search for pattern in fasta file and write sequences to new file
		while read line;
		do
			if [[ "$(grep -c $line ${x}_tempfile)" -ge 1 ]]; then 
				
				outfile="${y:0:24}/${y}${line}.fasta"
				echo ${y:0:24}/${y}${line}
				echo "this file" ${x}_tempfile "contains " ${line}
				echo "$(grep -A 1 "$line" ${x}_tempfile)" >> ${outfile};
				#echo "$line" >> ${outfile};
		fi
		done < ../V703_Lineage_nomenclature_list.txt
		
rm ${x}_tempfile
done


