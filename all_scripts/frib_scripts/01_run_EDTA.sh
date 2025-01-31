#!/usr/bin/env bash

#SBATCH --cpus-per-task=80
#SBATCH --mem=100G
#SBATCH --time=23:00:00
#SBATCH --job-name=EDTA_conda
#SBATCH --output=/data/users/bnezar/assembly_annotation_course/slurm_out/output_edta_conda_%j.o
#SBATCH --error=/data/users/bnezar/assembly_annotation_course/slurm_out/error_edta_conda_%j.e
#SBATCH --partition=pibu_el8

WORKDIR=/data/users/bnezar/assembly_annotation_course
ASMDIR=$WORKDIR/assembly_out
OUTDIR=$WORKDIR/assembly_qc/EDTA_annotation_conda_lja
mkdir -p $OUTDIR

cd $OUTDIR 


perl /data/users/bnezar/assembly_annotation_course/frib_scripts/EDTA/EDTA.pl \
   --genome $ASMDIR/lja/assembly.fasta \
   --species others \
   --step all \
   --cds "/data/courses/assembly-annotation-course/CDS_annotation/data/TAIR10_cds_20110103_representative_gene_model_updated" \
   --anno 1 \
   --threads 80