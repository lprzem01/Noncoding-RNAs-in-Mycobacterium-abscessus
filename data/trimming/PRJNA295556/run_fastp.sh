#!/bin/bash
# Runs fastp in SE mode for all .fastq.gz files in a directory
# Run as:
# ./run_fastp.sh directory_of_samples 
# ./run_fastp.sh /d/user6/pl003/ProjectWork/data_processing/data/single/GSE72996/ SRR2392989 SRR2392992 SRR2392995 SRR2392990 SRR2392993 SRR2392996 SRR2392991 SRR2392994

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
	 --adapter_sequence=TGGAATTCTCGGGTGCCAAGG \
	 --cut_tail \
         -l 30 --trim_poly_x \
         -h "$sample"_fastp.html -j "$sample"_fastp.json
done

