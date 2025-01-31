#!/usr/bin/env bash

#SBATCH --cpus-per-task=8
#SBATCH --mem=50G
#SBATCH --time=24:00:00
#SBATCH --job-name=Filter
#SBATCH --output=/data/users/bnezar/assembly_annotation_course/slurm_out/output_Filter_%j.o
#SBATCH --error=/data/users/bnezar/assembly_annotation_course/slurm_out/error_Filter_%j.e
#SBATCH --partition=pibu_el8

WORKDIR=/data/users/bnezar/assembly_annotation_course/annotation
COURSEDIR=/data/courses/assembly-annotation-course/CDS_annotation
MAKERBIN=$COURSEDIR/softwares/Maker_v3.01.03/src/bin
FINALDIR=/data/users/bnezar/assembly_annotation_course/annotation/final

protein="assembly.all.maker.proteins.fasta" 
transcript="assembly.all.maker.transcripts.fasta" 
gff="assembly.all.maker.noseq.gff" 

module load SeqKit/2.6.1

cd $FINALDIR

seqkit sort -l -r ${protein}.renamed.fasta | seqkit rmdup -s > ${protein}.renamed.longest.fasta
seqkit sort -l -r ${transcript}.renamed.fasta | seqkit rmdup -s > ${transcript}.renamed.longest.fasta


