# R_code_complete - Telerilevamento Geo_Ecologico

#---------------------------------------------------

#Summary:

# 1. Remote sensing first code
# 2. R code Time series
# 3. R code Copernicus data
# 4. R code knitr
# 5. R code Multivariate analysis
# 6. R code Classification
# 7. R code ggplot2
# 8. R code vegetation indices
# 9. R code Land cover
#10. R code Variability
#11. R code Spectral signatures


#--------------------------------------------------

#1. Remote sensing first code

# My first code in R for remote sensing!
#set directory Windows
setwd("C:/lab/") 

#funzione che installa i pacchetti R, il pacchetto raster è già installato
#install.packages("raster") 
#richiamare il pacchetto raster per usare le funzioni che contiene
library(raster)
#funzione che consente di importare tutte insieme le bande del dato satellitare raster 
p224r63_2011mk <- brick("p224r63_2011_masked.grd")
p224r63_2011mk #richiamare il file per avere le informazioni
#plotta tutte le bande contenute nel file p224r63_2011mk
plot(p224r63_2011mk)

## day2

#color change
cl <- colorRampPalette(c("black", "grey", "light grey")) (100)
# plotto il raster con i colori definiti in precedenza con "col"
plot(p224r63_2011mk, col=cl)
#color change new
cl <- colorRampPalette(c("red", "blue", "light grey", "yellow", "green")) (100)
plot(p224r63_2011mk, col=cl)

## day3

# Bande Landsat
# B1: blu
# B2: verde
# B3: rosso
# B4: infrarosso vicino
# B5: infrarosso medio
# B6: infrarosso termico
# B7: ifrarosso medio

# dev.off will clean the current graph
dev.off()
# il $ specifica che banda plottare tra tutte
plot(p224r63_2011mk$B1_sre)
#plot band 1 with a predefined color ramp palette
crp_B1 <- colorRampPalette(c("red", "blue")) (100)
plot(p224r63_2011mk$B1_sre, col=crp_B1)
# clean again the current graph
dev.off()
plot(p224r63_2011mk$B2_sre)
# par multiframe (mf) stabilisce come vogliamo fare il plottaggio, 1 row, 2 columns 
par(mfrow=c(1,2))
plot(p224r63_2011mk$B1_sre)
plot(p224r63_2011mk$B2_sre)
# 2 row, 1 columns
par(mfrow=c(2,1)) #if you are using columns first: par(mfcol...)
plot(p224r63_2011mk$B1_sre)
plot(p224r63_2011mk$B2_sre)
#plot the first four bands of Landsat
par(mfrow=c(4,1))
plot(p224r63_2011mk$B1_sre)
plot(p224r63_2011mk$B2_sre)
plot(p224r63_2011mk$B3_sre)
plot(p224r63_2011mk$B4_sre)
# a quadrat of bands: 2 row, 2 columns
par(mfrow=c(2,2))
plot(p224r63_2011mk$B1_sre)
plot(p224r63_2011mk$B2_sre)
plot(p224r63_2011mk$B3_sre)
plot(p224r63_2011mk$B4_sre)
# a quadrat of bands with a specific color palette
par(mfrow=c(2,2))
crp_b <- colorRampPalette(c("dark blue", "blue", "light blue")) (100)
plot(p224r63_2011mk$B1_sre, col=crp_b)
crp_g <- colorRampPalette(c("dark green", "green", "light green")) (100)
plot(p224r63_2011mk$B2_sre, col=crp_g)
crp_r <- colorRampPalette(c("dark red", "red", "pink")) (100)
plot(p224r63_2011mk$B3_sre, col=crp_r)
crp_near <- colorRampPalette(c("red", "orange", "yellow")) (100)
plot(p224r63_2011mk$B4_sre, col=crp_near)

## day4

# Bande Landsat
# B1: blu
# B2: verde
# B3: rosso
# B4: infrarosso vicino
# B5: infrarosso medio
# B6: infrarosso termico
# B7: ifrarosso medio

#visualizing data by RGB plotting
#natural colours
plotRGB(p224r63_2011mk, r=3, g=2, b=1, stretch="Lin")
#false colours
plotRGB(p224r63_2011mk, r=4, g=3, b=2, stretch="Lin")
#false colours in green with band 4 infrared
plotRGB(p224r63_2011mk, r=3, g=4, b=2, stretch="Lin")
plotRGB(p224r63_2011mk, r=3, g=2, b=4, stretch="Lin")

