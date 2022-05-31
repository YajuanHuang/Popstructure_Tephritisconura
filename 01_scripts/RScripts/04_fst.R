setwd("~/Desktop/LU/0001_Lectures/007_Research_project/03_Spring_project/00_Plotting_new/07_Fst")
rm(list=ls())

# load packages
library(ggplot2)
library(tidyverse)

# read file
Fstfile <- read.table("00_Plot_Data/01_SCH_SCP_win5kb_fst_plot.txt", header=F, stringsAsFactors=F)
# add name of each row
names(Fstfile) = c('CHR','POS','FST')
# number each fst value with SNP
Fstfile$SNP <- seq(1, nrow(Fstfile), 1)
# set the CHR as factor and calculate it's level
Fstfile$CHR <- factor(Fstfile$CHR, levels = unique(Fstfile$CHR))
chr <- aggregate(Fstfile$SNP, by = list(Fstfile$CHR), FUN = median)

# sort the file according to the FST value, to get the highlight FST value
Fstfile = Fstfile[order(Fstfile$FST, decreasing = T),]

### prepare the highlight data
Fstfile$is_highlight[Fstfile$FST >=
                       Fstfile$FST[round(nrow(Fstfile)*0.0002)]] <- "yes"
Fstfile$is_highlight[Fstfile$FST <
                       Fstfile$FST[round(nrow(Fstfile)*0.0002)]] <- "no"


#ggplot2 ploting
#set 0.02% as highlight line
ggplot(Fstfile, aes(SNP, FST)) +
  # 0.02% highlight line
  geom_hline(yintercept = Fstfile$FST[nrow(Fstfile) * 0.0002],
             color = "#F39B7FB2", size = 1) +
  geom_point(show.legend = FALSE, alpha = 0.5) +
  scale_x_continuous(breaks = chr$x, labels = chr$Group.1,
                     expand = c(0, 0)) +
  scale_y_continuous(labels = as.character(seq(0, 0.4, 0.1)),
                     expand = c(0, 0), limits = c(0, 0.4)) +
  # add x-title and y-title
  labs(x = 'Contig', y = 'Fst') +
  # add the title
  ggtitle("Fst between Scottish populations") +
  # remove background color
  theme_bw() +
  # adjust the position of the title
  # remove the grid lines, change the labels to dark
  theme(plot.title = element_text(hjust = 0.5, size = 18,
                                  face = "bold"),
        panel.grid = element_blank(),
        axis.line = element_line(colour = 'black')) +
  theme(axis.text.x = element_blank(),
        axis.title.x = element_text(size = 17, face = "bold"),
        axis.text.y = element_text(size = 16, face = "bold",
                                   color = "black"),
        axis.title.y = element_text(size = 17, face = "bold")) +
  # add the highlight points
  geom_point(data=subset(Fstfile, is_highlight == "yes"),
             color = "red", alpha = 0.6)
