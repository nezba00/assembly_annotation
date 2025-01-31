#!/usr/bin/env bash

#SBATCH --cpus-per-task=32
#SBATCH --mem=64G
#SBATCH --time=20:00:00
#SBATCH --job-name=BUSCO
#SBATCH --output=/data/users/bnezar/assembly_annotation_course/slurm_out/output_busco2_%j.o
#SBATCH --error=/data/users/bnezar/assembly_annotation_course/slurm_out/error_busco2_%j.e
#SBATCH --partition=pibu_el8


WORKDIR=/data/users/bnezar/assembly_annotation_course
ASMDIR=$WORKDIR/assembly_out
OUTDIR=$WORKDIR/assembly_qc

# Create dir if it doesnt exist
mkdir -p $OUTDIR

# No results yet 
LJA="$ASMDIR/lja/assembly.fasta"
LJAOUT=$OUTDIR/busco/lja
mkdir -p $LJAOUT

TRINITY=$ASMDIR/trinity.Trinity.fasta
TRINITYOUT=$OUTDIR/busco/trinity
mkdir -p $TRINITYOUT

module load BUSCO/5.4.2-foss-2021a


#lja
busco -i $LJA -o lja --out_path $LJAOUT --mode genome --lineage_dataset brassicales_odb10 --cpu 32 -f 

#trinity (transcriptome)
busco -i $TRINITY -o trinity --out_path $TRINITYOUT --mode transcriptome --lineage_dataset brassicales_odb10 --cpu 32 -f