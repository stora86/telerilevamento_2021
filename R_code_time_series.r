# Time series analys
# Greenland increase of temperature
# Data and code from Emanuela Cosma

#install the packages and call the packages
# install.packages("raster")
library(raster)
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
