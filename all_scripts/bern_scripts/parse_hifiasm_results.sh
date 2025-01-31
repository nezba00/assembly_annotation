#!/usr/bin/env bash

#SBATCH --cpus-per-task=32
#SBATCH --mem=64G
#SBATCH --time=04:00:00
#SBATCH --job-name=parse_hifiasm
#SBATCH --output=/data/users/bnezar/assembly_annotation_course/slurm_out/output_parse_%j.o
#SBATCH --error=/data/users/bnezar/assembly_annotation_course/slurm_out/error_parse_%j.e
#SBATCH --partition=pibu_el8


HIFIDIR=/data/users/bnezar/assembly_annotation_course/assembly_out/hifiasm

cd $HIFIDIR

awk '/^S/{print ">"$2;print $3}' FILE.gfa > FILE.fa


awk '/^S/{print ">"$2;print $3}' ERR11437354_fp.asm.bp.hap1.p_ctg.gfa > ERR11437354_fp.asm.bp.hap1.p_ctg.fa