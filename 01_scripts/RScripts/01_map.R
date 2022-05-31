# set working directory
setwd("~/Desktop/LU/0001_Lectures/007_Research_project/03_Spring_project/00_Plotting_new/04_Map")
rm(list = ls())

# load packages
library(ggplot2)
library(sf)
library(rgeos)
library(rnaturalearth)
library(rnaturalearthdata)

## Load list of countries
world <- ne_countries(scale = 50, returnclass = "sf")
world_points <- st_centroid(world)

## Prepare data
sites <- data.frame(latitude = c(56.2724, 56.3011, 56.2724, 56.2724,
                                 56.3357, 56.2724, 56.2724, 56.2724,
                                 56.3988, 56.2923, 56.2923, 56.2923,
                                 56.2927, 56.2737, 56.2923, 56.3310,
                                 56.3023, 56.2356, 56.2356, 56.2356,
                                 56.2356, 56.2356, 56.3052, 56.3052,
                                 56.3052, 56.3052, 56.3118, 56.3131,
                                 56.3052, 56.3052, 56.3307 ),
                    longitude = c(-4.1960, -4.4542, -4.1960, -4.1960,
                                  -3.4442, -4.1960, -4.1960, -4.1960,
                                  -4.6363, -4.4452, -4.4452, -4.4452,
                                  -4.4448, -4.1940, -4.4452, -3.3745,
                                  -4.1319, -4.3811, -4.3811, -4.3811,
                                  -4.3811, -4.3811, -4.4610, -4.4610,
                                  -4.4610, -4.4610, -4.4425, -4.0939,
                                  -4.4610, -4.4610, -3.3743),
                    site = c("CH", "CH", "CH", "CH", "CH",
                             "CH", "CH", "CH", "CH", "CH",
                             "CH", "CH", "CH", "CH", "CH", "CH",
                             "CP", "CP", "CP", "CP", "CP",
                             "CP", "CP", "CP", "CP", "CP",
                             "CP", "CP", "CP", "CP", "CP"),
                    species = c("Heteropyllum", "Heteropyllum", "Heteropyllum",
                                "Heteropyllum", "Heteropyllum", "Heteropyllum",
                                "Heteropyllum", "Heteropyllum", "Heteropyllum",
                                "Heteropyllum", "Heteropyllum", "Heteropyllum",
                                "Heteropyllum", "Heteropyllum", "Heteropyllum",
                                "Heteropyllum",
                                "Palustre", "Palustre", "Palustre",
                                "Palustre", "Palustre", "Palustre",
                                "Palustre", "Palustre", "Palustre",
                                "Palustre", "Palustre", "Palustre",
                                "Palustre", "Palustre", "Palustre"))

##Map
ggplot(data = world) +
  geom_sf(fill="lightgrey", color="antiquewhite3") +
  geom_point(data = sites,
             aes(x = longitude, y = latitude,
                 color = site, shape = species),
             size = 3, alpha = 0.7) + #Add datapoints
  coord_sf(xlim = c(-10, 2),
           ylim = c(52, 59), expand = TRUE) + # Limit map
  scale_color_manual(values = c("#8A2BE2", "#3D9140")) +
  theme(panel.background = element_rect(fill = "aliceblue"),
        panel.grid = element_blank(),
        axis.title.x=element_blank(),
        axis.title.y=element_blank(),
        legend.position = "none") +
  theme(axis.text.x = element_text(size = 14, face = "bold", color = "black"),
        axis.text.y = element_text(size = 14, face = "bold", color = "black"))
