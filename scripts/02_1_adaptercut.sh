#!/bin/bash

#SBATCH --job-name=fastqc_job

#SBATCH --output=04_RNA_remove_output.log

#SBATCH --error=04_RNA_remove_error.log

#SBATCH --nodes=4

#SBATCH --cpus-per-task=4

#SBATCH --mem=1000M

cd /home/mvolosko/Ribosome_profiling/RawData

module load UHTS/Quality_control/cutadapt/2.5


# Clip 3' adapter
for x in $(ls -d *.fastq.gz); do echo ${x}; \
cutadapt \
-j 4 \
-a CTGTAGGCACCATCAAT \
-q 25 \
--minimum-length 25 \
--discard-untrimmed \
-o $(basename ${x} .fastq.gz)_clpd.fastq.gz \
${x} 1> $(basename ${x} .fastq.gz)_clpd_log.txt; done


# Trim 4 nt (randomized bases) from the 3' end
for x in $(ls -d *_clpd.fastq.gz); do echo ${x}; \
cutadapt \
-j 4 \
-q 25 \
--cut -4 \
--minimum-length 25 \
-o $(basename ${x} .fastq.gz)_tr.fastq.gz \
${x} 1> $(basename ${x} .fastq.gz)_tr_log.txt; done
