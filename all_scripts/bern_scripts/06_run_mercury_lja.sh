#!/usr/bin/env bash

#SBATCH --cpus-per-task=32
#SBATCH --mem=60G
#SBATCH --time=12:00:00
#SBATCH --job-name=run_merq
#SBATCH --output=/data/users/bnezar/assembly_annotation_course/slurm_out/output_mercury5_%j.o
#SBATCH --error=/data/users/bnezar/assembly_annotation_course/slurm_out/error_mercury5_%j.e
#SBATCH --partition=pibu_el8

# Working Directories
WORKDIR=/data/users/bnezar/assembly_annotation_course
ASMDIR=$WORKDIR/assembly_out
READDIR=$WORKDIR/Anz-0_processed/ERR11437354_fp.fastq

# Input Dirs
LJAIN="$ASMDIR/lja/assembly.fasta"

# Output Dirs
MERCURYDIR=$WORKDIR/assembly_qc/merqury
MERYLDIR=$MERCURYDIR/MRL.meryl
LJAOUT=$MERCURYDIR/lja

mkdir -p $MERCURYDIR $MERYLDIR $LJAOUT

export MERQURY="/usr/local/share/merqury"

cd $LJAOUT
apptainer exec --bind $WORKDIR\
 /containers/apptainer/merqury_1.3.sif\
 merqury.sh $MERYLDIR $LJAIN lja_merq


