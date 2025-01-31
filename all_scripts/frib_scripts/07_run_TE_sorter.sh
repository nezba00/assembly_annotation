#!/usr/bin/env bash

#SBATCH --cpus-per-task=8
#SBATCH --mem=50G
#SBATCH --time=2:00:00
#SBATCH --job-name=TE_Sorter
#SBATCH --output=/data/users/bnezar/assembly_annotation_course/slurm_out/output_TEsorter_%j.o
#SBATCH --error=/data/users/bnezar/assembly_annotation_course/slurm_out/error_TEsorter_%j.e
#SBATCH --partition=pibu_el8

ASM_QC=/data/users/bnezar/assembly_annotation_course/assembly_qc
GENOME=$ASM_QC/EDTA_annotation_conda_lja/assembly.fasta.mod.EDTA.TElib.fa
OUTDIR=/data/users/bnezar/assembly_annotation_course/annotation/TEsorter_out

mkdir -p $OUTDIR


module load SeqKit/2.6.1


cd $OUTDIR


# Extract Copia sequences 
seqkit grep -r -p "Copia" $GENOME > Copia_sequences.fa 
# Extract Gypsy sequences 
seqkit grep -r -p "Gypsy" $GENOME > Gypsy_sequences.fa 


# Run TE sorter once for each clade
apptainer exec --bind /data --writable-tmpfs -u \
 /data/courses/assembly-annotation-course/CDS_annotation/containers/TEsorter_1.3.0.sif \
 TEsorter $OUTDIR/Copia_sequences.fa -db rexdb-plant 

apptainer exec --bind /data --writable-tmpfs -u \
 /data/courses/assembly-annotation-course/CDS_annotation/containers/TEsorter_1.3.0.sif \
 TEsorter $OUTDIR/Gypsy_sequences.fa -db rexdb-plant 
