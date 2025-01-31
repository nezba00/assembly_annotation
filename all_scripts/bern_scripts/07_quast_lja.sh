#!/usr/bin/env bash

#SBATCH --cpus-per-task=32
#SBATCH --mem=64G
#SBATCH --time=12:00:00
#SBATCH --job-name=QUAST
#SBATCH --output=/data/users/bnezar/assembly_annotation_course/slurm_out/output_quast1_%j.o
#SBATCH --error=/data/users/bnezar/assembly_annotation_course/slurm_out/error_quast1_%j.e
#SBATCH --partition=pibu_el8


WORKDIR=/data/users/bnezar/assembly_annotation_course
ASMDIR=$WORKDIR/assembly_out
OUTDIR=$WORKDIR/assembly_qc
NOREFOUT=$OUTDIR/quast


# Create dir if it doesnt exist
mkdir -p $OUTDIR


# No results yet 
LJA="$ASMDIR/lja/assembly.fasta"
LJAOUT=$OUTDIR/quast/lja
mkdir -p $LJAOUT


REF_FEATURE=/data/courses/assembly-annotation-course/references/TAIR10_GFF3_genes.gff
REF=/data/courses/assembly-annotation-course/references/Arabidopsis_thaliana.TAIR10.dna.toplevel.fa

# with reference genomes
apptainer exec \
  --bind $WORKDIR \
  /containers/apptainer/quast_5.2.0.sif \
   quast.py -o $LJAOUT --labels Anz-0_lja -r $REF --threads 32 --eukaryote $LJA

# Without reference genomes
apptainer exec \
  --bind $WORKDIR \
  /containers/apptainer/quast_5.2.0.sif \
  quast.py -o $NOREFOUT/lja_noref --labels Anz-0_lja --threads 32 --est-ref-size 130000000 --eukaryote $LJA
