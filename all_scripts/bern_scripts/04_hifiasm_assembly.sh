#!/usr/bin/env bash

#SBATCH --cpus-per-task=32
#SBATCH --mem=64G
#SBATCH --time=04:00:00
#SBATCH --job-name=hifiasm_asmbly
#SBATCH --output=/data/users/bnezar/assembly_annotation_course/slurm_out/output_hifi1_%j.o
#SBATCH --error=/data/users/bnezar/assembly_annotation_course/slurm_out/error_hifi1_%j.e
#SBATCH --partition=pibu_el8


WORKDIR=/data/users/bnezar/assembly_annotation_course
ANZDIR=$WORKDIR/Anz-0_processed
OUTDIR=$WORKDIR/assembly_out/hifiasm


module load hifiasm/0.15.2-GCCcore-10.3.0

hifiasm -o $OUTDIR/ERR11437354_fp.asm -t 32 $ANZDIR/ERR11437354_fp.fastq