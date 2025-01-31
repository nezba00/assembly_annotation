#!/usr/bin/env bash

#SBATCH --cpus-per-task=16
#SBATCH --mem=64G
#SBATCH --time=04:00:00
#SBATCH --job-name=flye_asmbly
#SBATCH --output=/data/users/bnezar/assembly_annotation_course/slurm_out/output_flye2_%j.o
#SBATCH --error=/data/users/bnezar/assembly_annotation_course/slurm_out/error_flye2_%j.e
#SBATCH --partition=pibu_el8


WORKDIR=/data/users/bnezar/assembly_annotation_course
ANZDIR=$WORKDIR/Anz-0_processed
OUTDIR=$WORKDIR/assembly_out


module load Flye/2.9-GCC-10.3.0

flye --pacbio-hifi $ANZDIR/ERR11437354_fp.fastq --out-dir $OUTDIR \
    --threads 16 --genome-size 125m

