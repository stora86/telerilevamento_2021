# R_code_vegetation_indices.r


# call the library - the alternative method is require
library(raster) #require(raster)
library(RStoolbox) #for vegetation inidces calculation

# set the directory
setwd("C:/lab/")

# import the images in R
defor1 <- brick("defor1.jpg")
defor2 <- brick("defor2.jpg")

defor1

#b1 = NIR, b2 = red, b3 = green
par(mfrow=c(2,1))
plotRGB(defor1, r=1, g=2, b=3, stretch="lin")
plotRGB(defor2, r=1, g=2, b=3, stretch="lin")

#calculate the DVI - Different Vegetation Index (NIR - RED band)
dvi1 <- defor1$defor1.1 - defor1$defor1.2
#dev.off()
plot(dvi1)

# specifying a color scheme with color rampe palette
cl <- colorRampPalette(c('darkblue','yellow','red','black'))(100) 
plot(dvi1, col=cl, main="DVI at time 1")

#calculate the DVI - Different Vegetation Index (NIR - RED band) for defor2
dvi2 <- defor2$defor2.1 - defor2$defor2.2
#dev.off()
#visualize the image in R
plot(dvi2)
#visualize the image in R with the color rampe palette
plot(dvi2, col=cl, main="DVI at time 2")

#plot the image in two row and 1 column
par(mfrow=c(2,1))
plot(dvi1, col=cl, main="DVI at time 1")
plot(dvi2, col=cl, main="DVI at time 2")

#difference between the two DVI 
difdiv <- dvi1 - dvi2

# specifying a color scheme with color rampe palette
cl_dif <- colorRampPalette(c('blue','white','red'))(100)
plot(difdiv, col=cl_dif)

#NDVI - Normalized Difference Vegetation Index
# (NIR-RED) / (NIR+RED)
ndvi1 <- (defor1$defor1.1 - defor1$defor1.2) / (defor1$defor1.1 + defor1$defor1.2)
plot(ndvi1, col=cl)

#ndvi1 <- dvi1 / (defor1$defor1.1 + defor1$defor1.2)
#plot(ndvi1, col=cl)

#NDVI - Normalized Difference Vegetation Index for defor2
# (NIR-RED) / (NIR+RED)
ndvi2 <- (defor2$defor2.1 - defor2$defor2.2) / (defor2$defor2.1 + defor2$defor2.2)
plot(ndvi2, col=cl)

#ndvi2 <- dvi2 / (defor2$defor2.1 + defor2$defor2.2)
#plot(ndvi2, col=cl)

#normalised difference between the two NDVI and plot
difndvi <- ndvi1 - ndvi2
plot(difndvi, col=cl_dif)

#RStoolbox::spectralIndices
#vegetation indices, calculate all indices of spectralIndices 
vi1 <- spectralIndices(defor1, green=3, red=2, nir=1)
plot(vi1, col=cl)

#for defor2
vi2 <- spectralIndices(defor2, green=3, red=2, nir=1)
plot(vi2, col=cl)



