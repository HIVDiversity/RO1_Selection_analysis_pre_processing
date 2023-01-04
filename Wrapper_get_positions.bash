#!/bin/bash
declare -a array=( $(ls 00_Morganes_codon_aligned_files/Env/V703_0013*Env.aa*.fasta) )

arraylength=${#array[@]}
mkdir ./05_Map_AA_pos_to_HXB2
for ((i=0; i<${arraylength}; i++));
do

	x=${array[$i]} #full path to a single json file (MEME or FUBAR or any other json file in the folders)
	y=$(basename -- "$x")
	echo "now doing ${y}"
	python getHXB2_site_positions.py -in ${x} -ref_name HXB2 --in_csv Env_sites.csv --out_csv ./05_Map_AA_pos_to_HXB2/${y%.*}.csv
done
