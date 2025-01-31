#!/usr/bin/env bash

#SBATCH --cpus-per-task=8
#SBATCH --mem=50G
#SBATCH --time=2:00:00
#SBATCH --job-name=Age_estim
#SBATCH --output=/data/users/bnezar/assembly_annotation_course/slurm_out/output_Age_estim_%j.o
#SBATCH --error=/data/users/bnezar/assembly_annotation_course/slurm_out/error_Age_estim_%j.e
#SBATCH --partition=pibu_el8

INPUT=/data/users/bnezar/assembly_annotation_course/assembly_qc/EDTA_annotation_conda_lja/assembly.fasta.mod.EDTA.anno/assembly.fasta.mod.out
parseRM=/data/courses/assembly-annotation-course/CDS_annotation/scripts
OUTDIR=/data/users/bnezar/assembly_annotation_course/annotation/Age_estim

mkdir -p $OUTDIR

cd $OUTDIR

module add BioPerl/1.7.8-GCCcore-10.3.0 
perl $parseRM/05-parseRM.pl -i $INPUT -l 50,1 -v