#exercises: mount a 2x2 multiframe stretch lineare
#export in pdf
pdf("landsat_bands.pdf")
par(mfrow=c(2,2))
plotRGB(p224r63_2011mk, r=3, g=2, b=1, stretch="Lin")
plotRGB(p224r63_2011mk, r=4, g=3, b=2, stretch="Lin")
plotRGB(p224r63_2011mk, r=3, g=4, b=2, stretch="Lin")
plotRGB(p224r63_2011mk, r=3, g=2, b=4, stretch="Lin")
dev.off()

plotRGB(p224r63_2011mk, r=3, g=4, b=2, stretch="Lin")
#multiframe stretch histogram che evidenzia di più le zone umide
plotRGB(p224r63_2011mk, r=3, g=4, b=2, stretch="hist")

#parnaturl colours, false colours, and false colours with histogram stretch
par(mfrow=c(3,1))
plotRGB(p224r63_2011mk, r=3, g=2, b=1, stretch="Lin")
plotRGB(p224r63_2011mk, r=3, g=4, b=2, stretch="Lin")
plotRGB(p224r63_2011mk, r=3, g=4, b=2, stretch="hist")

#install.packages("RStoolbox")
#library(RStoolbox)

## day5
#multitemporal set
#importo tutte le bande del dato con la funzione brick
p224r63_1988mk <- brick("p224r63_1988_masked.grd")
#visualizza i metadati del dato
p224r63_1988mk
#plot su R tutte le bande in visualizzazione
plot(p224r63_1988mk)
#colore naturale e strech lineare 
plotRGB(p224r63_1988mk, r=3, g=2, b=1, stretch="Lin")
#colore falso colore per infrarosso
plotRGB(p224r63_1988mk, r=4, g=3, b=2, stretch="Lin")

par(mfrow=c(2,1))
plotRGB(p224r63_1988mk, r=3, g=2, b=1, stretch="Lin")
plotRGB(p224r63_1988mk, r=4, g=3, b=2, stretch="Lin")
##histogram
#esporta in pdf con le img 2x2 
pdf("multitemp_1988-2011.pdf")
par(mfrow=c(2,2))
plotRGB(p224r63_1988mk, r=4, g=3, b=2, stretch="Lin")
plotRGB(p224r63_2011mk, r=4, g=3, b=2, stretch="Lin")
plotRGB(p224r63_1988mk, r=4, g=3, b=2, stretch="hist")
plotRGB(p224r63_2011mk, r=4, g=3, b=2, stretch="hist")
dev.off()


#---------------------------------------------------

#2. R code time series


# Time series analysis
# Greenland increase of temperature
# Data and code from Emanuela Cosma

#install the packages and call the packages
# install.packages("raster")
# install.packages("rasterVis")
library(raster)
library(rasterVis)
#set the directory
setwd("C:/lab/greenland")

#import single dataset with function raster
lst_2000 <- raster("lst_2000.tif")
#plot image
plot(lst_2000)
#import other raster file
lst_2005 <- raster("lst_2005.tif")
plot(lst_2005)
lst_2010 <- raster("lst_2010.tif")
plot(lst_2010)
lst_2015 <- raster("lst_2015.tif")
plot(lst_2015)

#par 2x2 image raster
par(mfrow=c(2,2))
plot(lst_2000)
plot(lst_2005)
plot(lst_2010)
plot(lst_2015)

#list of files in folder directory with a specific pattern expression that I want to import in R:
rlist <- list.files(pattern="lst")
rlist
#apply the raster function to the whole list of files through the lapply function 
import_f <- lapply(rlist, raster)
import_f
# stack function create a block of raster (collection) in unique file
lst_collection <- stack(import_f)
plot(lst_collection)
#plot in RGB for image 2000 (red), 2005 (green) and 2010 (blue)
plotRGB(lst_collection, 1, 2, 3, stretch="Lin")
#plot in RGB for image 2005 (red), 2010 (green) and 2015 (blue)
plotRGB(lst_collection, 2, 3, 4, stretch="Lin")
plotRGB(lst_collection, 4, 3, 2, stretch="Lin")
#plot of my list_collection data for better output
levelplot(lst_collection)
#in the chart visualize the average of the pixel values for each column and row 
levelplot(lst_collection$lst_2000)
#set the color ramp palette for my list_collection data
cl <- colorRampPalette(c("blue","light blue","pink","red"))(100)
# apply the color ramp palette for levelplot,  (regions)
levelplot(lst_collection,col.regions=cl)
#add the attribute, rename the layer of my list_collection data
levelplot(lst_collection,col.regions=cl, names.attr=c("July 2000","July 2005", "July 2010", "July 2015"))
#add a title of my levelplot with main
levelplot(lst_collection,col.regions=cl, main="LST variation in time", names.attr=c("July 2000","July 2005", "July 2010", "July 2015"))

