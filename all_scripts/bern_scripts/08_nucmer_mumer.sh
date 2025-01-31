#!/usr/bin/env bash

#SBATCH --cpus-per-task=16
#SBATCH --mem=64G
#SBATCH --time=12:00:00
#SBATCH --job-name=MUMMER
#SBATCH --output=/data/users/bnezar/assembly_annotation_course/slurm_out/output_mumer_%j.o
#SBATCH --error=/data/users/bnezar/assembly_annotation_course/slurm_out/error_mumer_%j.e
#SBATCH --partition=pibu_el8

### Set constants
# Set Directories
WORKDIR=/data/users/bnezar/assembly_annotation_course
ASMDIR=$WORKDIR/assembly_out
OUTDIR=$WORKDIR/assembly_qc/mummer
mkdir -p $OUTDIR

# Paths to assembly and for output
FLYEASM=$ASMDIR/assembly.fasta
FLYEOUT=$OUTDIR/flye

HIFIASM=$ASMDIR/hifiasm/fastas/ERR11437354_fp.asm.bp.p_ctg.fa
HIFIOUT=$OUTDIR/hifiasm
 
LJAASM=$ASMDIR/lja/assembly.fasta
LJAOUT=$OUTDIR/lja

CROSSCOMP=$OUTDIR/cross_comparison

# Create dirs if necessary
mkdir -p $FLYEOUT $HIFIOUT $LJAOUT $CROSSCOMP

# Paths to reference fasta
REF=/data/courses/assembly-annotation-course/references/Arabidopsis_thaliana.TAIR10.dna.toplevel.fa



### Compare FASTAS to reference
cd $FLYEOUT
apptainer exec \
  --bind $WORKDIR --bind /data/courses/assembly-annotation-course \
  /containers/apptainer/mummer4_gnuplot.sif \
  nucmer --prefix flye_comp --breaklen 1000 --mincluster 1000 $REF $FLYEASM
apptainer exec \
  --bind $WORKDIR --bind /data/courses/assembly-annotation-course \
  /containers/apptainer/mummer4_gnuplot.sif \
  mummerplot --prefix flye_comp -R $REF -Q $FLYEASM --filter -t png --large \
  --layout --fat flye_comp.delta


cd $HIFIOUT
apptainer exec \
  --bind $WORKDIR --bind /data/courses/assembly-annotation-course \
  /containers/apptainer/mummer4_gnuplot.sif \
  nucmer --prefix hifi_comp --breaklen 1000 --mincluster 1000 $REF $HIFIASM
apptainer exec \
  --bind $WORKDIR --bind /data/courses/assembly-annotation-course \
  /containers/apptainer/mummer4_gnuplot.sif \
  mummerplot --prefix hifi_comp -R $REF -Q $HIFIASM --filter -t png --large \
  --layout --fat hifi_comp.delta


cd $LJAOUT
apptainer exec \
  --bind $WORKDIR --bind /data/courses/assembly-annotation-course \
  /containers/apptainer/mummer4_gnuplot.sif \
  nucmer --prefix lja_comp --breaklen 1000 --mincluster 1000 $REF $LJAASM
apptainer exec \
  --bind $WORKDIR --bind /data/courses/assembly-annotation-course \
  /containers/apptainer/mummer4_gnuplot.sif \
  mummerplot --prefix lja_comp -R $REF -Q $LJAASM --filter -t png --large \
  --layout --fat lja_comp.delta



### Compare FastAs against eachother
cd $CROSSCOMP
# Flye (reference) against hifiasm
apptainer exec \
  --bind $WORKDIR --bind /data/courses/assembly-annotation-course \
  /containers/apptainer/mummer4_gnuplot.sif \
  nucmer --prefix flye_hifi --breaklen 1000 --mincluster 1000 $FLYEASM $HIFIASM
apptainer exec \
  --bind $WORKDIR --bind /data/courses/assembly-annotation-course \
  /containers/apptainer/mummer4_gnuplot.sif \
  mummerplot --prefix flye_hifi -R $FLYEASM -Q $HIFIASM --filter -t png --large \
  --layout --fat flye_hifi.delta


# Hifiasm against lja
apptainer exec \
  --bind $WORKDIR --bind /data/courses/assembly-annotation-course \
  /containers/apptainer/mummer4_gnuplot.sif \
  nucmer --prefix hifi_lja --breaklen 1000 --mincluster 1000 $HIFIASM $LJAASM
apptainer exec \
  --bind $WORKDIR --bind /data/courses/assembly-annotation-course \
  /containers/apptainer/mummer4_gnuplot.sif \
  mummerplot --prefix hifi_lja -R $HIFIASM -Q $LJAASM --filter -t png --large \
  --layout --fat hifi_lja.delta


# lja against flye
apptainer exec \
  --bind $WORKDIR --bind /data/courses/assembly-annotation-course \
  /containers/apptainer/mummer4_gnuplot.sif \
  nucmer --prefix lja_flye --breaklen 1000 --mincluster 1000 $LJAASM $FLYEASM
apptainer exec \
  --bind $WORKDIR --bind /data/courses/assembly-annotation-course \
  /containers/apptainer/mummer4_gnuplot.sif \
  mummerplot --prefix lja_flye -R $LJAASM -Q $FLYEASM --filter -t png --large \
  --layout --fat lja_flye.delta