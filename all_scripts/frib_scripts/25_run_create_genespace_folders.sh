#!/bin/bash
#SBATCH --time=1-0
#SBATCH --mem=64G
#SBATCH -p pibu_el8
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=20
#SBATCH --job-name=Genespace_folders
#SBATCH --output=/data/users/bnezar/assembly_annotation_course/slurm_out/output_Genespace_folders_%j.out
#SBATCH --error=/data/users/bnezar/assembly_annotation_course/slurm_out/error_Genespace_folders_%j.err


module load R/4.1.0-foss-2021a
module load UCSC-Utils/448-foss-2021a
module load MariaDB/10.6.4-GCC-10.3.0


cd /data/users/bnezar/assembly_annotation_course/annotation/final

Rscript /data/users/bnezar/assembly_annotation_course/frib_scripts/30-create_Genespace_folders.R