#Melt data
#create list of melt data
melt_l <- list.files(pattern="melt")
#apply the raster function to the whole list of files through the lapply function 
im_melt <- lapply(melt_l, raster)
#create a block of raster (collection) in unique file
melt <- stack(im_melt)
melt
#plot the melt list
levelplot(melt)

#difference in pixel values between 2 year to see the variation
melt_amount <- melt$X2007annual_melt - melt$X1979annual_melt
#set color ramp palette for melt list data and plot
cl_m <- colorRampPalette(c("blue","white","red"))(100)
plot(melt_amount, col=cl_m)
#levelplot pf melt_amount with new color rampe palette
levelplot(melt_amount, col.regions=cl_m)

#-------------------------------------------------------------------------------------------

#3. R code Copernicus data


# R_code_copernicus.r
# Visualizing Copernicus data

#install packages netcdf to read this raster format
#install.packages("ncdf4")

#recall the library 
library(raster)
library(ncdf4)

#set the directory
setwd("C:/lab/")

#import my raster
ndvi <- raster("c_gls_NDVI_202006210000_GLOBE_PROBAV_V3.0.1.nc")

#set colorRampPalette
cl <- colorRampPalette(c("light green", "green", "dark green", "red"))(100)
plot(ndvi, col=cl)

#apply function aggregate to do the resampling
ndvi_res <- aggregate(ndvi, fact=50)
plot(ndvi_res, col=cl)


#--------------------------------------------------------------------------------------

#4. R code Knitr

# R_code_knitr.r

# set the directory
setwd("C:/lab/")

# call the library knitr
library(knitr)

# this function automatically create a report based on an R script and a template in pdf file 
# and the figure folder with single figures in pdf
stitch("R_code_greenland.r", template=system.file("misc", "knitr-template.Rnw", package="knitr"))

#---------------------------------------------------------------------------------------------------

#5. R code Multivariate analysis

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

#---------------------------------------------------------------------------------------------------------

#6. R code Classification 

# R_code_classification.r

# import the library 
library(raster)
library(RStoolbox)

#set the directory
setwd("C:/lab/")

#brick function to import all band together of solar orbiter data
so <- brick("sun.jpg")
so

#visualize RGB levels
plotRGB(so, 1, 2, 3, stretch="lin")

#Unsupervised Classification - the starting points are chosen by the function itself
so_class <- unsuperClass(so, nClasses=3)
#plot the image 
plot(so_class$map)

#Unsupervised Classification with 20 classes
so_class20 <- unsuperClass(so, nClasses=20)
#plot the image 
plot(so_class20$map)

# Download image 
#https://www.esa.int/ESA_Multimedia/Missions/Solar_Orbiter/(result_type)/images
sun <- brick("sun1.png")

# Unsupervised classification sun
sunc <- unsuperClass(sun, nClasses=3)
plot(sunc$map)

# Unsupervised classification sun with 40 class
sunc40 <- unsuperClass(sun, nClasses=40)
plot(sunc40$map)


#Gran Canyon
#https://landsat.visibleearth.nasa.gov/view.php?id=80948
#upload the band raster of gran canyon data
gc <- brick("dolansprings_oli_2013088_canyon_lrg.jpg")
#plot the raster data in rgb
plotRGB(gc, r=1, g=2, b=3, stretch="lin")
# it is possible stress the color with stretching histogram 
plotRGB(gc, r=1, g=2, b=3, stretch="hist")
#maximum similarity to the closest pixel
#unsupervised classification
gc_uc2 <- unsuperClass(gc,nClasses = 2)
gc_uc2
#plot to visualize the map component ($map) instead the classes
plot(gc_uc2$map)
#with 4 classes
gc_uc4 <- unsuperClass(gc,nClasses = 4)
plot(gc_uc4$map)


#-------------------------------------------------------------------------------------------------------

#7. R code ggplot2

# call the library
library(raster)
library(RStoolbox)
library(ggplot2)
library(gridExtra)


# set the directory
setwd("C:/lab/")

#upload the band raster
p224r63 <- brick("p224r63_2011_masked.grd")

#plot the image with the packages ggplot2
ggRGB(p224r63,3,2,1, stretch="lin")
ggRGB(p224r63,4,3,2, stretch="lin")

# set the variable for plot the image with ggplot2
p1 <- ggRGB(p224r63,3,2,1, stretch="lin")
p2 <- ggRGB(p224r63,4,3,2, stretch="lin")

