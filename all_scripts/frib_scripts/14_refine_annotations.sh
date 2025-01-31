#!/usr/bin/env bash

#SBATCH --cpus-per-task=8
#SBATCH --mem=50G
#SBATCH --time=2:00:00
#SBATCH --job-name=refine_anno
#SBATCH --output=/data/users/bnezar/assembly_annotation_course/slurm_out/output_refine_anno_%j.o
#SBATCH --error=/data/users/bnezar/assembly_annotation_course/slurm_out/error_refine_anno_%j.e
#SBATCH --partition=pibu_el8


WORKDIR=/data/users/bnezar/assembly_annotation_course/annotation
COURSEDIR=/data/courses/assembly-annotation-course/CDS_annotation
MAKERBIN=$COURSEDIR/softwares/Maker_v3.01.03/src/bin


cd $WORKDIR

mkdir -p final


protein="assembly.all.maker.proteins.fasta" 
transcript="assembly.all.maker.transcripts.fasta" 
gff="assembly.all.maker.noseq.gff" 
prefix=anz

cp $gff final/${gff}.renamed.gff 
cp $protein final/${protein}.renamed.fasta 
cp $transcript final/${transcript}.renamed.fasta 


cd final 

# Rename genes/proteins/transcripts
$MAKERBIN/maker_map_ids --prefix $prefix --justify 7 ${gff}.renamed.gff > id.map 
$MAKERBIN/map_gff_ids id.map ${gff}.renamed.gff 
$MAKERBIN/map_fasta_ids id.map ${protein}.renamed.fasta 
$MAKERBIN/map_fasta_ids id.map ${transcript}.renamed.fasta 