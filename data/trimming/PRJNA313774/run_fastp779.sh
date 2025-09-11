#!/bin/bash
# Runs fastp in SE mode for all .fastq.gz files in a directory
# Run as:
# ./run_fastp.sh directory_of_samples 
# ./run_fastp779.sh /d/user6/pl003/ProjectWork/data_processing/data/single/GSE78787/ 


timestamp=`date "+%Y%m%d-%H%M%S"`
logfile="run_$timestamp.log"
exec > $logfile 2>&1  #all output will be logged to logfile

FASTP_EXEC="/d/in7/s/fastp/fastp"
DIR=$1


echo "Running fastp using executable: $FASTP_EXEC"

for file in `ls $DIR/*.fastq.gz`;
do
  sample=${file/$DIR\//}
  sample=${sample/.fastq.gz/}
  echo "Sample= $sample"
  $FASTP_EXEC -i  "$DIR/$sample".fastq.gz  \
         -o "$sample"_trimmed.fastq.gz \
	 #trim adapters identified during the qc checking process	  	
	 --adapter_sequence=ATCGGAAGAGCACACGTCTGAACTCCAGTCACGGCTACATCTCGTATGCC \
	 --adapter_sequence=GATCGGAAGAGCACACGTCTGAACTCCAGTCACGGCTACATCTCGTATGC \
	 -e 28 \
	 -l 46 --trim_poly_x \
         -h "$sample"_fastp.html -j "$sample"_fastp.json
done

