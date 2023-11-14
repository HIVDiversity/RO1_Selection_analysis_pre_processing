#This script takes the following input1
#1  a list of all fasta files in a directory
#2 A text file with two columns, first column is the original fasta header, second column is the new header that is the replacement

#!/bin/bash

declare -a array=( $(ls ./HVTN703_Env_6_additional/*.fasta) ) #searches current directory for fasta files and add their names to an array
arraylength=${#array[@]}

for ((i=0; i<${arraylength}; i++));do
		x=${array[$i]} #full path to a single input fasta file used in step 1.
		#strip file prefeix and suffix, to create a variable that is the baseame of the input file and can be used to name output files
		y=${x%%.fasta}_lineages.fasta

		#first create a duplicate file with a new name, the headers will be updated in the new file later on
		cp -v ${x} ${y}
		mv ${y} ./ #Move the file which will be modified to current dir
done

## other option...needs fixing
##Maybe add a test to see if it is Gag or Env and then treat them seperatly

message1=" "
while IFS=$'\t' read old new; do
	base_of_file=${old:0:10}
	message2="${base_of_file}"
##	echo "the base of the file is ${base_of_file}"
	filenames=($(ls ${base_of_file}*.fasta)) # searches for a filename that matches part of the old PID
##	echo "the list of files are ${filenames[*]}"
	for filename in "${filenames[@]}"; do  #is it faster or slower if I take this out?
	#echo "the filename is ${filename}"
		if grep -q "${old:0:15}" "${filename}"; then
			sed -i "s/$old/$new/g" "$filename"
#		echo "replacement happened in ${filename} with $new"
		fi
	if [ "${message1}" != "${message2}" ]; then
	echo "${message2}"
	message1="${message2}"
	fi
done


done < Old_new_headers2.txt


