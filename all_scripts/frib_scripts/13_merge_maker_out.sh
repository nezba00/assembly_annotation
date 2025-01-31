#!/usr/bin/env bash

#SBATCH --cpus-per-task=8
#SBATCH --mem=50G
#SBATCH --time=2:00:00
#SBATCH --job-name=merge_maker
#SBATCH --output=/data/users/bnezar/assembly_annotation_course/slurm_out/output_merge_maker_%j.o
#SBATCH --error=/data/users/bnezar/assembly_annotation_course/slurm_out/error_merge_maker_%j.e
#SBATCH --partition=pibu_el8

WORKDIR=/data/users/bnezar/assembly_annotation_course/annotation
COURSEDIR=/data/courses/assembly-annotation-course/CDS_annotation
MAKERBIN=$COURSEDIR/softwares/Maker_v3.01.03/src/bin

cd $WORKDIR

$MAKERBIN/gff3_merge -s -d assembly.maker.output/assembly_master_datastore_index.log > assembly.all.maker.gff 
$MAKERBIN/gff3_merge -n -s -d assembly.maker.output/assembly_master_datastore_index.log > assembly.all.maker.noseq.gff 
$MAKERBIN/fasta_merge -d assembly.maker.output/assembly_master_datastore_index.log -o assembly 