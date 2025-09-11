#!/bin/bash
# Runs fastp in SE mode for all .fastq.gz files in a directory
# Run as:
# ./run_fastp.sh directory_of_samples SAMPLES
# ./run_fastp767.sh /d/user6/pl003/ProjectWork/data_processing/data/paired/GSE165352/ SRR13509767
 
timestamp=`date "+%Y%m%d-%H%M%S"`
logfile="run_$timestamp.log"
exec > $logfile 2>&1  #all output will be logged to logfile

#extension for fastq files
suffix1="_1.fastq.gz"
suffix2="_2.fastq.gz"

FASTP_EXEC="/d/in7/s/fastp/fastp"
DIR=$1
shift

echo "Running fastp using executable: $FASTP_EXEC"

for sample in "$@"; do
  pairedFile1="$dir$sample$suffix1"
  pairedFile2="$dir$sample$suffix2"
  echo "Sample= $sample"
  $FASTP_EXEC \
    -i "$DIR/$pairedFile1" \
    -I "$DIR/$pairedFile2" \
    -x \
    -3 28 \
    -M 30 \
    -e 30 \
    -o "$sample"_1_trimmed.fastq.gz -O "$sample"_2_trimmed.fastq.gz \
    -h "$sample"_fastp.html -j "$sample"_fastp.json
done
