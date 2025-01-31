#!/usr/bin/env bash

#SBATCH --cpus-per-task=8
#SBATCH --mem=50G
#SBATCH --time=24:00:00
#SBATCH --job-name=BLAST2
#SBATCH --output=/data/users/bnezar/assembly_annotation_course/slurm_out/output_BLAST2_%j.o
#SBATCH --error=/data/users/bnezar/assembly_annotation_course/slurm_out/error_BLAST2_%j.e
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


cp ${protein}.renamed.longest.fasta maker_proteins.fasta.Uniprot
cp filtered.genes.renamed.final.gff3 filtered.maker.gff3.Uniprot

$MAKERBIN/maker_functional_fasta $DATABASE $BLASTDIR/output.blast_results \
    ${protein}.renamed.longest.fasta > maker_proteins.fasta.Uniprot
$MAKERBIN/maker_functional_gff $DATABASE $BLASTDIR/output.blast_results \
    filtered.genes.renamed.final.gff3 > filtered.maker.gff3.Uniprot