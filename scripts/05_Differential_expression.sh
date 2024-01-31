#!/bin/bash

#SBATCH --cpus-per-task=2
#SBATCH --mem-per-cpu=1000M
#SBATCH --time=01:00:00
#SBATCH --partition=pall
#SBATCH --job-name=differential_expression
#SBATCH --output=/data/users/mvolosko/Ribosome_profiling/logfiles/difexp_%j.out
#SBATCH --error=/data/users/mvolosko/Ribosome_profiling/logfiles/difexp_%j.err

cd /data/users/mvolosko/Ribosome_profiling/differential_expression

module load UHTS/Analysis/subread/2.0.1
module load Subread/2.0.3-GCC-10.3.0

featureCounts \
-T 8 \
-t CDS \
-g gene_id \
-a /data/users/mvolosko/Ribosome_profiling/annotations/Homo_sapiens.GRCh38.108.gtf \
-o CDS_counts_rawfile.txt /data/users/mvolosko/Ribosome_profiling/mapping_unwanted_rna/*_clpd_tr_no_r_t_sno_sn_RNA_GRCh38_sorted.bam

# Extract GeneID and Sample columns

cut -f 1,7-10 CDS_counts_rawfile.txt > CDS_counts_processed.txt
