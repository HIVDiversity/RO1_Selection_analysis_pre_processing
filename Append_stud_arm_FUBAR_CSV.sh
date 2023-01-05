
#!/bin/bash

y=FUBAR_combined_2023-01-05.csv
#y=$(ls FUBAR_combined_2023-01-05.csv)
new_file="${y:0:25}_WITH_STUDY-ARM.csv"
cp "$y" "$new_file"

while IFS=$"," read name arm; do   #this reads each line and uses a tab seperator to split into two columns and assign the variables old and new
	
	if grep -q "${name}" "${y}"; then #If the participant of old header is part of the fasta filename, then proceed with replacing headers
	echo "yay"
	sed -i -r "s/$name/$arm,$name/" "${new_file}"   #note here hpw I use variables old and new in the sed command
	fi
done < Samplename_studyarm.txt
