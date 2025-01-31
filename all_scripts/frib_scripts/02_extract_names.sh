#!/usr/bin/env bash

#SBATCH --cpus-per-task=8
#SBATCH --mem=50G
#SBATCH --time=2:00:00
#SBATCH --job-name=Get_Names
#SBATCH --output=/data/users/bnezar/assembly_annotation_course/slurm_out/get_names_%j.o
#SBATCH --error=/data/users/bnezar/assembly_annotation_course/slurm_out/get_names_%j.e
#SBATCH --partition=pibu_el8


WORKDIR=/data/users/bnezar/assembly_annotation_course
EDTADIR=/data/courses/assembly-annotation-course/CDS_annotation/example_EDTA_data/edta_annotation
OUTDIR=$WORKDIR/assembly_qc/EDTA_annotation_conda_lja/extract_infos
mkdir -p $OUTDIR

cd $OUTDIR 

# Extract name, identity and classification from EDTA output
awk -F';' '/ltr_identity/ { 
    name=""; identity=""; classification="";
    for (i=1; i<=NF; i++) {
        if ($i ~ /Name=/) name=substr($i, index($i, "=")+1);
        if ($i ~ /ltr_identity=/) identity=substr($i, index($i, "=")+1);
        if ($i ~ /Classification=/) classification=substr($i, index($i, "=")+1);
    }
    print name, identity, classification
}' $EDTADIR/assembly.fasta.mod.EDTA.raw/assembly.fasta.mod.LTR.intact.gff3 > ltr_identity_output.txt

# Also create table with unique entries
sort ltr_identity_output.txt | uniq > unique_ltr_identity.txt
