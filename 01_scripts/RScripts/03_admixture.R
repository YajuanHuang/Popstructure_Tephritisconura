setwd("~/Desktop/LU/0001_Lectures/007_Research_project/03_Spring_project/00_Plotting_new/06_Admix")
rm(list = ls())

# Load packages
library(ggplot2)

# Read admixture file
admixture <- data.frame(ancestors <- rep(c("anc1", "anc2"), 31),
                        individuals <- rep(c("CH185", "CH186", "CH187",
                                             "CH188","CH189", "CH190",
                                             "CH191", "CH192", "CH193",
                                             "CP194", "CP195", "CP196",
                                             "CP201", "CP202","CP203",
                                             "CH204", "CP113", "CP114",
                                             "CP115","CP116", "CP117",
                                             "CP118", "CP119", "CP120",
                                             "CP121", "CH122", "CH123",
                                             "CH124", "CH125","CH126",
                                             "CH127"), 2),
                        admix_value <- c(as.matrix(read.table("00_Data/02_scotland80_1e6_pruned_admix.2.Q"))[,1],
                                         as.matrix(read.table("00_Data/02_scotland80_1e6_pruned_admix.2.Q"))[,2]))
# name each column
colnames(admixture) <- c("ancestors","individuals", "admix_value")



ggplot(admixture, aes(x = admix_value, y = individuals, fill = ancestors)) +
  geom_bar(stat="identity", position = "fill", width = 1, ) +
  labs(x = "Admixture proportion", y = "Individuals") + # add x-title and y-title
  theme_bw() + # transparent theme
  theme(panel.grid = element_blank(), # remove the grid lines
        axis.line = element_line(colour = "black"), # change the labels to dark
        legend.position="none") + # remove legend
  theme(axis.text.x = element_text(size = 12, face = "bold", colour = "black"),
        axis.title.x = element_text(size = 15, face = "bold", colour = "black"),
        axis.text.y = element_text(size = 12, face = "bold", colour = "black"),
        axis.title.y = element_text(size = 15, face = "bold", colour = "black")) +
  scale_y_discrete (expand = c(0, 0)) +
  scale_x_continuous(expand = c(0,0))
