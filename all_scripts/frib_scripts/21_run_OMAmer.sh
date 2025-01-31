#!/usr/bin/env bash

#SBATCH --cpus-per-task=8
#SBATCH --mem=50G
#SBATCH --time=24:00:00
#SBATCH --job-name=OMAMER
#SBATCH --output=/data/users/bnezar/assembly_annotation_course/slurm_out/output_OMAMER_%j.o
#SBATCH --error=/data/users/bnezar/assembly_annotation_course/slurm_out/error_OMAMER_%j.e
#SBATCH --partition=pibu_el8

WORKDIR=/data/users/bnezar/assembly_annotation_course/annotation
FINALDIR=/data/users/bnezar/assembly_annotation_course/annotation/final

protein="assembly.all.maker.proteins.fasta" 

cd $FINALDIR


wget https://omabrowser.org/All/LUCA.h5


omamer search --db LUCA.h5.4 --query ${protein}.renamed.filtered.fasta --out ${protein}.renamed.filtered.fasta.omamer

