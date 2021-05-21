# R_code_variability.r

# call the library 
library(raster)
library(RStoolbox)
#install.packages("RStoolbox")
library(ggplot2) #for ggplot
library(gridExtra) #for plotting ggplots together
#install.packages("viridis")
library(viridis) #for ggplot colouring


# set the directory
setwd("C:/lab/")

#import the image in R with the all band through the function brick
sent <- brick("sentinel.png")

#NIR 1, RED 2, GREEN 3
#r=1, g=2, b=3
plotRGB(sent, stretch="lin") #plotRGB(sent, r=1, g=2, b=3)

#invert color band
plotRGB(sent, r=2, g=1, b=3, stretch="lin")

#set the band of the sentinel image to calculate the ndvi
nir <- sent$sentinel.1
red <- sent$sentinel.2

# calculate ndvi
ndvi <- (nir - red) / (nir + red)
plot(ndvi)

#set the color ramp palette and plot 
cl <- colorRampPalette(c("black", "white", "red", "magenta", "green"))(100)
plot(ndvi, col=cl)

#focal analysis for moving window
#ndvi standard deviation
ndvisd3 <- focal(ndvi, w=matrix(1/9, nrow=3, ncol=3), fun=sd)
plot(ndvisd3)

#set the colors
clsd <- colorRampPalette(c('blue','green','pink','magenta','orange','brown','red','yellow'))(100)
plot(ndvisd3, col=clsd)

#mean ndvi with focal
ndvimean3 <- focal(ndvi, w=matrix(1/9, nrow=3, ncol=3), fun=mean)
clmean <- colorRampPalette(c('blue','green','pink','magenta','orange','brown','red','yellow'))(100) # 
plot(ndvimean3, col=clmean)

#focal ndvi standard deviation
ndvisd13 <- focal(ndvi, w=matrix(1/169, nrow=13, ncol=13), fun=sd)
clsd <- colorRampPalette(c('blue','green','pink','magenta','orange','brown','red','yellow'))(100)
plot(ndvisd13, col=clsd)

#changing window size
ndvisd5 <- focal(ndvi, w=matrix(1/25, nrow=5, ncol=5), fun=sd)
clsd <- colorRampPalette(c('blue','green','pink','magenta','orange','brown','red','yellow'))(100)
plot(ndvisd5, col=clsd)

#PCA (principal component analysis)
# calculate the PCA and then use the principal PC1 (RStoolbox)
sentpca <- rasterPCA(sent)
#plot the the layer map of the PC of the data
plot(sentpca$map)
sentpca

#see the Proportion of Variance of the original information of PC1 (component 1)
summary(sentpca$model)
# the first PC contains 67,36804% of the original information

# Moving window on PC1 
#definition of the PC1 map in variable
pc1 <- sentpca$map$PC1
#function focal to calculate standard deviation and set the color ramp palette
sd_pc1 <- focal(pc1, w=matrix(1/25, nrow=5, ncol=5), fun=sd)
clpc1 <- colorRampPalette(c('blue','green','pink','magenta','orange','brown','red','yellow'))(100)
plot(sd_pc1, col=clpc1)

#function focal to calculate standard deviation and set the color ramp palette
#sd7_pc1 <- focal(pc1, w=matrix(1/49, nrow=7, ncol=7), fun=sd)
#clpc1 <- colorRampPalette(c('blue','green','pink','magenta','orange','brown','red','yellow'))(100)
#plot(sd7_pc1, col=clpc1)

# with the source fucntion you can upload code from outside!
# source_test_lezione.r 
source("source_test_lezione.r")
source("source_ggplot.r")

#ggplot function to display the chart
#scale fill viridis use the default scale of viridis
p1 <- ggplot()+ geom_raster(sd_pc1, mapping = aes(x = x, y = y, fill = layer)) +
scale_fill_viridis() + ggtitle("Standard deviation of PC1 by viridis colour scale")

#ggplot with magma scale of viridis package
p2 <- ggplot()+ geom_raster(sd_pc1, mapping = aes(x = x, y = y, fill = layer)) +
  scale_fill_viridis(option = "magma") + ggtitle("Standard deviation of PC1 by magma colour scale")

#ggplot with inferno scale of viridis package
ggplot()+ geom_raster(sd_pc1, mapping = aes(x = x, y = y, fill = layer)) +
  scale_fill_viridis(option = "inferno") + ggtitle("Standard deviation of PC1 by inferno colour scale")

#ggplot with turbo scale of viridis package
p3 <- ggplot()+ geom_raster(sd_pc1, mapping = aes(x = x, y = y, fill = layer)) +
  scale_fill_viridis(option = "turbo") + ggtitle("Standard deviation of PC1 by turbo colour scale")

#arranging multiple plot on the page
grid.arrange(p1,p2,p3,nrow = 3)








