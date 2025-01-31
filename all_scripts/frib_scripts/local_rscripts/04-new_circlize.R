# Load the circlize package
library(circlize)
library(tidyverse)
library(ComplexHeatmap)

# Load the TE annotation GFF3 file
gff_file <- "assembly.fasta.mod.EDTA.TEanno.gff3"
gff_data <- read.table(gff_file, header = FALSE, sep = "\t", stringsAsFactors = FALSE)

# Check the superfamilies present in the GFF3 file, and their counts
gff_data$V3 %>% table()

# Filter the GFF3 data to select one Superfamily (You need one track per Superfamily)

# custom ideogram data
## To make the ideogram data, you need to know the lengths of the scaffolds. 
## There is an index file that has the lengths of the scaffolds, the `.fai` file. 
## To generate this file you need to run the following command in bash:
## samtools faidx assembly.fasta
## This will generate a file named assembly.fasta.fai
## You can then read this file in R and prepare the custom ideogram data

custom_ideogram <- read.table("assembly.fasta.fai", header = FALSE, stringsAsFactors = FALSE)
custom_ideogram$chr=custom_ideogram$V1
custom_ideogram$start=1
custom_ideogram$end=custom_ideogram$V2
custom_ideogram=custom_ideogram[,c("chr","start","end")]
custom_ideogram =custom_ideogram[order(custom_ideogram$end,decreasing=T),]
sum(custom_ideogram$end[1:20])

custom_ideogram$chr <- paste0("chr-", custom_ideogram$chr)
gff_data$V1 <- paste0("chr-", gff_data$V1)

# Select only the first 20 longest scaffolds, You can reduce this number if you have longer chromosome scale scaffolds
custom_ideogram=custom_ideogram[1:20,]

#custom_ideogram <- na.omit(custom_ideogram)

# Function to filter GFF3 data based on Superfamily (You need one track per Superfamily)
filter_superfamily <- function(gff_data, superfamily, custom_ideogram) {
  filtered_data <- gff_data[gff_data$V3 == superfamily, ] %>%
    as.data.frame() %>%
    mutate(chrom = V1, start = V4, end = V5, strand = V6) %>%
    select(chrom, start, end, strand) %>%
    filter(chrom %in% custom_ideogram$chr)
  return(filtered_data)
}


# Now plot all your most abundant TE superfamilies in one plot


# Plot the distribution of Athila and CRM clades (known centromeric TEs in Brassicaceae).
# 
file <- "Gypsy_sequences.fa.rexdb-plant.cls.tsv"
athila_crm_data <- read.delim(file, header = TRUE, sep = "\t", stringsAsFactors = FALSE)
athila_crm_data$X.TE <- sub("#.*", "", athila_crm_data$X.TE)
athila_data <- athila_crm_data[athila_crm_data$Clade == "Athila",]
crm_data <- athila_crm_data[athila_crm_data$Clade == "CRM",]


# Separate last column of gff
gff_data_split <- separate(gff_data, V9, into = c("ID", "Name", "classification", "sequence_ontology", "identity", "method"), sep = ";")

gff_data_split$Name <- sub("Name=", "", gff_data_split$Name)



library(dplyr)

# Extract names from athila_names
names_to_filter <- athila_data$X.TE

# Filter the gff_data DataFrame based on these names
athila_gff <- gff_data_split %>% filter(Name %in% names_to_filter)

athila_gff_slim <- athila_gff[c(1,4,5,7)]


# Extract names from athila_names
names_to_filter <- crm_data$X.TE

# Filter the gff_data DataFrame based on these names
crm_gff <- gff_data_split %>% filter(Name %in% names_to_filter)
crm_gff_slim <- crm_gff[c(1,4,5,7)]




pdf("02-TE_full_density.pdf", width = 10, height = 10)
gaps <- c(rep(1, length(custom_ideogram$chr) - 1), 5) # Add a gap between scaffolds, more gap for the last scaffold
circos.par(start.degree = 90, gap.after = 1, track.margin = c(0,0),gap.degree = gaps)
# Initialize the circos plot with the custom ideogram
circos.genomicInitialize(custom_ideogram)

# Plot te density
circos.genomicDensity(filter_superfamily(gff_data, "Gypsy_LTR_retrotransposon", custom_ideogram), count_by="number", col = "darkgreen", track.height = 0.07, window.size = 1e5)
circos.genomicDensity(filter_superfamily(gff_data, "Copia_LTR_retrotransposon", custom_ideogram), count_by="number", col = "darkred", track.height = 0.07, window.size = 1e5)
circos.genomicDensity(filter_superfamily(gff_data, "Mutator_TIR_transposon", custom_ideogram), count_by="number", col = "blue", track.height = 0.07, window.size = 1e5)
circos.genomicDensity(filter_superfamily(gff_data, "long_terminal_repeat", custom_ideogram), count_by="number", col = "gray", track.height = 0.07, window.size = 1e5)
circos.genomicDensity(athila_gff_slim, count_by="number", col = "purple", track.height = 0.07, window.size = 1e5)
circos.genomicDensity(crm_gff_slim, count_by="number", col = "lightblue", track.height = 0.07, window.size = 1e5)
circos.clear()

lgd=Legend(title = "Superfamily",  at = c("Gypsy_LTR_retrotransposon", "Copia_LTR_retrotransposon", "Mutator_TIR_transposon", 
                                          "long_terminal_repeat", "Athila", "CRM"), 
           legend_gp = gpar(fill = c("darkgreen", "darkred", "blue", "gray", "purple", "lightblue")))
draw(lgd, x = unit(8, "cm"), y = unit(10, "cm"), just = c("center"))

dev.off()




# Step 3: Create a frequency table and convert to data frame
superfamily_counts <- as.data.frame(table(gff_data$V3))

# Step 4: Rename columns for better readability
colnames(superfamily_counts) <- c("Superfamily", "Count")

# Step 5: Create the bar plot with ggplot2
ggplot(superfamily_counts, aes(x = Superfamily, y = Count, fill = Superfamily)) +
  geom_bar(stat = "identity") +
  theme_minimal() +
  labs(title = "Abundance of Superfamilies",
       x = "Superfamilies",
       y = "Counts") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1, size = 8),  # Adjust angle and size
        legend.position = "none") +  # Remove legend if not needed
  scale_fill_brewer(palette = "Set3")  # Choose a color palette



superfamily_counts <- table(gff_data$V3)

# Step 4: Create a bar plot
barplot(superfamily_counts,
        main = "Abundance of Superfamilies",
        xlab = "Superfamilies",
        ylab = "Counts",
        las = 2,                # Makes the x-axis labels vertical
        col = "lightblue",
        border = "blue")
