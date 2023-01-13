#!/bin/bash
DAT_FILE=FUBAR_combined_2023-01-10_WITH_STUDY-ARM-FULL-DATASET.csv #The input csv file that will be modified
OUT_FILE=FUBAR_combined_2023-01-10_WITH_STUDY-ARM-FULL-DATASET_HXB2.csv
echo "ITS VERY IMPORTANT THAT THE ORDER OF Amino acids in both files are from small to large, and that the samples are also ordered numerically"
sleep 2s
my_string=" "
while IFS="," read -r colA colB colC colD colE colF colG colH colI colJ; do #read the FUBAR combined file and split into columns with the above headings
		my_string=$(echo "${colA},${colB},${colC},${colD},${colE},${colF},${colG},${colH},${colI},${colJ}")
		#if [ "$colA" == "alpha" ]; then
		if [ "$colA" != "alpha" ]; then 
			sample_name=${colI:0:9}
			#Now look at each line, find the sample code there and search for all co-ordinate files that start with that name (there should only be one per sample)
			#echo " now looking at rest of ${sample_name}"
			POS_FILE=( $(ls 05_Map_AA_pos_to_HXB2/${sample_name}*.csv ))		#The file in the array that will be used to get HXB2 and AA positions
			##test here for the cases where the alignment position is not in the MAP file in a specific columns
				while IFS="," read -r HXB2_pos Aln_pos; do #this reads each line of POS_FILE and uses a comma seperator to split into two columns and assign the variables HXB2_pos  
				if [[ "$colI" =~ .*"$sample_name".* ]] && [[ "$colG" == "$Aln_pos" ]] && [[ "$Aln_pos" != "NA" ]]; then
				my_string=$(echo "${colA},${colB},${colC},${colD},${colE},${colF},${colG},${colH},${colI},${HXB2_pos}")
					fi
				done < ${POS_FILE}
			fi
			echo $my_string >> ${OUT_FILE}
		my_string=" "
done < ${DAT_FILE}



