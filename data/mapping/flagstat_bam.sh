#!/bin/bash

# Output log file
LOG_FILE="flagstat_bam.log"

# Empty the log file if it exists, or create it if it doesn't
> "$LOG_FILE"

# Loop through all .bam files in the current directory
for bam_file in *.bam; do
    if [[ -f "$bam_file" ]]; then
        echo "Running bam_stat.py on $bam_file" >> "$LOG_FILE"
        samtools flagstat "$bam_file" >> "$LOG_FILE"
        echo "-----------------------------" >> "$LOG_FILE"
    else
        echo "No BAM files found in the directory."
        break
    fi
done

echo "BAM stats written to $LOG_FILE"

