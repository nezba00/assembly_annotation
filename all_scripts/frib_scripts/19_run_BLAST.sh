#!/usr/bin/env bash

#SBATCH --cpus-per-task=20
#SBATCH --mem=50G
#SBATCH --time=10:00:00
#SBATCH --job-name=BLAST1
#SBATCH --output=/data/users/bnezar/assembly_annotation_course/slurm_out/output_BLAST1_%j.o
#SBATCH --error=/data/users/bnezar/assembly_annotation_course/slurm_out/error_BLAST1_%j.e
#SBATCH --partition=pibu_el8

WORKDIR=/data/users/bnezar/assembly_annotation_course/annotation
COURSEDIR=/data/courses/assembly-annotation-course/CDS_annotation
MAKERBIN=$COURSEDIR/softwares/Maker_v3.01.03/src/bin
FINALDIR=/data/users/bnezar/assembly_annotation_course/annotation/final
BLASTDIR=$WORKDIR/blast_results
DATABASE=/data/courses/assembly-annotation-course/CDS_annotation/data/uniprot/uniprot_viridiplantae_reviewed.fa

protein="assembly.all.maker.proteins.fasta" 
transcript="assembly.all.maker.transcripts.fasta" 
gff="assembly.all.maker.noseq.gff" 

mkdir -p $BLASTDIR

cd $FINALDIR

module load BLAST+/2.15.0-gompi-2021a

#makeblastdb -in $DATABASE -dbtype prot
# this step is already done
blastp -query ${protein}.renamed.longest.fasta -db $DATABASE \
    -num_threads 20 -outfmt 6 -evalue 1e-10 -out $BLASTDIR/output.blast_results
