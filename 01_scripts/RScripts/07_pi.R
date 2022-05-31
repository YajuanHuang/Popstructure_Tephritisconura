setwd("~/Desktop/LU/0001_Lectures/007_Research_project/03_Spring_project/00_Plotting_new/10_Pi")
rm(list = ls())

# LOAD PACKAGE
library(ggplot2)

## Read files
Pi_SCH <- read.table("00_Data/01_SCH80_1e6_vcftools_win5kb.windowed.pi",
                     sep = "\t", header=T, stringsAsFactors=F)
Pi_SCP <- read.table("00_Data/02_SCP80_1e6_vcftools_win5kb.windowed.pi",
                     sep = "\t", header=T, stringsAsFactors=F)

# add a column of population
Pi_SCH$pop <- "SCH"
Pi_SCP$pop <- "SCP"

# merge two files
pi <- rbind(Pi_SCH, Pi_SCP)

# density plot
ggplot(pi, aes(PI, color = pop, fill = pop)) +
  geom_density(alpha = 0.5) +
# set line color
  scale_color_manual(values = c("#8A2BE2", "#2E8B57")) +
# set fill color
  scale_fill_manual( values = c("#8A2BE2", "#2E8B57")) +
  xlab("Pi") +
  ylab("Density") +
  theme_bw() +
  scale_x_continuous(limits = c(-0.001, 0.011)) +
# adjust the position of the title, remove the grid lines, change the labels to dark
  theme(panel.grid = element_blank(),
        axis.line = element_line(colour = "black")) +
  theme(axis.text.x = element_text(size = 12, face = "bold", colour = "black"),
        axis.title.x = element_text(size = 15, face = "bold", colour = "black"),
        axis.text.y = element_text(size = 12, face = "bold", colour = "black"),
        axis.title.y = element_text(size = 15, face = "bold", colour = "black")) +
  theme(legend.title = element_blank(),
        legend.direction = "horizontal",
        legend.position = "bottom")
