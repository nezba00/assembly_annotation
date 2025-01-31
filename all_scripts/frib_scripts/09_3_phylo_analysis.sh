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

module load SeqKit/2.6.1
module load Clustal-Omega/1.2.4-GCC-10.3.0
module load FastTree/2.1.11-GCCcore-10.3.0


# Concatenate brasicaceae with our data
cat $OUTDIR/Copia_RT.fasta $OUTDIR/Copia_brass_RT.fasta > $OUTDIR/Concat_Copia_RT.fasta
cat $OUTDIR/Gypsy_RT.fasta $OUTDIR/Gypsy_brass_RT.fasta > $OUTDIR/Concat_Gypsy_RT.fasta

# Shorten identifiers
sed -i 's/#.\+//' $OUTDIR/Concat_Copia_RT.fasta 
sed -i 's/:/_/g' $OUTDIR/Concat_Copia_RT.fasta 

sed -i 's/#.\+//' $OUTDIR/Concat_Gypsy_RT.fasta 
sed -i 's/:/_/g' $OUTDIR/Concat_Gypsy_RT.fasta 

# Target headers that have complex annotations and remove everything after the first space
sed -i '/^>/ s/[ |;].*//' $OUTDIR/Concat_Copia_RT.fasta
sed -i '/^>/ s/[ |;].*//' $OUTDIR/Concat_Gypsy_RT.fasta


clustalo -i $OUTDIR/Concat_Copia_RT.fasta -o $OUTDIR/Copia_RT_aligned.fasta --outfmt=fasta
clustalo -i $OUTDIR/Concat_Gypsy_RT.fasta -o $OUTDIR/Gypsy_RT_aligned.fasta --outfmt=fasta

# FastTree to build phylogenetic trees
FastTree -out $OUTDIR/Copia_RT_tree.nwk $OUTDIR/Copia_RT_aligned.fasta
FastTree -out $OUTDIR/Gypsy_RT_tree.nwk $OUTDIR/Gypsy_RT_aligned.fasta