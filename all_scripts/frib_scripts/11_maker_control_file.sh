#!/usr/bin/env bash

#SBATCH --cpus-per-task=8
#SBATCH --mem=50G
#SBATCH --time=2:00:00
#SBATCH --job-name=ctrl_file
#SBATCH --output=/data/users/bnezar/assembly_annotation_course/slurm_out/output_ctrl_file_%j.o
#SBATCH --error=/data/users/bnezar/assembly_annotation_course/slurm_out/error_ctr_file_%j.e
#SBATCH --partition=pibu_el8


WORK_DIR=/data/users/bnezar/assembly_annotation_course/annotation

mkdir -p $WORK_DIR


cd $WORK_DIR

apptainer exec --bind /data \
 /data/courses/assembly-annotation-course/CDS_annotation/containers/MAKER_3.01.03.sif maker -CTL
