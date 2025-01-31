#!/usr/bin/env bash

#SBATCH --time=01:00:00
#SBATCH --mem=64G
#SBATCH --cpus-per-task=10
#SBATCH --job-name=OMArk_context
#SBATCH --partition=pibu_el8
#SBATCH --output=/data/users/bnezar/assembly_annotation_course/slurm_out/output_OMArk_context_%j.out
#SBATCH --error=/data/users/bnezar/assembly_annotation_course/slurm_out/error_OMArk_context_%j.err

COURSEDIR="/data/courses/assembly-annotation-course/CDS_annotation"
OMAMERFILE=/data/users/bnezar/assembly_annotation_course/annotation/final/assembly.all.maker.proteins.fasta.renamed.filtered.fasta.omamer
OUTDIR=/data/users/bnezar/assembly_annotation_course/annotation/final/omark_output

# Download the Orthologs of fragmented and missing genes from OMArk database
$COURSEDIR/softwares/OMArk-0.3.0/utils/omark_contextualize.py fragment -m $OMAMERFILE -o $OUTDIR -f fragment_HOGs
$COURSEDIR/softwares/OMArk-0.3.0/utils/omark_contextualize.py missing -m $OMAMERFILE -o $OUTDIR -f missing_HOGs 