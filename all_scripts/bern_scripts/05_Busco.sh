#!/usr/bin/env bash

#SBATCH --cpus-per-task=32
#SBATCH --mem=64G
#SBATCH --time=20:00:00
#SBATCH --job-name=BUSCO
#SBATCH --output=/data/users/bnezar/assembly_annotation_course/slurm_out/output_busco1_%j.o
#SBATCH --error=/data/users/bnezar/assembly_annotation_course/slurm_out/error_busco_%j.e
#SBATCH --partition=pibu_el8


WORKDIR=/data/users/bnezar/assembly_annotation_course
ASMDIR=$WORKDIR/assembly_out
OUTDIR=$WORKDIR/assembly_qc

# Create dir if it doesnt exist
mkdir -p $OUTDIR


FLYE=$ASMDIR/assembly.fasta
FLYEOUT=$OUTDIR/busco/flye
mkdir -p $FLYEOUT

HIFIASM=$ASMDIR/hifiasm/fastas/ERR11437354_fp.asm.bp.p_ctg.fa
HIFIASMOUT=$OUTDIR/busco/hifiasm
mkdir -p $HIFIASMOUT

# No results yet 
#LJA="$WORKDIR/assembly/LJA/assembly.fasta"
#LJAOUT=$OUTDIR/busco/LJA
#mkdir -p $LJAOUT

#TRINITY=$ASMDIR/trinity/trinity.Trinity.fasta
#TRINITYOUT=$OUTDIR/busco/trinity
#mkdir -p $TRINITYOUT

module load BUSCO/5.4.2-foss-2021a


#flye
busco --in $FLYE --out flye --out_path $FLYEOUT --mode genome --lineage_dataset brassicales_odb10 --cpu 32 -f 

#hifiasm
busco -i $HIFIASM -o hifiasm --out_path $HIFIASMOUT --mode genome --lineage_dataset brassicales_odb10 --cpu 32 -f

#lja
#busco -i $LJA -o LJA --out_path $LJAOUT --mode genome --lineage_dataset brassicales_odb10 --cpu 32 -f 

#trinity (transcriptome)
#busco -i $TRINITY -o trinity --out_path $TRINITYOUT --mode transcriptome --lineage_dataset brassicales_odb10 --cpu 32 -f