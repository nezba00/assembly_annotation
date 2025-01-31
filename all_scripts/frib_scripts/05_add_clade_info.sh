#!/usr/bin/env bash

#SBATCH --cpus-per-task=8
#SBATCH --mem=50G
#SBATCH --time=2:00:00
#SBATCH --job-name=merge_clades
#SBATCH --output=/data/users/bnezar/assembly_annotation_course/slurm_out/merge_clades_%j.o
#SBATCH --error=/data/users/bnezar/assembly_annotation_course/slurm_out/merge_clades_%j.e
#SBATCH --partition=pibu_el8

WORK_DIR=/data/users/bnezar/assembly_annotation_course/assembly_qc/EDTA_annotation_conda_lja/extract_infos

cd $WORK_DIR

# Merge LTR identities from EDTA with clade annotations from TEsorter
awk 'FNR==NR {clade[$1]=$2; next} {print $0, clade[$1]}' clade_info.txt unique_ltr_identity.txt > final_output.txt
