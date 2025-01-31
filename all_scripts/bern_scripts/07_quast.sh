#!/usr/bin/env bash

#SBATCH --cpus-per-task=32
#SBATCH --mem=64G
#SBATCH --time=12:00:00
#SBATCH --job-name=QUAST
#SBATCH --output=/data/users/bnezar/assembly_annotation_course/slurm_out/output_quast_hifi_%j.o
#SBATCH --error=/data/users/bnezar/assembly_annotation_course/slurm_out/error_quast_hifi_%j.e
#SBATCH --partition=pibu_el8


WORKDIR=/data/users/bnezar/assembly_annotation_course
ASMDIR=$WORKDIR/assembly_out
OUTDIR=$WORKDIR/assembly_qc
NOREFOUT=$OUTDIR/quast


# Create dir if it doesnt exist
mkdir -p $OUTDIR

#FLYE=$ASMDIR/assembly.fasta
#FLYEOUT=$OUTDIR/quast/flye
#NOREFOUT=$OUTDIR/quast
#mkdir -p $FLYEOUT

HIFIASM=$ASMDIR/hifiasm/fastas/ERR11437354_fp.asm.bp.p_ctg.fa
HIFIASMOUT=$OUTDIR/quast/hifiasm
mkdir -p $HIFIASMOUT



REF_FEATURE=/data/courses/assembly-annotation-course/references/TAIR10_GFF3_genes.gff
REF=/data/courses/assembly-annotation-course/references/Arabidopsis_thaliana.TAIR10.dna.toplevel.fa

# with reference genomes
#apptainer exec \
#  --bind $WORKDIR \
#  /containers/apptainer/quast_5.2.0.sif \
#  quast.py -o $FLYEOUT --labels Anz0_flye -r $REF --threads 32 --eukaryote $FLYE
apptainer exec \
  --bind $WORKDIR \
  /containers/apptainer/quast_5.2.0.sif \
  quast.py -o $HIFIASMOUT --labels Anz-0_hifi -r $REF --threads 32 --eukaryote $HIFIASM
#apptainer exec \
#  --bind $WORKDIR \
#  /containers/apptainer/quast_5.2.0.sif \
#   quast.py -o $LJAOUT --labels Anz-0_lja -r $REF --threads 32 --eukaryote $LJA

# Without reference genomes
#apptainer exec \
#  --bind $WORKDIR \
#  /containers/apptainer/quast_5.2.0.sif \
#  quast.py -o $NOREFOUT/flye_noref --labels Anz0_flye --threads 32 --est-ref-size 130000000 --eukaryote $FLYE
#apptainer exec \
#  --bind $WORKDIR \
#  /containers/apptainer/quast_5.2.0.sif \
#  quast.py -o $NOREFOUT/hifi_noref --labels Anz-0_hifi --threads 32 --est-ref-size 130000000 --eukaryote $HIFIASM
#apptainer exec \
#  --bind $WORKDIR \
#  /containers/apptainer/quast_5.2.0.sif \
  #quast.py -o $NOREFOUT/lja_noref --labels Anz-0_lja --threads 32 --est-ref-size 130000000 --eukaryote $LJA
