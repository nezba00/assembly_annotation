#!/usr/bin/env bash

#SBATCH --cpus-per-task=64
#SBATCH --mem=96G
#SBATCH --time=2-00:00:00
#SBATCH --job-name=trinity_asmbly
#SBATCH --output=/data/users/bnezar/assembly_annotation_course/slurm_out/output_trinity4_%j.o
#SBATCH --error=/data/users/bnezar/assembly_annotation_course/slurm_out/error_trinity4_%j.e
#SBATCH --partition=pibu_el8


WORKDIR=/data/users/bnezar/assembly_annotation_course
ANZDIR=$WORKDIR/Anz-0_processed
SHADIR=$WORKDIR/RNAseq_Sha_processed
OUTDIR=$WORKDIR/assembly_out/trinity

# Create dir if it doesnt exist
mkdir -p $OUTDIR

module load Trinity/2.15.1-foss-2021a

Trinity --seqType fq --left $SHADIR/ERR754081_1_fp.fastq --right $SHADIR/ERR754081_2_fp.fastq \
        --CPU 64 --max_memory 90G --output $OUTDIR