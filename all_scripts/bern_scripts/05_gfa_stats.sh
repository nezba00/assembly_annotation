#!/usr/bin/env bash

#SBATCH --cpus-per-task=4
#SBATCH --mem=16G
#SBATCH --time=01:00:00
#SBATCH --job-name=gfastats_analysis
#SBATCH --partition=pibu_el8
#SBATCH --output=/data/users/bnezar/assembly_annotation_course/slurm_out/output_gfa_%j.o
#SBATCH --error=/data/users/bnezar/assembly_annotation_course/slurm_out/error_gfa_%j.e

WORKDIR=/data/users/bnezar/assembly_annotation_course
OUTDIR=$WORKDIR/assembly_out

GFASTATS_OUTDIR=$WORKDIR/gfastats_results
mkdir -p $GFASTATS_OUTDIR

HIFIASM_ASM=$OUTDIR/hifiasm/ERR11437354.asm.bp.p_ctg.gfa

GFASTATS_CONTAINER=/containers/apptainer/gfastats_1.3.7.sif

apptainer exec --bind $WORKDIR $GFASTATS_CONTAINER gfastats -o $GFASTATS_OUTDIR/hifiasm_gfastats.txt $HIFIASM_ASM --discover-paths

# echo "GFASTATS analysis completed. Results stored in $GFASTATS_OUTDIR