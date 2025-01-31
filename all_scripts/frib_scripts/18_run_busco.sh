#!/usr/bin/env bash

#SBATCH --cpus-per-task=8
#SBATCH --mem=50G
#SBATCH --time=24:00:00
#SBATCH --job-name=BuscoAnno
#SBATCH --output=/data/users/bnezar/assembly_annotation_course/slurm_out/output_BuscoAnno_%j.o
#SBATCH --error=/data/users/bnezar/assembly_annotation_course/slurm_out/error_BuscoAnno_%j.e
#SBATCH --partition=pibu_el8

WORKDIR=/data/users/bnezar/assembly_annotation_course/annotation
COURSEDIR=/data/courses/assembly-annotation-course/CDS_annotation
MAKERBIN=$COURSEDIR/softwares/Maker_v3.01.03/src/bin
FINALDIR=/data/users/bnezar/assembly_annotation_course/annotation/final
BUSCODIR=$WORKDIR/busco_results

protein="assembly.all.maker.proteins.fasta" 
transcript="assembly.all.maker.transcripts.fasta" 
gff="assembly.all.maker.noseq.gff" 


mkdir -p $BUSCODIR

mkdir -p $BUSCODIR/protein
mkdir -p $BUSCODIR/transcript


cd $FINALDIR

module load BUSCO/5.4.2-foss-2021a

# Run Busco on longest isoforms
busco -i ${protein}.renamed.longest.fasta -l brassicales_odb10 -o $BUSCODIR/protein -m proteins
busco -i ${transcript}.renamed.longest.fasta -l brassicales_odb10 -o $BUSCODIR/transcript -m transcriptome