#gridExtra for plot in column with function grid.arrange
grid.arrange(p1, p2, nrow = 2) # this needs gridExtra

#-----------------------------------------------------------------------------------------------------------

#8. R code Vegetation indices

# R_code_vegetation_indices.r


# call the library - the alternative method is require
library(raster) #require(raster)
library(RStoolbox) #for vegetation inidces calculation
library(rasterVis)

#install.packages("rasterdiv")
library(rasterdiv)  #for the worldwide NDVI

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


#worldwide NDVI
plot(copNDVI)

#pixel with value 253, 254, and 255 (water) will be set as NA's (eliminate water)
copNDVI<- reclassify(copNDVI, cbind(253:255, NA))
plot(copNDVI)

#raster package needed
levelplot(copNDVI)

#--------------------------------------------------------------------------------------------

#9. R code Land cover

# R_code_land_cover.r

#call library
library(raster)
library(RStoolbox) #classification 
#install.packages("ggplot2")
library(ggplot2)
#installed.packages("gridExtra")
library(gridExtra) #for grid.arrange plotting 

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


#unsupervised classification for defor1 at 2 and 3 classes
d1_c <- unsuperClass(defor1, nClasses = 2)
d1_c3 <- unsuperClass(defor1, nClasses = 3)
#plot the map created with the unsuperclass function
plot(d1_c$map)
plot(d1_c3$map)

#set.seed() would allow you to attain the same results

#unsupervised classification for defor2 at 2 and 3 classes
d2_c <- unsuperClass(defor2, nClasses = 2)
d2_c3 <- unsuperClass(defor2, nClasses = 3)
#plot the map of the unsuperclass image
plot(d2_c$map)
plot(d2_c3$map)

#class 1: agriculture
#class 2: forest

#calculates the loss of forest with frequency function 
#frequency function for defor1 generate frequency table
freq(d1_c$map)
#result of frequency function for defor1 map layer
#value  count
#[1,]     1 305574
#[2,]     2  35718

#sum of value of defor 1
sum1 <- 305574 + 35718
sum1
#341292

#proportion for defor 1
prop1 <- freq(d1_c$map) / sum1
prop1
#prop forest: 0.8953447 
#prop agriculture: 0.1046553

sum2 <- 342726
prop2 <- freq(d2_c$map) / sum2
prop2
#prop forest: 0.5194208
#prop agriculture: 0.4805792

# build a dataframe
#set the fields
cover <- c("Forest","Agriculture")
percent_1992 <- c(89.53, 10.46)
percent_2006 <- c(51.94, 48.05)
#generate the dataframe
percentages <- data.frame(cover, percent_1992, percent_2006)
percentages
#result of dataset created
#       cover    percent_1992  percent_2006
#1      Forest        89.53        51.94
#2 Agriculture        10.46        48.05

# let's plot them!
#ggplot2, aes=aesthetic, color=classes to discriminate in the graph, in this case the two variables forest and agricolture
ggplot(percentages, aes(x=cover, y=percent_1992, color=cover)) + geom_bar(stat="identity", fill="white")
ggplot(percentages, aes(x=cover, y=percent_2006, color=cover)) + geom_bar(stat="identity", fill="white")

p1 <- ggplot(percentages, aes(x=cover, y=percent_1992, color=cover)) + geom_bar(stat="identity", fill="white")
p1
p2 <- ggplot(percentages, aes(x=cover, y=percent_2006, color=cover)) + geom_bar(stat="identity", fill="white")
#grid.arrange to plot the two graphs together
grid.arrange(p1, p2, nrow=1)

#----------------------------------------------------------------------------------------------------------------------------

#10. R code Variability

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


#---------------------------------------------------------------------------------------------------------------------
#11. R code Spectral signatures

# R_code_spectral_signatures.r

# call the library
library(raster)
library(rgdal)
library(ggplot2)

# set the directory
setwd("C:/lab/")

#import image in R
defor2 <- brick("defor2.jpg")
defor2

# defor2.1, defor2.2, defor2.3
# NIR, red, green

#plot the image in RGB with linear stretch
plotRGB(defor2, r=1, g=2, b=3, stretch="lin")
#plot the image in RGB with histogram stretch
plotRGB(defor2, r=1, g=2, b=3, stretch="hist")

#function to create spectral signature
#click on the map and get the information
#T = true, p = point, pch = simbol to use
click(defor2, id=T, xy=T, cell=T, type="p", pch=16, cex=4, col="yellow" )

