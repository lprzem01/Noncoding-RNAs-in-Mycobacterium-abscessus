#!/bin/bash
# Runs fastp in SE mode for all .fastq.gz files in a directory
# Run as:
# ./run_fastp.sh directory_of_samples SAMPLES 
# ./run_fastp.sh /d/user6/pl003/ProjectWork/data_processing/data/paired/GSE222081 SRR22959530 SRR22959531 SRR22959522 SRR22959523 SRR22959524 SRR22959525 SRR22959526 SRR22959527 SRR22959528 SRR22959529 SRR22959532 SRR22959533 SRR22959534 SRR22959535 SRR22959536 SRR22959537 SRR22959538 SRR22959539



timestamp=`date "+%Y%m%d-%H%M%S"`
logfile="run_$timestamp.log"
exec > $logfile 2>&1  #all output will be logged to logfile

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
    -o "$sample"_1_trimmed.fastq.gz -O "$sample"_2_trimmed.fastq.gz \
    -l 30 --trim_poly_x \
    --detect_adapter_for_pe \
    -5 \
    -h "$sample"_fastp.html -j "$sample"_fastp.json
done
