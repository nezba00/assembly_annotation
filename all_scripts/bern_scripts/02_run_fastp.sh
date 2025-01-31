#!/usr/bin/env bash

#SBATCH --cpus-per-task=6
#SBATCH --mem=40G
#SBATCH --time=01:00:00
#SBATCH --job-name=fastp
#SBATCH --output=/data/users/bnezar/assembly_annotation_course/slurm_out/output_fastp_%j.o
#SBATCH --error=/data/users/bnezar/assembly_annotation_course/slurm_out/error_fastp_%j.e
#SBATCH --partition=pibu_el8

WORKDIR=/data/users/bnezar/assembly_annotation_course
ANZIN=$WORKDIR/Anz-0
SHAIN=$WORKDIR/RNAseq_Sha
ANZOUT=$WORKDIR/Anz-0_processed
SHAOUT=$WORKDIR/RNAseq_Sha_processed

module load fastp/0.23.4-GCC-10.3.0


#Specify window size and mean quality threshold for cut_front
CUT_FRONT_WINDOW_SIZE=4  # Window size
CUT_FRONT_MEAN_QUALITY=20  # Quality threshold
QC_DIR=/data/users/bnezar/assembly_annotation_course/read_QC/fastp

# For single-end data with cut_front
fastp -i $ANZIN/ERR11437354.fastq.gz -o $ANZOUT/ERR11437354_fp.fastq.gz -Q \
      --cut_front --cut_front_window_size $CUT_FRONT_WINDOW_SIZE \
      --cut_front_mean_quality $CUT_FRONT_MEAN_QUALITY \
      --html $QC_DIR/ERR11437354_fastp_info.html

# For paired-end data with cut_front
fastp -i $SHAIN/ERR754081_1.fastq.gz -I $SHAIN/ERR754081_2.fastq.gz \
      -o $SHAOUT/ERR754081_1_fp.fastq.gz -O $SHAOUT/ERR754081_2_fp.fastq.gz \
      --cut_front --cut_front_window_size $CUT_FRONT_WINDOW_SIZE \
      --cut_front_mean_quality $CUT_FRONT_MEAN_QUALITY \
      --html $QC_DIR/ERR754081_fastp_info.html