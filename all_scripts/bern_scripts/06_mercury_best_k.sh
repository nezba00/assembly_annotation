#!/usr/bin/env bash

#SBATCH --cpus-per-task=32
#SBATCH --mem=60G
#SBATCH --time=12:00:00
#SBATCH --job-name=opt_kmer
#SBATCH --output=/data/users/bnezar/assembly_annotation_course/slurm_out/output_mercury1_%j.o
#SBATCH --error=/data/users/bnezar/assembly_annotation_course/slurm_out/error_mercury1_%j.e
#SBATCH --partition=pibu_el8

WORKDIR=/data/users/bnezar/assembly_annotation_course
ASMDIR=$WORKDIR/assembly_out

export MERQURY="/usr/local/share/merqury"

# find best kmer size
apptainer exec --bind $WORKDIR\
 /containers/apptainer/merqury_1.3.sif\
 $MERQURY/best_k.sh 130000000


