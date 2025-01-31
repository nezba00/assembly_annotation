#!/usr/bin/env bash

#SBATCH --cpus-per-task=6
#SBATCH --mem=40G
#SBATCH --time=01:00:00
#SBATCH --job-name=kmers
#SBATCH --output=/data/users/bnezar/assembly_annotation_course/slurm_out/output_kmers_%j.o
#SBATCH --error=/data/users/bnezar/assembly_annotation_course/slurm_out/error_kmers_%j.e
#SBATCH --partition=pibu_el8

WORKDIR=/data/users/bnezar/assembly_annotation_course
ANZOUT=$WORKDIR/Anz-0_processed
SHAOUT=$WORKDIR/RNAseq_Sha_processed
OUTDIR=$WORKDIR/read_QC/kmer_counts

module load Jellyfish/2.3.0-GCC-10.3.0


jellyfish count \
    -C -m 21 -s 5G -t 4 -o $OUTDIR/anz0_reads.jf \
    <(zcat $ANZOUT/ERR11437354_fp.fastq.gz)
    
jellyfish count \
    -C -m 21 -s 5G -t 4 -o $OUTDIR/ERR754081_1_reads.jf \
    <(zcat $SHAOUT/ERR754081_1_fp.fastq.gz)

jellyfish count \
    -C -m 21 -s 5G -t 4 -o $OUTDIR/ERR754081_2_reads.jf \
    <(zcat $SHAOUT/ERR754081_2_fp.fastq.gz)    




# Create histogram files
jellyfish histo -t 4 $OUTDIR/anz0_reads.jf > $OUTDIR/anz0_reads.histo
jellyfish histo -t 4 $OUTDIR/ERR754081_1_reads.jf > $OUTDIR/ERR754081_1_reads.histo
jellyfish histo -t 4 $OUTDIR/ERR754081_2_reads.jf > $OUTDIR/ERR754081_2_reads.histo


