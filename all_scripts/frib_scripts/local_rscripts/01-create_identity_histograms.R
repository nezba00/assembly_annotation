install.packages("ggplot2")
library(ggplot2)


data <- read.table('final_output.txt', fill = T)
colnames(data) <- c("name", "identity", "superfamily", "clade")


data$superfamily <- substr(data$superfamily, 5, nchar(data$superfamily))


gypsy_data <- data[data$superfamily == "Gypsy",]
copia_data <- data[data$superfamily == "Copia",]
unknown_data <- data[data$superfamily == "unknown",]


hist(gypsy_data$identity, main = "Gypsy Identity", xlab = "Identity", ylim = c(0,60), xlim = c(0.9, 1))
hist(copia_data$identity, main = "Copia Identity", xlab = "Identity", ylim = c(0,60), xlim = c(0.9, 1))
hist(unknown_data$identity, xlim = c(0.7, 1))


ggplot(data, aes(x = identity)) +
  geom_histogram(binwidth = 0.01, fill = "blue", color = "black") +
  facet_wrap(~ clade) +
  theme_minimal() +
  labs(title = "Histograms of Scores by Clade", x = "Score", y = "Count") +
  xlim(0.5, 1)



