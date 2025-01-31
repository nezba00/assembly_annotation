#!/usr/bin/env bash

#SBATCH --cpus-per-task=8
#SBATCH --mem=50G
#SBATCH --time=2:00:00
#SBATCH --job-name=Phylo
#SBATCH --output=/data/users/bnezar/assembly_annotation_course/slurm_out/output_Phylo4_%j.o
#SBATCH --error=/data/users/bnezar/assembly_annotation_course/slurm_out/error_Phylo4_%j.e
#SBATCH --partition=pibu_el8

TE_DIR=/data/users/bnezar/assembly_annotation_course/annotation/TEsorter_out
OUTDIR=/data/users/bnezar/assembly_annotation_course/annotation/phylogenetic_analysis2

mkdir -p $OUTDIR

cd $OUTDIR

module load SeqKit/2.6.1


grep Ty1-RT $TE_DIR/Copia_sequences.fa.rexdb-plant.dom.faa > $OUTDIR/copia_list.txt #make a list of RT proteins to extract 
sed -i 's/>//' $OUTDIR/copia_list.txt #remove ">" from the header 
sed -i 's/_INT#.*//' $OUTDIR/copia_list.txt #remove all characters following "empty space" from the header 
seqkit grep -n -f $OUTDIR/copia_list.txt $TE_DIR/Copia_sequences.fa.rexdb-plant.dom.faa -o Copia_RT.fasta

grep Ty3-RT $TE_DIR/Gypsy_sequences.fa.rexdb-plant.dom.faa > $OUTDIR/gypsy_list.txt #make a list of RT proteins to extract 
sed -i 's/>//' $OUTDIR/gypsy_list.txt #remove ">" from the header 
sed -i 's/_INT#.*//' $OUTDIR/gypsy_list.txt #remove all characters following "empty space" from the header 
seqkit grep -n -f $OUTDIR/gypsy_list.txt $TE_DIR/Gypsy_sequences.fa.rexdb-plant.dom.faa -o Gypsy_RT.fasta



Brassicaceae_TE_db=/data/courses/assembly-annotation-course/CDS_annotation/data/Brassicaceae_repbase_all_march2019.fasta

seqkit grep -n -r -p "Copia" $Brassicaceae_TE_db > $OUTDIR/Copia_Brassicaceae.fa
seqkit grep -n -r -p "Gypsy" $Brassicaceae_TE_db > $OUTDIR/Gypsy_Brassicaceae.fa



# Run TE sorter
apptainer exec --bind /data --writable-tmpfs -u \
 /data/courses/assembly-annotation-course/CDS_annotation/containers/TEsorter_1.3.0.sif \
 TEsorter $OUTDIR/Copia_Brassicaceae.fa -db rexdb-plant 

apptainer exec --bind /data --writable-tmpfs -u \
 /data/courses/assembly-annotation-course/CDS_annotation/containers/TEsorter_1.3.0.sif \
 TEsorter $OUTDIR/Gypsy_Brassicaceae.fa -db rexdb-plant 

 
grep Ty1-RT $OUTDIR/Copia_Brassicaceae.fa.rexdb-plant.dom.faa > $OUTDIR/copia_brass_list.txt #make a list of RT proteins to extract 
sed -i 's/>//' $OUTDIR/copia_brass_list.txt #remove ">" from the header 
sed -i 's/_INT#.*//' $OUTDIR/copia_brass_list.txt #remove all characters following "empty space" from the header 
seqkit grep -n -f $OUTDIR/copia_brass_list.txt $OUTDIR/Copia_Brassicaceae.fa.rexdb-plant.dom.faa -o Copia_brass_RT.fasta

grep Ty3-RT $OUTDIR/Gypsy_Brassicaceae.fa.rexdb-plant.dom.faa > $OUTDIR/gypsy_brass_list.txt #make a list of RT proteins to extract 
sed -i 's/>//' $OUTDIR/gypsy_brass_list.txt #remove ">" from the header 
sed -i 's/_INT#.*//' $OUTDIR/gypsy_brass_list.txt #remove all characters following "empty space" from the header 
seqkit grep -n -f $OUTDIR/gypsy_brass_list.txt $OUTDIR/Gypsy_Brassicaceae.fa.rexdb-plant.dom.faa -o Gypsy_brass_RT.fasta


module load Clustal-Omega/1.2.4-GCC-10.3.0
module load FastTree/2.1.11-GCCcore-10.3.0


# Concatenate brasicaceae and arabidopsis
cat $OUTDIR/Copia_RT.fasta $OUTDIR/Copia_brass_RT.fasta > $OUTDIR/Concat_Copia_RT.fasta
cat $OUTDIR/Gypsy_RT.fasta $OUTDIR/Gypsy_brass_RT.fasta > $OUTDIR/Concat_Gypsy_RT.fasta

clustalo -i $OUTDIR/Concat_Copia_RT.fasta -o $OUTDIR/Copia_RT_aligned.fasta --outfmt=fasta
clustalo -i $OUTDIR/Concat_Gypsy_RT.fasta -o $OUTDIR/Gypsy_RT_aligned.fasta --outfmt=fasta

# FastTree to build phylogenetic trees
FastTree -out $OUTDIR/Copia_RT_tree2.nwk $OUTDIR/Copia_RT_aligned.fasta
FastTree -out $OUTDIR/Gypsy_RT_tree2.nwk $OUTDIR/Gypsy_RT_aligned.fasta