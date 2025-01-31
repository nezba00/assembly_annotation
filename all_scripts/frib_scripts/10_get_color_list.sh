#!/usr/bin/env bash

#SBATCH --cpus-per-task=8
#SBATCH --mem=50G
#SBATCH --time=2:00:00
#SBATCH --job-name=get_colors
#SBATCH --output=/data/users/bnezar/assembly_annotation_course/slurm_out/output_colors2_%j.o
#SBATCH --error=/data/users/bnezar/assembly_annotation_course/slurm_out/error_colors2_%j.e
#SBATCH --partition=pibu_el8

TE_DIR=/data/users/bnezar/assembly_annotation_course/annotation/TEsorter_out
OUTDIR1=/data/users/bnezar/assembly_annotation_course/annotation/phylogenetic_analysis3/gypsy_colors2
OUTDIR2=/data/users/bnezar/assembly_annotation_course/annotation/phylogenetic_analysis3/copia_colors2

GYPSY=/data/users/bnezar/assembly_annotation_course/annotation/phylogenetic_analysis3/Gypsy_Brassicaceae.fa.rexdb-plant.cls.tsv
COPIA=/data/users/bnezar/assembly_annotation_course/annotation/phylogenetic_analysis3/Copia_Brassicaceae.fa.rexdb-plant.cls.tsv
GYPSY_OWN=$TE_DIR/Gypsy_sequences.fa.rexdb-plant.cls.tsv
COPIA_OWN=$TE_DIR/Copia_sequences.fa.rexdb-plant.cls.tsv



mkdir -p $OUTDIR1
mkdir -p $OUTDIR2


cd $OUTDIR1

# Gypsy clades
#    Athila
#    CRM
#    Galadriel
#    Reina
#    Retand
#    Tekay
#    unknown

# Create separate files for each clade from brassicaceae with and append a color
grep -e "Retand" $GYPSY | cut -f 1 | sed 's/:/_/' | sed 's/#.*//' | sed 's/$/ #FF0000 Retand/' > Retand_ID.txt 
grep -e "Athila" $GYPSY | cut -f 1 | sed 's/:/_/' | sed 's/#.*//' | sed 's/$/ #00FF00 Athila/' > Athila_ID.txt 
grep -e "CRM" $GYPSY | cut -f 1 | sed 's/:/_/' | sed 's/#.*//' | sed 's/$/ #0000FF CRM/' > CRM_ID.txt 
grep -e "Reina" $GYPSY | cut -f 1 | sed 's/:/_/' | sed 's/#.*//' | sed 's/$/ #FFA500 Reina/' > Reina_ID.txt 
grep -e "Tekay" $GYPSY | cut -f 1 | sed 's/:/_/' | sed 's/#.*//' | sed 's/$/ #800080 Tekay/' > Tekay_ID.txt 
grep -e "Galadriel" $GYPSY | cut -f 1 | sed 's/:/_/' | sed 's/#.*//' | sed 's/$/ #008080 Galadriel/' > Galadriel_ID.txt 
grep -e "unknown" $GYPSY | cut -f 1 | sed 's/:/_/' | sed 's/#.*//' | sed 's/$/ #808080 unknown/' > unknown_ID.txt 

# Append entries for own annotations
grep -e "Retand" $GYPSY_OWN | cut -f 1 | sed 's/:/_/' | sed 's/#.*//' | sed 's/$/ #FF0000 Retand/' >> Retand_ID.txt 
grep -e "Athila" $GYPSY_OWN | cut -f 1 | sed 's/:/_/' | sed 's/#.*//' | sed 's/$/ #00FF00 Athila/' >> Athila_ID.txt 
grep -e "CRM" $GYPSY_OWN | cut -f 1 | sed 's/:/_/' | sed 's/#.*//' | sed 's/$/ #0000FF CRM/' >> CRM_ID.txt 
grep -e "Reina" $GYPSY_OWN | cut -f 1 | sed 's/:/_/' | sed 's/#.*//' | sed 's/$/ #FFA500 Reina/' >> Reina_ID.txt 
grep -e "Tekay" $GYPSY_OWN | cut -f 1 | sed 's/:/_/' | sed 's/#.*//' | sed 's/$/ #800080 Tekay/' >> Tekay_ID.txt 
grep -e "Galadriel" $GYPSY_OWN | cut -f 1 | sed 's/:/_/' | sed 's/#.*//' | sed 's/$/ #008080 Galadriel/' >> Galadriel_ID.txt 
grep -e "unknown" $GYPSY_OWN | cut -f 1 | sed 's/:/_/' | sed 's/#.*//' | sed 's/$/ #808080 unknown/' >> unknown_ID.txt 


