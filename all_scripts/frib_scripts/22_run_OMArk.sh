#!/usr/bin/env bash

#SBATCH --cpus-per-task=8
#SBATCH --mem=50G
#SBATCH --time=24:00:00
#SBATCH --job-name=OMArk
#SBATCH --output=/data/users/bnezar/assembly_annotation_course/slurm_out/output_OMArk_%j.o
#SBATCH --error=/data/users/bnezar/assembly_annotation_course/slurm_out/error_OMArk_%j.e
#SBATCH --partition=pibu_el8

WORKDIR=/data/users/bnezar/assembly_annotation_course/annotation
FINALDIR=/data/users/bnezar/assembly_annotation_course/annotation/final

protein="assembly.all.maker.proteins.fasta" 

cd $FINALDIR



omark -f ${protein}.renamed.filtered.fasta.omamer -of ${protein}.renamed.filtered.fasta -i omark_input.txt -d LUCA.h5.4 -o omark_output
