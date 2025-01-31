#!/usr/bin/env bash

#SBATCH --cpus-per-task=32
#SBATCH --mem=60G
#SBATCH --time=12:00:00
#SBATCH --job-name=meryl
#SBATCH --output=/data/users/bnezar/assembly_annotation_course/slurm_out/output_meryl1_%j.o
#SBATCH --error=/data/users/bnezar/assembly_annotation_course/slurm_out/error_meryl1_%j.e
#SBATCH --partition=pibu_el8

WORKDIR=/data/users/bnezar/assembly_annotation_course

READDIR=$WORKDIR/Anz-0_processed/ERR11437354_fp.fastq
MERCURYDIR=$WORKDIR/assembly_qc/merqury
MERYLDIR=$MERCURYDIR/MRL.meryl


mkdir -p $MERCURYDIR $MERYLDIR

export MERQURY="/usr/local/share/merqury"


# Best K
#genome: 130000000
#tolerable collision rate: 0.001
#18.4591

# build kmer dbs
apptainer exec --bind $WORKDIR\
 /containers/apptainer/merqury_1.3.sif\
 meryl k=18 count $READDIR output $MERYLDIR


