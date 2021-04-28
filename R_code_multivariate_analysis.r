# R_code_multivariate_analysis.r

# call the library
library(raster)
library(RStoolbox)

# set the directory
setwd("C:/lab/")

# import the all band of raster
p224r63_2011 <- brick("p224r63_2011_masked.grd")
#view detail of data
p224r63_2011
plot(p224r63_2011)
#plot the values of B1 and B2 in scatter plot
plot(p224r63_2011$B1_sre,p224r63_2011$B2_sre, col="red", pch=19, cex=2)
#bands inverted in the plot
plot(p224r63_2011$B2_sre,p224r63_2011$B1_sre, col="red", pch=19, cex=2)
#plot all correlations of the bands present in the raster in pairs 
#scatterplot matrices- - pairs function
pairs(p224r63_2011)

#aggregate pixel => resampling (ricampionamento lineare di pixel in dimensione più grande, diminuendo la risoluzione)
p224r63_2011res <- aggregate(p224r63_2011, fact=10)
p224r63_2011res

#function par to display the plot in 2x1
par(mfrow=c(2,1))
plotRGB(p224r63_2011, r=4, g=3, b=2, stretch='lin')
plotRGB(p224r63_2011res, r=4, g=3, b=2, stretch='lin')

#PCA: principal component analysis, function rasterPCA
#Calculates R-mode PCA for RasterBricks or RasterStacks and returns a RasterBrick with multiple layers of PCA scores.
#generates a new image with map e model layer
p224r63_2011res_pca <- rasterPCA(p224r63_2011res)

#function summary (fornisce il sommario della nostra img)
#la 1a componente PC1 ci spiega il 99% della variabilità
summary(p224r63_2011res_pca$model)
#plot img
plot(p224r63_2011res_pca$map)
#plot img in RGB
plotRGB(p224r63_2011res_pca$map, r=1, g=2, b=3, stretch="lin")