cd $OUTDIR2

# COPIA clades
#    Ale
#    Alesia
#    Angela
#    Bianca
#    Ikeros
#    Ivana
#    SIRE
#    TAR
#    Tork

# Same as above for Copia
grep -e "Ale" $COPIA | cut -f 1 | sed 's/:/_/' | sed 's/#.*//' | sed 's/$/ #FF6347 Ale/' > Ale_ID.txt 
grep -e "Alesia" $COPIA | cut -f 1 | sed 's/:/_/' | sed 's/#.*//' | sed 's/$/ #00FF00 Alesia/' > Alesia_ID.txt 
grep -e "Angela" $COPIA | cut -f 1 | sed 's/:/_/' | sed 's/#.*//' | sed 's/$/ #0000FF Angela/' > Angela_ID.txt 
grep -e "Bianca" $COPIA | cut -f 1 | sed 's/:/_/' | sed 's/#.*//' | sed 's/$/ #FFA500 Bianca/' > Bianca_ID.txt 
grep -e "Ikeros" $COPIA | cut -f 1 | sed 's/:/_/' | sed 's/#.*//' | sed 's/$/ #800080 Ikeros/' > Ikeros_ID.txt 
grep -e "Ivana" $COPIA | cut -f 1 | sed 's/:/_/' | sed 's/#.*//' | sed 's/$/ #808080 Ivana/' > Ivana_ID.txt 
grep -e "SIRE" $COPIA | cut -f 1 | sed 's/:/_/' | sed 's/#.*//' | sed 's/$/ #FFD700 SIRE/' > SIRE_ID.txt 
grep -e "TAR" $COPIA | cut -f 1 | sed 's/:/_/' | sed 's/#.*//' | sed 's/$/ #00CED1 TAR/' > TAR_ID.txt 
grep -e "Tork" $COPIA | cut -f 1 | sed 's/:/_/' | sed 's/#.*//' | sed 's/$/ #FF1493 Tork/' > Tork_ID.txt

grep -e "Ale" $COPIA_OWN | cut -f 1 | sed 's/:/_/' | sed 's/#.*//' | sed 's/$/ #FF6347 Ale/' >> Ale_ID.txt 
grep -e "Alesia" $COPIA_OWN | cut -f 1 | sed 's/:/_/' | sed 's/#.*//' | sed 's/$/ #00FF00 Alesia/' >> Alesia_ID.txt 
grep -e "Angela" $COPIA_OWN | cut -f 1 | sed 's/:/_/' | sed 's/#.*//' | sed 's/$/ #0000FF Angela/' >> Angela_ID.txt 
grep -e "Bianca" $COPIA_OWN | cut -f 1 | sed 's/:/_/' | sed 's/#.*//' | sed 's/$/ #FFA500 Bianca/' >> Bianca_ID.txt 
grep -e "Ikeros" $COPIA_OWN | cut -f 1 | sed 's/:/_/' | sed 's/#.*//' | sed 's/$/ #800080 Ikeros/' >> Ikeros_ID.txt 
grep -e "Ivana" $COPIA_OWN | cut -f 1 | sed 's/:/_/' | sed 's/#.*//' | sed 's/$/ #808080 Ivana/' >> Ivana_ID.txt 
grep -e "SIRE" $COPIA_OWN | cut -f 1 | sed 's/:/_/' | sed 's/#.*//' | sed 's/$/ #FFD700 SIRE/' >> SIRE_ID.txt 
grep -e "TAR" $COPIA_OWN | cut -f 1 | sed 's/:/_/' | sed 's/#.*//' | sed 's/$/ #00CED1 TAR/' >> TAR_ID.txt 
grep -e "Tork" $COPIA_OWN | cut -f 1 | sed 's/:/_/' | sed 's/#.*//' | sed 's/$/ #FF1493 Tork/' >> Tork_ID.txt
