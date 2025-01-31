#!/bin/bash
#SBATCH --time=1-0
#SBATCH --mem=64G
#SBATCH -p pibu_el8
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=20
#SBATCH --job-name=Genespace
#SBATCH --output=/data/users/bnezar/assembly_annotation_course/slurm_out/output_Genespace_%j.out
#SBATCH --error=/data/users/bnezar/assembly_annotation_course/slurm_out/error_Genespace_%j.err

COURSEDIR="/data/courses/assembly-annotation-course/CDS_annotation"
WORKDIR="/data/users/bnezar/assembly_annotation_course/annotation/final"
SCRIPTS="/data/users/bnezar/assembly_annotation_course/frib_scripts"
OUTDIR="$WORKDIR/genespace"

cd $WORKDIR


apptainer exec \
    --bind $COURSEDIR \
    --bind $WORKDIR \
    --bind $SCRATCH:/temp \
    $COURSEDIR/containers/genespace_latest.sif Rscript $SCRIPTS/31-Genespace.R $OUTDIR

# apptainer shell \
#     --bind $COURSEDIR \
#     --bind $WORKDIR \
#     --bind $SCRATCH:/temp \
#     $COURSEDIR/containers/genespace_latest.sif