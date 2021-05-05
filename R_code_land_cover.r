# R_code_land_cover.r

#call library
library(raster)
library(RStoolbox)
#install.packages("ggplot2")
library(ggplot2)
#installed.packages("gridExtra")
library(gridExtra)

# set the directory
setwd("C:/lab/")

#NIR 1, RED 2, GREEN 3

#import the image and plot in RGB
defor1 <- brick("defor1.jpg")
plotRGB(defor1, r=1, g=2, b=3, stretch="lin")
#plot with the packages ggplot
ggRGB(defor1, r=1, g=2, b=3, stretch="lin")

#import defor2
defor2 <- brick("defor2.jpg")
plotRGB(defor2, r=1, g=2, b=3, stretch="lin")
ggRGB(defor2, r=1, g=2, b=3, stretch="lin")

#plot in column
par(mfrow=c(1,2))
plotRGB(defor1, r=1, g=2, b=3, stretch="lin")
plotRGB(defor2, r=1, g=2, b=3, stretch="lin")

#multiframe with ggplot2 and gridExtra for plot in column
p1 <- ggRGB(defor1, r=1, g=2, b=3, stretch="lin")
p2 <- ggRGB(defor2, r=1, g=2, b=3, stretch="lin")
grid.arrange(p1, p2, nrow=2) #of the packages ggplot2
