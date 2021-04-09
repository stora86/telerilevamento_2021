# Time series analys
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