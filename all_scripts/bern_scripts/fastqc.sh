#!/usr/bin/env bash

#SBATCH --cpus-per-task=6
#SBATCH --mem=40G
#SBATCH --time=01:00:00
#SBATCH --job-name=fastqc
#SBATCH --output=/data/users/bnezar/assembly_annotation_course/slurm_out/output_fastqc_%j.o
#SBATCH --error=/data/users/bnezar/assembly_annotation_course/slurm_out/error_fastqc_%j.e
#SBATCH --partition=pibu_el8


WORKDIR=/data/users/bnezar/assembly_annotation_course
SHADIR=$WORKDIR/RNAseq_Sha_processed


apptainer exec \
  --bind $WORKDIR \
  /containers/apptainer/fastqc-0.12.1.sif \
  fastqc -o $WORKDIR/read_QC/fastqc -t 6 $SHADIR/*.fastq
