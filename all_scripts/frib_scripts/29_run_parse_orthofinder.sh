#!/bin/bash
#SBATCH --time=1-0
#SBATCH --mem=64G
#SBATCH -p pibu_el8
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=20
#SBATCH --job-name=parse_ortho
#SBATCH --output=/data/users/bnezar/assembly_annotation_course/slurm_out/output_parse_ortho_%j.out
#SBATCH --error=/data/users/bnezar/assembly_annotation_course/slurm_out/error_parse_ortho_%j.err

module load R/4.1.0-foss-2021a

# Go to final folder
cd /data/users/bnezar/assembly_annotation_course/annotation/final

# Create directory for plots
mkdir -p Plots

# Run script
Rscript /data/users/bnezar/assembly_annotation_course/frib_scripts/33-parse_Orthofinder.R

