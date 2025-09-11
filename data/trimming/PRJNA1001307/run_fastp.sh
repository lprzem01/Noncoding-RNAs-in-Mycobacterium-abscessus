#!/bin/bash
# Runs fastp in SE mode for all .fastq.gz files in a directory
# Run as:
# ./run_fastp.sh directory_of_samples SAMPLES 
# ./run_fastp.sh /d/user6/pl003/ProjectWork/data_processing/data/paired/GSE239869 SRR25491362	SRR25491363 SRR25491364 SRR25491365 SRR25491366 SRR25491367 SRR25491368 SRR25491369 SRR25491370	SRR25491371 SRR25491372	SRR25491373


timestamp=`date "+%Y%m%d-%H%M%S"`
logfile="run_$timestamp.log"
exec > $logfile 2>&1  #all output will be logged to logfile

#extension for fastq files
suffix1="_1.fastq.gz"
suffix2="_2.fastq.gz"

FASTP_EXEC="/d/in7/s/fastp/fastp"
DIR=$1
shift

ADAPTER_FILE="/d/in7/s/trimmomatic/Trimmomatic-0.32/adapters/TruSeq2and3-PE.fa"

echo "Running fastp using executable: $FASTP_EXEC"

for sample in "$@";
do
  pairedFile1="$dir$sample$suffix1"
  pairedFile2="$dir$sample$suffix2"
  echo "Sample= $sample"
  $FASTP_EXEC \
      -i "$DIR/$pairedFile1" \
      -I "$DIR/$pairedFile2" \
      -o "$sample"_1_trimmed.fastq.gz -O "$sample"_2_trimmed.fastq.gz \
      --detect_adapter_for_pe \
      -l 30 --trim_poly_x \
      -3\
      -5\
      -h "$sample"_fastp.html -j "$sample"_fastp.json     
done

