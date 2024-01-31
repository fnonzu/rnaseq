#!/usr/bin/env bash 

  

#SBATCH --cpus-per-task=1 

#SBATCH --mem-per-cpu=1000M 

#SBATCH --time=01:00:00 

#SBATCH --partition=pall 

 

module add UHTS/Analysis/MultiQC/1.8 

multiqc . 

