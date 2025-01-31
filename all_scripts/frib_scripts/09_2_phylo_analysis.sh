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

cd $OUTDIR

# Run TE sorter on reference file
apptainer exec --bind /data --writable-tmpfs -u \
 /data/courses/assembly-annotation-course/CDS_annotation/containers/TEsorter_1.3.0.sif \
 TEsorter $OUTDIR/Copia_Brassicaceae.fa -db rexdb-plant 

apptainer exec --bind /data --writable-tmpfs -u \
 /data/courses/assembly-annotation-course/CDS_annotation/containers/TEsorter_1.3.0.sif \
 TEsorter $OUTDIR/Gypsy_Brassicaceae.fa -db rexdb-plant 

 
grep Ty1-RT $OUTDIR/Copia_Brassicaceae.fa.rexdb-plant.dom.faa > $OUTDIR/copia_brass_list.txt #make a list of RT proteins to extract 
sed -i 's/>//' $OUTDIR/copia_brass_list.txt #remove ">" from the header 
sed -i 's/ .\+//' $OUTDIR/copia_brass_list.txt #remove all characters following "empty space" from the header 
seqkit grep -f $OUTDIR/copia_brass_list.txt $OUTDIR/Copia_Brassicaceae.fa.rexdb-plant.dom.faa -o Copia_brass_RT.fasta

grep Ty3-RT $OUTDIR/Gypsy_Brassicaceae.fa.rexdb-plant.dom.faa > $OUTDIR/gypsy_brass_list.txt #make a list of RT proteins to extract 
sed -i 's/>//' $OUTDIR/gypsy_brass_list.txt #remove ">" from the header 
sed -i 's/ .\+//' $OUTDIR/gypsy_brass_list.txt #remove all characters following "empty space" from the header 
seqkit grep -f $OUTDIR/gypsy_brass_list.txt $OUTDIR/Gypsy_Brassicaceae.fa.rexdb-plant.dom.faa -o Gypsy_brass_RT.fasta
