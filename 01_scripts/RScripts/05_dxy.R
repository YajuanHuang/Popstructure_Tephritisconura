setwd("~/Desktop/LU/0001_Lectures/007_Research_project/03_Spring_project/00_Plotting_new/08_Dxy")
rm(list = ls())

# load package
library(ggplot2)

## read file
dxy <- read.table("00_SCH_SCP_dxy_win5kb.dxy", sep = "\t",
                  fill = TRUE, header = F, stringsAsFactors = F)
# name each column
names(dxy) = c('chrom', 'start', 'end', 'nVariants', 'dxy')
# number each dxy value
dxy$dxy_pos <- seq(1, nrow(dxy), 1)
dxy$chrom <- factor(dxy$chrom, levels = unique(dxy$chrom))
chr <- aggregate(dxy$dxy_pos, by = list(dxy$chrom), FUN = median)


#plot
ggplot(dxy, aes(x=dxy_pos, y = dxy))+
  geom_point(col = "#6BAED6", alpha = 0.5) +
  xlab("Contigs") +
  ylab("Dxy") +
  scale_x_discrete(labels = "contigs", expand = c(0, 0)) +
  scale_y_continuous(expand = c(0, 0), limits = c(0, 0.025)) +
# remove background color
  theme_bw() +
# adjust the position of the title, remove the grid lines, change the labels to dark
  theme(plot.title = element_text(hjust = 0.5, size = 12, face = "bold"),
        panel.grid = element_blank(),
        axis.line = element_line(colour = 'black')) +
  theme(axis.text.x = element_blank(),
        axis.title.x = element_text(size = 17, face = "bold", color = "black"),
        axis.text.y = element_text(size = 16, face = "bold", color = "black"),
        axis.title.y = element_text(size = 17, face = "bold"))
