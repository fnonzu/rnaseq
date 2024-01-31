#!/bin/bash

#SBATCH --job-name=fastqc_job

#SBATCH --output=04_RNA_remove_output.log

#SBATCH --error=04_RNA_remove_error.log

#SBATCH --nodes=4

#SBATCH --cpus-per-task=4

#SBATCH --mem=1000M

module load UHTS/Aligner/bowtie/1.2.0

cd /data/users/mvolosko/Ribosome_profiling/RawData

# Mapping to undesired RNAs
for x in $(ls -d *tr.fastq.gz); do \
gunzip -cd ${x} | \
bowtie \
-S \
-t \
-p 4 \
/data/users/mvolosko/Ribosome_profiling/annotations/GRCh38_p13_r_t_sno_sn_RNA_ENSEMBL_NCBI_GtRNAdb \
- \
--un $(basename ${x} .fastq.gz)_no_r_t_sno_sn_RNA.fastq 2> \
$(basename ${x} .fastq.gz)_no_r_t_sno_sn_RNA_log.txt > /dev/null; done

