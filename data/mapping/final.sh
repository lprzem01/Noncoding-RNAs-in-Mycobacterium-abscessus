#!/bin/bash


# Loop through all .bam files in the current directory
for bam_file in *.bam; do
    if [[ -f "$bam_file" ]]; then
	echo "Isolating Chromosome reads"
	samtools view -bo "Chromosome_$bam_file" $bam_file CU458896.1
	echo "Creating header file for $bam_file" 
        samtools view -H "Chromosome_$bam_file" > "header_$bam_file.sam"
	sed -i -e 's/CU458896.1/Chromosome/g' "header_$bam_file.sam"
	echo "Renaming chromosome $bam_file"
	samtools reheader "header_$bam_file.sam" "Chromosome_$bam_file" > "final_$bam_file"
	echo "Indexing final $bam_file"
	samtools index "final_$bam_file"  
        echo "-----------------------------"
	#cleanup
   	/bin/rm "header_$bam_file.sam"
   	/bin/rm "Chromosome_$bam_file"
    else
        echo "No BAM files found in the directory."
        break
    fi
done
