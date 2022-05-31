setwd("~/Desktop/LU/0001_Lectures/007_Research_project/03_Spring_project/00_Plotting_new/05_PCA")
rm(list = ls())

# Load packages
library(tidyverse)
library(ggplot2)
library(ggrepel)

### read file
pop <- read.table("03_scotland_unsorted.bamlist") # read sample list file
C <- as.matrix(read.table("00_Data/03_scotland80_1e6_pruned.cov")) # read the data

pca <- data.frame(PC1 = e$vectors[,1], PC2 = e$vectors[,2],
                  Population = pop[,1], Individual=pop[,1])
# get the ID and pop of each individual
pca$Individual <- str_to_title(substr(pca$Individual, 5, 14))
pca$Population <- str_to_title(substr(pca$Population, 1, 3))

## plot
ggplot(pca, aes(PC1, PC2, col = Population, shape = Population)) +
  geom_point(size = 7, alpha = 0.5) +
  geom_text_repel(aes(PC1, PC2, label = pca$Individual),
                  size = 2.8, direction = "both",
                  min.segment.length = 0.05, segment.alpha = 0.8,
                  label.padding = 1, max.overlaps = 50) +
  scale_color_manual(values = c("#8A2BE2", "#2E8B57")) + # set different color of each pop
  theme_bw() + # set transparent theme
  theme(legend.title = element_blank(),
        legend.position = "bottom",
        panel.grid = element_blank(),
        axis.text.x = element_text(size = 14, face = "bold", color = "black"),
        axis.title.x = element_text(size = 18, face = "bold"),
        axis.text.y = element_text(size = 14, face = "bold", color = "black"),
        axis.title.y = element_text(size = 18, face = "bold"),
        legend.text = element_text(colour = 'black', size = 13, face = 'bold'))
