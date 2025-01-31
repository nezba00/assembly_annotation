#!/usr/bin/env bash

#SBATCH --cpus-per-task=8
#SBATCH --mem=50G
#SBATCH --time=2:00:00
#SBATCH --job-name=get_file
#SBATCH --output=/data/users/bnezar/assembly_annotation_course/slurm_out/get_file_%j.o
#SBATCH --error=/data/users/bnezar/assembly_annotation_course/slurm_out/get_file_%j.e
#SBATCH --partition=pibu_el8

WORK_DIR=/data/users/bnezar/assembly_annotation_course/assembly_qc/
CONTAINER_DIR=/data/courses/assembly-annotation-course/containers2/TEsorter_1.3.0.sif
EDTAPATH=/data/courses/assembly-annotation-course/CDS_annotation/example_EDTA_data/edta_annotation
OUTDIR=$WORKDIR/EDTA_annotation_conda_lja/extract_infos

cd $OUTDIR

# Use TEsorter to get clade info
apptainer exec -C -H /data -H ${pwd}:/work \
 --writable-tmpfs -u $CONTAINER_DIR \
 TEsorter $EDTAPATH/assembly.fasta.mod.EDTA.raw/LTR/assembly.fasta.mod.LTR.intact.fa -db rexdb-plant
