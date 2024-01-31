#!/bin/bash

#SBATCH --cpus-per-task=2
#SBATCH --mem-per-cpu=1000M
#SBATCH --time=04:00:00
#SBATCH --partition=pall
#SBATCH --job-name=code_occup
#SBATCH --output=/data/users/mvolosko/Ribosome_profiling/logfiles/code_occup_%j.out
#SBATCH --error=/data/users/mvolosko/Ribosome_profiling/logfiles/code_occup_%j.err

module load UHTS/Aligner/bowtie/1.2.0

cd /data/users/mvolosko/Ribosome_profiling/mapping_unwanted_rna

for x in $(ls -d *RNA.fastq); \
do echo ${x}; \
bowtie \
-t \
-p 4 \
-v 1 \
-m 1 \
--best \
--strata \
--norc \
/data/users/mvolosko/Ribosome_profiling/annotations/GRCh38_APPRIS_CDS_18 \
-q ${x} \
-S $(basename ${x} .fastq)_GRCh38_APPRIS_CDS.sam 2> $(basename ${x} .fastq)_GRCh38_APPRIS_CDS_log.txt; done
