### Clade abundances in Copia or Gypsy
# Load the TE annotation GFF3 file
gff_file <- "assembly.fasta.mod.EDTA.TEanno.gff3"
gff_data <- read.table(gff_file, header = FALSE, sep = "\t", stringsAsFactors = FALSE)



# Plot the distribution of Athila and CRM clades (known centromeric TEs in Brassicaceae).
# 
gypsy_file <- "Gypsy_sequences.fa.rexdb-plant.cls.tsv"
copia_file <- "Copia_sequences.fa.rexdb-plant.cls.tsv"

gypsy_data <- read.delim(gypsy_file, header = TRUE, sep = "\t", stringsAsFactors = FALSE)
copia_data <- read.delim(copia_file, header = TRUE, sep = "\t", stringsAsFactors = FALSE)


gypsy_data$X.TE <- sub("#.*", "", gypsy_data$X.TE)
copia_data$X.TE <- sub("#.*", "", copia_data$X.TE)
colnames(gypsy_data)[1] <- "Name"
colnames(copia_data)[1] <- "Name"

# Separate last column of gff
gff_data_split <- separate(gff_data, V9, into = c("ID", "Name", "classification", "sequence_ontology", "identity", "method"), sep = ";")
gff_data_split$Name <- sub("Name=", "", gff_data_split$Name)



library(dplyr)

# Extract names from athila_names
gypsy_names_to_filter <- gypsy_data$Name
copia_names_to_filter <- copia_data$Name

# Filter the gff_data DataFrame based on these names
gypsy_gff <- gff_data_split %>% filter(Name %in% gypsy_names_to_filter)
copia_gff <- gff_data_split %>% filter(Name %in% copia_names_to_filter)

merged_df_gypsy <- merge(gypsy_gff)

merged_df_gypsy <- gypsy_gff %>%
  left_join(gypsy_data, by = c("Name" = "Name"))

merged_df_copia <- copia_gff %>%
  left_join(copia_data, by = c("Name" = "Name"))



# Step 4: View the Result
print(merged_df_gypsy)


gypsy_clade_counts <- as.data.frame(table(merged_df_gypsy$Clade))
copia_clade_counts <- as.data.frame(table(merged_df_copia$Clade))

colnames(gypsy_clade_counts) <- c("Clade", "Count")
colnames(copia_clade_counts) <- c("Clade", "Count")

# Step 5: Create the bar plot with ggplot2
ggplot(gypsy_clade_counts, aes(x = Clade, y = Count, fill = Clade)) +
  geom_bar(stat = "identity") +
  theme_minimal() +
  labs(title = "Abundance of Gypsy Superfamilies",
       x = "Superfamilies",
       y = "Counts") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1, size = 8),  # Adjust angle and size
        legend.position = "none") +  # Remove legend if not needed
  scale_fill_brewer(palette = "Set3")  # Choose a color palette

ggplot(copia_clade_counts, aes(x = Clade, y = Count, fill = Clade)) +
  geom_bar(stat = "identity") +
  theme_minimal() +
  labs(title = "Abundance of Copia Superfamilies",
       x = "Superfamilies",
       y = "Counts") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1, size = 8),  # Adjust angle and size
        legend.position = "none") +  # Remove legend if not needed
  scale_fill_brewer(palette = "Set3")  # Choose a color palette