#results in water:
#     x     y   cell defor2.1 defor2.2 defor2.3
#1 566.5 235.5 174081      206       22       76
#results in vegetation:
#      x     y   cell defor2.1 defor2.2 defor2.3
#1 349.5 224.5 181751      220        3       20

#define the columns of the dataset:
band <- c(1, 2, 3)
forest <- c(220, 3, 20)
water <- c(206, 22, 76)

#create the dataframe
spectral_s <- data.frame(band, forest, water)

#plot the spectral signatures
ggplot(spectral_s, aes(x=band)) +
  geom_line(aes(y=forest), color="green") + 
  geom_line(aes(y=water), color="blue") +
  labs(x="band", y="reflectance")

########## Multitemporal #################

#import image in R
defor1 <- brick("defor1.jpg")
#plot the image in RGB with linear stretch
plotRGB(defor1, r=1, g=2, b=3, stretch="lin")

#spectral signatures defor1
click(defor1, id=T, xy=T, cell=T, type="p", pch=16, cex=4, col="yellow" )

#x     y   cell defor1.1 defor1.2 defor1.3
#1 39.5 335.5 101428      187        9       21
#x     y   cell defor1.1 defor1.2 defor1.3
#1 69.5 328.5 106456      213       12       30
#x     y  cell defor1.1 defor1.2 defor1.3
#1 85.5 377.5 71486      230       23       43
#x     y  cell defor1.1 defor1.2 defor1.3
#1 75.5 398.5 56482      223       33       59
#x     y  cell defor1.1 defor1.2 defor1.3
#1 40.5 404.5 52163      232       35       62

#plotRGB defor2
plotRGB(defor2, r=1, g=2, b=3, stretch="lin")
#spectral signatures defor2
click(defor2, id=T, xy=T, cell=T, type="p", pch=16, cex=4, col="yellow" )

#x     y  cell defor2.1 defor2.2 defor2.3
#1 31.5 339.5 98978      217      158      152
#x     y   cell defor2.1 defor2.2 defor2.3
#1 60.5 331.5 104743      156      154      142
#x     y  cell defor2.1 defor2.2 defor2.3
#1 84.5 380.5 69634      209       12       30
#x     y  cell defor2.1 defor2.2 defor2.3
#1 81.5 395.5 58876      198        8       20
#x     y  cell defor2.1 defor2.2 defor2.3
#1 112.5 396.5 58190      202       20       32

#define the columns of the dataset:
band <- c(1, 2, 3)
time1 <- c(187, 9, 21)
time1px2 <- c(213, 12, 30)
time2 <- c(217, 158, 152)
time2px2 <- c(156, 154, 142)
#create the dataframe
spectrals_temp <- data.frame(band, time1, time2, time1px2, time2px2)

#plot the spectral signatures
ggplot(spectrals_temp, aes(x=band)) +
  geom_line(aes(y=time1), color="red", linetype="dotted") + 
  geom_line(aes(y=time1px2), color="red", linetype="dotted") +
  geom_line(aes(y=time2), color="blue") +
  geom_line(aes(y=time2px2), color="blue") +
  labs(x="band", y="reflectance")


#random point function and extract function da provare

#new import image
puzzle <- brick("june_puzzler.jpg")
puzzle
#plot the image in histagram stretch
plotRGB(puzzle, r=1, g=2, b=3, stretch="hist")
#spectral signatures
click(puzzle, id=T, xy=T, cell=T, type="p", pch=16, cex=4, col="yellow" )

#results
#x     y  cell june_puzzler.1 june_puzzler.2 june_puzzler.3
#1 224.5 452.5 19665            221            188             15
#x     y   cell june_puzzler.1 june_puzzler.2 june_puzzler.3
# 149.5 145.5 240630             21            125              4
#x    y   cell june_puzzler.1 june_puzzler.2 june_puzzler.3
#1 486.5 21.5 330247             57            141             53

#define the columns of the dataset:
band <- c(1, 2, 3)
stratum1 <- c(221, 188, 15)
stratum2 <- c(21, 125, 4)
stratum3 <- c(57, 141, 53)

#create the dataframe
sp_s_puzzle <- data.frame(band, stratum1, stratum2, stratum3)
sp_s_puzzle

#plot the spectral signatures
ggplot(sp_s_puzzle, aes(x=band)) +
  geom_line(aes(y=stratum1), color="yellow") + 
  geom_line(aes(y=stratum2), color="green") +
  geom_line(aes(y=stratum3), color="blue") +
  labs(x="band", y="reflectance")

#-----------------------------------------------------------------------
