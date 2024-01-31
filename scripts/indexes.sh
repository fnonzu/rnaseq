#!/usr/bin/env bash 
#SBATCH --cpus-per-task=1 

#SBATCH --mem-per-cpu=1000M 

#SBATCH --time=01:00:00 

#SBATCH --output=/home/mvolosko/Ribosome_profiling/scripts/03_output__annot.out

#SBATCH --error=/home/mvolosko/Ribosome_profiling/scripts/03_error_annot.out 

add module UHTS/Aligner/bowtie/1.2.0

cd /home/mvolosko/Ribosome_profiling/annotations

# For the "undesired" RNAs

bowtie-build GRCh38_p13_r_t_sno_sn_RNA_ENSEMBL_NCBI_GtRNAdb.fa GRCh38_p13_r_t_sno_sn_RNA_ENSEMBL_NCBI_GtRNAdb

# For the genome

bowtie-build GRCh38.dna.primary_assembly.fa GRCh38.dna.primary_assembly

# For the transcriptome

bowtie-build GRCh38_APPRIS_CDS_18.fa GRCh38_APPRIS_CDS_18
