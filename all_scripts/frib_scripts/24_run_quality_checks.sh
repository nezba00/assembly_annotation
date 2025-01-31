#! /bin/bash
#!/usr/bin/env bash

#SBATCH --time=00:05:00
#SBATCH --mem=10G
#SBATCH --cpus-per-task=5
#SBATCH --job-name=QC
#SBATCH --partition=pibu_el8
#SBATCH --output=/data/users/bnezar/assembly_annotation_course/slurm_out/output_QC_%j.out
#SBATCH --error=/data/users/bnezar/assembly_annotation_course/slurm_out/error_QC_%j.err

FINALDIR=/data/users/bnezar/assembly_annotation_course/annotation/final

module load SeqKit/2.6.1

cd $FINALDIR

# Create an output file to store all results
output_file="annotation_QC3.txt"
echo "Gene and Transcript Analysis Results" > $output_file
echo "" >> $output_file

# Count genes
echo "1. Number of genes:" >> $output_file
num_genes=$(grep -cP "\tgene\t" filtered.genes.renamed.final.gff3)
echo "Number of genes: $num_genes" >> $output_file
echo "" >> $output_file

# Count transcripts (mRNA)
echo "2. Number of mRNA transcripts:" >> $output_file
num_transcripts=$(grep -cP "\tmRNA\t" filtered.genes.renamed.final.gff3)
echo "Number of mRNA transcripts: $num_transcripts" >> $output_file
echo "" >> $output_file

# Count genes with functional annotation
echo "3. Number of genes with functional annotation:" >> $output_file
functional_genes=$(cut -f1 output.iprscan | sed 's/-R[ABF]$//' | sort | uniq | wc -l)
echo "Number of genes with functional annotation: $functional_genes" >> $output_file
echo "" >> $output_file

# Gene length statistics (Median, Max, Min)
echo "4. Gene length stats:" >> $output_file
gene_lengths=$(awk '$3 == "gene" {print $5 - $4 + 1}' filtered.genes.renamed.final.gff3)
min_gene_length=$(echo "$gene_lengths" | sort -n | head -n 1)
max_gene_length=$(echo "$gene_lengths" | sort -n | tail -n 1)
median_gene_length=$(echo "$gene_lengths" | sort -n | awk '{arr[NR] = $1} END {if (NR % 2 == 1) {print arr[(NR+1)/2]} else {print (arr[NR/2] + arr[NR/2+1])/2}}')
echo "Min gene length: $min_gene_length" >> $output_file
echo "Max gene length: $max_gene_length" >> $output_file
echo "Median gene length: $median_gene_length" >> $output_file
echo "" >> $output_file

# mRNA length statistics (Median, Max, Min)
echo "5. mRNA length stats:" >> $output_file
mrna_lengths=$(awk '$3 == "mRNA" {print $5 - $4 + 1}' filtered.genes.renamed.final.gff3)
min_mrna_length=$(echo "$mrna_lengths" | sort -n | head -n 1)
max_mrna_length=$(echo "$mrna_lengths" | sort -n | tail -n 1)
median_mrna_length=$(echo "$mrna_lengths" | sort -n | awk '{arr[NR] = $1} END {if (NR % 2 == 1) {print arr[(NR+1)/2]} else {print (arr[NR/2] + arr[NR/2+1])/2}}')
echo "Min mRNA length: $min_mrna_length" >> $output_file
echo "Max mRNA length: $max_mrna_length" >> $output_file
echo "Median mRNA length: $median_mrna_length" >> $output_file
echo "" >> $output_file

# Exon length statistics (Median, Max, Min)
echo "6. Exon length stats:" >> $output_file
exon_lengths=$(awk '$3 == "exon" {print $5 - $4 + 1}' filtered.genes.renamed.final.gff3)
min_exon_length=$(echo "$exon_lengths" | sort -n | head -n 1)
max_exon_length=$(echo "$exon_lengths" | sort -n | tail -n 1)
median_exon_length=$(echo "$exon_lengths" | sort -n | awk '{arr[NR] = $1} END {if (NR % 2 == 1) {print arr[(NR+1)/2]} else {print (arr[NR/2] + arr[NR/2+1])/2}}')
echo "Min exon length: $min_exon_length" >> $output_file
echo "Max exon length: $max_exon_length" >> $output_file
echo "Median exon length: $median_exon_length" >> $output_file
echo "" >> $output_file

# Intron length statistics (Median, Max, Min) 
echo "7. Intron length stats:" >> $output_file
intron_lengths=$(awk '$3 == "exon" {print $9"\t"$4"\t"$5}' filtered.genes.renamed.final.gff3 | sort -k1,1 -k2,2n | \
awk '{
  if ($1 == prev_parent) {
    print $2 - prev_end - 1
  }
  prev_parent = $1
  prev_end = $3
}')
intron_lengths_count=$(echo "$intron_lengths" | wc -l)
if [ "$intron_lengths_count" -gt 0 ]; then
    min_intron_length=$(echo "$intron_lengths" | sort -n | head -n 1)
    max_intron_length=$(echo "$intron_lengths" | sort -n | tail -n 1)
    median_intron_length=$(echo "$intron_lengths" | sort -n | awk '{arr[NR] = $1} END {if (NR % 2 == 1) {print arr[(NR+1)/2]} else {print (arr[NR/2] + arr[NR/2+1])/2}}')
else
    min_intron_length=0
    max_intron_length=0
    median_intron_length=0
fi
echo "Min intron length: $min_intron_length" >> $output_file
echo "Max intron length: $max_intron_length" >> $output_file
echo "Median intron length: $median_intron_length" >> $output_file
echo "" >> $output_file

# Number of monoexonic genes
echo "8. Number of monoexonic genes:" >> $output_file
num_mono_genes=$(awk '$3 == "exon" {print $9}' filtered.genes.renamed.final.gff3 | \
cut -d ';' -f1 | sed 's/Parent=//' | sort | uniq -c | \
awk '$1 == 1 {count++} END {print count}')
echo "Number of monoexonic genes: $num_mono_genes" >> $output_file
echo "" >> $output_file

# Number of exons per gene: Median, Max, Min
echo "9. Number of exons per gene:" >> $output_file
num_exons_gene=$(awk '$3 == "exon" {print $9}' filtered.genes.renamed.final.gff3 | \
cut -d ';' -f1 | sed 's/Parent=//' | sort | uniq -c | \
awk '{print $1}' | sort -n | \
awk '{all[NR]=$1} END {print "Min:", all[1], "Max:", all[NR], "Median:", (NR%2 ? all[(NR+1)/2] : (all[NR/2] + all[NR/2+1])/2)}')
echo "$num_exons_gene" >> $output_file
echo "" >> $output_file
