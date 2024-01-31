#!/usr/bin/env bash

#SBATCH --cpus-per-task=4 

#SBATCH --mem-per-cpu=1000M 

#SBATCH --time=01:00:00 

#SBATCH --partition=pall 

#SBATCH --job-name=genome_mapping

#SBATCH --output=/data/users/mvolosko/logfiles/06_%j.out 

#SBATCH --error=/data/users/mvolosko/logfiles/06_%j.err 

cd /data/users/mvolosko/Ribosome_profiling/mapping_unwanted_rna

module load UHTS/Aligner/bowtie/1.2.0 

module load UHTS/Analysis/samtools/1.8

for file in $( ls -d *RNA.fastq); do echo $file;\
bowtie -S -t -p 4 -v 1 -m 1 --best --strata annotated_genome -q ${file} |\
samtools view -h -F4 -b > $(basename ${file} .fastq)_GRCh38.bam; done 

for file in $( ls -d *.bam); do echo $file;\
samtools sort -@ 4 ${file} -o $(basename ${file} .bam)_sorted.bam; done 

rm *GRCh38.bam
