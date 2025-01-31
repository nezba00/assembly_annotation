#!/usr/bin/env bash

#SBATCH --cpus-per-task=64
#SBATCH --mem=80G
#SBATCH --time=1-12:00:00
#SBATCH --job-name=lja_asmbly
#SBATCH --output=/data/users/bnezar/assembly_annotation_course/slurm_out/output_lja1_%j.o
#SBATCH --error=/data/users/bnezar/assembly_annotation_course/slurm_out/error_lja1_%j.e
#SBATCH --partition=pibu_el8


WORKDIR=/data/users/bnezar/assembly_annotation_course
ANZDIR=$WORKDIR/Anz-0_processed
OUTDIR=$WORKDIR/assembly_out/lja

# Create out dir
mkdir -p $OUTDIR

apptainer exec \
  --bind $WORKDIR \
  /containers/apptainer/lja-0.2.sif \
  lja -o $OUTDIR --reads $ANZDIR/ERR11437354_fp.fastq --threads 64 