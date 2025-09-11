#!/bin/bash
# Runs FASTQC on all fastq.gz files found in given directory
# Run as:
# ./run_fastqc.sh /d/user6/pl003/ProjectWork/data_processing/data/single/GSE72996/

FASTQC_DIR="fastqc"

echo "Running FASTQC using executable: $FASTQC_DIR"

for fastq_file in $1/*."fastq.gz";
do
  echo "Fastq file: $fastq_file"
  $FASTQC_DIR $fastq_file -o .
done
