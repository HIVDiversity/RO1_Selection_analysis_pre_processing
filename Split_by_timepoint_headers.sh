#!/bin/bash

##wThis is a very hacky script, based on the partition by lineage script, to partition the lineage files into timepoints
##it requires text file which contains a list of timepoint codes (all codes from various participants in a signgle file)


declare -a array=( $(ls V70*/V70*/*V70*.fasta) ) #searches current directory for fasta files and add their names to an array
arraylength=${#array[@]}

for ((i=0; i<${arraylength}+1; i++));
	do
		
		x=${array[$i-1]}
		echo "Now doing:"
		echo ${x}
		##strip suffix
		y=${x%%.fasta}
		#echo ${y}
		
		lin_suffix=${y##*Env}
		echo "this is the lineage suffix " ${lin_suffix}
		
		parent_folder="$(dirname -- ${x})"
		echo "this is the parent folder " ${parent_folder}

#Use as input the file with lineage names, search for pattern in fasta file and write sequences to new file
		while read line;
		do
			if [[ "$(grep -c $line ${x})" -ge 1 ]]; then 
				#cd ${parent_folder}
				
				mkdir ${parent_folder}/../${line}_Env${lin_suffix}
				outfile="${line}_Env${lin_suffix}.fasta"

				echo "$(grep -A 1 "$line" ${x})" >> ${parent_folder}/../${line}_Env${lin_suffix}/${outfile};
			#echo "${outfile}"
			
		fi
		done < ../V70x_timepoint_list.txt
		

done

