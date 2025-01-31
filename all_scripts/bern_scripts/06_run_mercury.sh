#!/usr/bin/env bash

#SBATCH --cpus-per-task=32
#SBATCH --mem=60G
#SBATCH --time=12:00:00
#SBATCH --job-name=run_merq
#SBATCH --output=/data/users/bnezar/assembly_annotation_course/slurm_out/output_mercury5_%j.o
#SBATCH --error=/data/users/bnezar/assembly_annotation_course/slurm_out/error_mercury5_%j.e
#SBATCH --partition=pibu_el8

# Working Directories
WORKDIR=/data/users/bnezar/assembly_annotation_course
ASMDIR=$WORKDIR/assembly_out
READDIR=$WORKDIR/Anz-0_processed/ERR11437354_fp.fastq

# Input Dirs
FLYEIN=$ASMDIR/assembly.fasta
HIFIASMIN=$ASMDIR/hifiasm/fastas/ERR11437354_fp.asm.bp.p_ctg.fa
LJAIN="$WORKDIR/lja/assembly.fasta"

# Output Dirs
MERCURYDIR=$WORKDIR/assembly_qc/merqury
MERYLDIR=$MERCURYDIR/MRL.meryl
FLYEOUT=$MERCURYDIR/flye
HIFIOUT=$MERCURYDIR/hifi
LJAOUT=$MERCURYDIR/lja

mkdir -p $MERCURYDIR $MERYLDIR $FLYEOUT $HIFIOUT

export MERQURY="/usr/local/share/merqury"

cd $FLYEOUT
# Run Merqury
apptainer exec --bind $WORKDIR\
 /containers/apptainer/merqury_1.3.sif\
 merqury.sh $MERYLDIR $FLYEIN flye_merq

cd $HIFIOUT
apptainer exec --bind $WORKDIR\
 /containers/apptainer/merqury_1.3.sif\
 merqury.sh $MERYLDIR $HIFIASMIN hifi_merq

#cd $ljaout
#apptainer exec --bind $WORKDIR\
# /containers/apptainer/merqury_1.3.sif\
# merqury.sh $MERYLDIR $LJAIN $LJAOUT/lja_merq


