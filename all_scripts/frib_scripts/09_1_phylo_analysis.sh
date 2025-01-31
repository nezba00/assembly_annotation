#!/usr/bin/env bash

#SBATCH --cpus-per-task=8
#SBATCH --mem=50G
#SBATCH --time=2:00:00
#SBATCH --job-name=Phylo
#SBATCH --output=/data/users/bnezar/assembly_annotation_course/slurm_out/output_Phylo5_%j.o
#SBATCH --error=/data/users/bnezar/assembly_annotation_course/slurm_out/error_Phylo5_%j.e
#SBATCH --partition=pibu_el8

TE_DIR=/data/users/bnezar/assembly_annotation_course/annotation/TEsorter_out
OUTDIR=/data/users/bnezar/assembly_annotation_course/annotation/phylogenetic_analysis3

mkdir -p $OUTDIR

cd $OUTDIR

module load SeqKit/2.6.1


grep Ty1-RT $TE_DIR/Copia_sequences.fa.rexdb-plant.dom.faa > $OUTDIR/copia_list.txt #make a list of RT proteins to extract 
sed -i 's/>//' $OUTDIR/copia_list.txt #remove ">" from the header 
sed -i 's/ .\+//' $OUTDIR/copia_list.txt #remove all characters following "empty space" from the header 
seqkit grep -f $OUTDIR/copia_list.txt $TE_DIR/Copia_sequences.fa.rexdb-plant.dom.faa -o Copia_RT.fasta

grep Ty3-RT $TE_DIR/Gypsy_sequences.fa.rexdb-plant.dom.faa > $OUTDIR/gypsy_list.txt #make a list of RT proteins to extract 
sed -i 's/>//' $OUTDIR/gypsy_list.txt #remove ">" from the header 
sed -i 's/ .\+//' $OUTDIR/gypsy_list.txt #remove all characters following "empty space" from the header 
seqkit grep -f $OUTDIR/gypsy_list.txt $TE_DIR/Gypsy_sequences.fa.rexdb-plant.dom.faa -o Gypsy_RT.fasta



Brassicaceae_TE_db=/data/courses/assembly-annotation-course/CDS_annotation/data/Brassicaceae_repbase_all_march2019.fasta

seqkit grep -r -p "Copia" $Brassicaceae_TE_db > $OUTDIR/Copia_Brassicaceae.fa
seqkit grep -r -p "Gypsy" $Brassicaceae_TE_db > $OUTDIR/Gypsy_Brassicaceae.fa
