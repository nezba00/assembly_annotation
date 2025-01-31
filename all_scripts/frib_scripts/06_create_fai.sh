#!/usr/bin/env bash

#SBATCH --cpus-per-task=8
#SBATCH --mem=50G
#SBATCH --time=2:00:00
#SBATCH --job-name=get_clades
#SBATCH --output=/data/users/bnezar/assembly_annotation_course/slurm_out/get_clades_%j.o
#SBATCH --error=/data/users/bnezar/assembly_annotation_course/slurm_out/get_clades_%j.e
#SBATCH --partition=pibu_el8

module load SAMtools/1.13-GCC-10.3.0

WORK_DIR=/data/users/bnezar/assembly_annotation_course/assembly_out/lja

cd $WORK_DIR

samtools faidx assembly.fasta