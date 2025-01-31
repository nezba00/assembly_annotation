#!/usr/bin/env bash

#SBATCH --cpus-per-task=8
#SBATCH --mem=50G
#SBATCH --time=2:00:00
#SBATCH --job-name=get_clades
#SBATCH --output=/data/users/bnezar/assembly_annotation_course/slurm_out/get_clades_%j.o
#SBATCH --error=/data/users/bnezar/assembly_annotation_course/slurm_out/get_clades_%j.e
#SBATCH --partition=pibu_el8

WORK_DIR=/data/users/bnezar/assembly_annotation_course/assembly_qc/EDTA_annotation_conda_lja/extract_infos
CLADEFILE=$WORK_DIR/assembly.fasta.mod.LTR.intact.fa.rexdb-plant.cls.tsv

cd $WORK_DIR

# Parse TEsorter clade info
awk -F'\t' '{split($1, a, "#"); print a[1], $4}' $CLADEFILE > clade_info.txt
