#!/bin/bash

# Runs bwa in paired-end  mode 

# Run as:
# run_bwa.sh directory_of_fastq_files samples
# module load bwa
# module load samtools
# ./run_bwa.sh /d/user6/pl003/ProjectWork/data_processing/fqtrim/paired/GSE239869/ SRR25491362 SRR25491363 SRR25491364 SRR25491365 SRR25491366 SRR25491367 SRR25491368 SRR25491369 SRR25491370 SRR25491371 SRR25491372 SRR25491373 


timestamp=`date "+%Y%m%d-%H%M%S"`
logfile="run_$timestamp.log"
exec > $logfile 2>&1  #all output will be logged to logfile

dir=$1
shift

#set location of executables
BWA_EXEC="/s/software/bwa/bin/bwa"
SAMTOOLS_EXEC="/d/in7/s/samtools/samtools-1.3.1/samtools"

#set parameters
genomeFile="/d/user6/pl003/ProjectWork/data_processing/genome/ATCC_19977/GCA_000069185.1/GCA_000069185.1_ASM6918v1_genomic.fa"

#extension for fastq files
suffix1="_1_trimmed.fastq"
suffix2="_2_trimmed.fastq"

for sample in "$@";
do
   echo "Running bwa on sample $sample (paired-end mode)..."

   pairedFile1="$dir$sample$suffix1"
   if [ -f $pairedFile1 ]
   then
      gzip -d $pairedFile1
      pairedFile1=$dir$sample$suffix1
   else
      pairedFile1=$dir$sample$suffix1
      if [ ! -f $pairedFile1 ]
      then
         echo "File not found: $pairedFile1"
         exit $?
      fi
   fi
   pairedFile2="$dir$sample$suffix2"
   if [ -f $pairedFile2 ]
   then
      gzip -d $pairedFile2
      pairedFile2=$dir$sample$suffix2
   else
      pairedFile2=$dir$sample$suffix2
      if [ ! -f $pairedFile2 ]
      then
         echo "File not found: $pairedFile2"
         exit $?
      fi
   fi

   tmpBinary1="$sample"_1_sa.sai
   tmpBinary2="$sample"_2_sa.sai
   tmpSam="$sample"_pe.sam
   tmpBam="$sample"_pe.bam
   finalSortedBam="$sample"_sorted.bam

   #align 
   $BWA_EXEC aln $genomeFile $pairedFile1 > $tmpBinary1
   $BWA_EXEC aln $genomeFile $pairedFile2 > $tmpBinary2

   #create sam file
   $BWA_EXEC sampe $genomeFile $tmpBinary1 $tmpBinary2 $pairedFile1 $pairedFile2 > $tmpSam
   #create bam file
   $SAMTOOLS_EXEC view $tmpSam -Sbo $tmpBam
   $SAMTOOLS_EXEC sort $tmpBam -o $finalSortedBam
   $SAMTOOLS_EXEC index $finalSortedBam

   #cleanup
   /bin/rm $tmpSam $tmpBam
   /bin/rm $tmpBinary1 $tmpBinary2
   #gzip -9 $pairedFile1 $pairedFile2

done


echo "All done!"
