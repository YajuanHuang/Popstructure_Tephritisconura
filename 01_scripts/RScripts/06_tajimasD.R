setwd("~/Desktop/LU/0001_Lectures/007_Research_project/03_Spring_project/00_Plotting_new/11_tajima_vcftools")
rm(list = ls())

# load package
library(ggplot2)

# read files
TajimasD_SCH <- read.table("00_Data/03_SCH80_1e6_vcftools_win5kb_fstOutliers.Tajima.D",
                           sep = "\t", header=F, fill = TRUE, stringsAsFactors=F)
TajimasD_SCP <- read.table("00_Data/04_SCP80_1e6_vcftools_win5kb_fstOutliers.Tajima.D",
                           sep = "\t", header=T, fill = TRUE,
                           stringsAsFactors=F)
# add name of each row
names(TajimasD_SCH) <- c("Chr", "startPos", "nSites", "Tajima")
names(TajimasD_SCP) <- c("Chr", "startPos", "nSites", "Tajima")

# Add a column of pop
TajimasD_SCH$pop <- "SCH"
TajimasD_SCP$pop <- "SCP"

# merge SCH and SCP file
TajimasD_SCH_and_SCP <- rbind(TajimasD_SCH, TajimasD_SCP)

# density plot
ggplot(TajimasD_SCH_and_SCP, aes(Tajima, color = pop, fill = pop)) +
  geom_density(alpha = 0.5) +
# set line color
  scale_color_manual(values = c("#8A2BE2", "#2E8B57")) +
# set fill color
  scale_fill_manual( values = c("#8A2BE2", "#2E8B57")) +
  xlab("Tajima's D") +
  ylab("Density") +
  theme_bw() +
  scale_x_continuous(limits = c(-2, 3.2)) +
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
