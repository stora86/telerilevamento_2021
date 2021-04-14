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
