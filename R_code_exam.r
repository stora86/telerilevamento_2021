# R_code_exam.r

#Esame di Telerilevamento Geo-Ecologico - A.A.2020/2021 - Susanna Tora
#----------------------------------------------------------------------


# Call the library
library(raster)
library(RStoolbox) #classification 
library(ggplot2)
library(gridExtra) #for plotting ggplots together
library(rasterVis) #for levelplot
library(sp) #random points
library(viridis) #for ggplot colouring
library(ncdf4) #import nc file


# Set the directory
setwd("C:/lab/exam")

#----------------------------------------------------------------------

# Import the whole set of images in R of Lake of Campotosto, Abruzzo
# Sentinel-2A of 2017 and 2021 - Copernicus data

# Band
# B02 = Blue, B03 = Green, B04 = Red , B08 = NIR

# Year 2017
# List of file in the folder with the specific pattern
l_s2A_2017 <- list.files(pattern = "L2A_")
l_s2A_2017
# Apply the raster function to the whole list of files through the lapply function
imp_s2A_2017 <- lapply(l_s2A_2017, raster)
# Stack function to create a block of raster (collection) in unique file
s2A_2017 <- stack(imp_s2A_2017)
s2A_2017

# Crop the raster stack with defined extent
# Coordinates in WGS84/UTM33 (crs of S2A)
extent <- c(353234.1268583927885629,374628.9153687399229966,4705490.5183606687933207,4724246.6162880733609200)
s2A_2017cr <- crop(s2A_2017, extent)
# Plot the images
plot(s2A_2017cr)
s2A_2017cr

# Year 2021
# Same steps performed for the first block of images
l_s2A_2021 <- list.files(pattern = "T33TUH_20210510T100031")
l_s2A_2021
imp_s2A_2021 <- lapply(l_s2A_2021, raster)
s2A_2021 <- stack(imp_s2A_2021)
s2A_2021
s2A_2021cr <- crop(s2A_2021, extent)
plot(s2A_2021cr)
s2A_2021cr

# Export the pdf of multiframe 
pdf("s2years.pdf")
# Multiframe with ggplot2 to plot the images
pl1_s2A_2017 <- ggRGB(s2A_2017cr, r=3, g=2, b=1, stretch="lin") +
  theme(axis.title.x=element_blank(),
        axis.text.x=element_blank(),
        axis.ticks.x=element_blank(),
        axis.title.y=element_blank(),
        axis.text.y=element_blank(),
        axis.ticks.y=element_blank())+
  ggtitle("Natural Color (RGB) - 2017")
pl2_s2A_2017 <- ggRGB(s2A_2017cr, r=4, g=3, b=2, stretch="hist") +
  theme(axis.title.x=element_blank(),
        axis.text.x=element_blank(),
        axis.ticks.x=element_blank(),
        axis.title.y=element_blank(),
        axis.text.y=element_blank(),
        axis.ticks.y=element_blank())+
  ggtitle("False Color (NIR, R, G) - 2017")
pl1_s2A_2021 <- ggRGB(s2A_2021cr, r=3, g=2, b=1, stretch="lin") +
  theme(axis.title.x=element_blank(),
        axis.text.x=element_blank(),
        axis.ticks.x=element_blank(),
        axis.title.y=element_blank(),
        axis.text.y=element_blank(),
        axis.ticks.y=element_blank())+
  ggtitle("Natural Color (RGB) - 2021")
pl2_s2A_2021 <- ggRGB(s2A_2021cr, r=4, g=3, b=2, stretch="hist") +
  theme(axis.title.x=element_blank(),
        axis.text.x=element_blank(),
        axis.ticks.x=element_blank(),
        axis.title.y=element_blank(),
        axis.text.y=element_blank(),
        axis.ticks.y=element_blank())+
  ggtitle("False Color (NIR, R, G) - 2021")

# gridExtra for plot in column
grid.arrange(pl1_s2A_2017, pl2_s2A_2017, pl1_s2A_2021, pl2_s2A_2021, nrow=2) #of the packages ggplot2

# To close the pdf print
dev.off()
# Plot all correlations of the bands present in the raster with pairs function 
# Scatterplot matrices
pairs(s2A_2017cr)
pairs(s2A_2021cr)


#----------------------------------------------------------------------

# Unsupervised Classification at 3 classes
s2A_2017_class <- unsuperClass(s2A_2017cr, nClasses=3)
s2A_2021_class <- unsuperClass(s2A_2021cr, nClasses=3)

# Set the color rampe palette
cl <- colorRampPalette(c("#0066ff","#ffff00","#00e64d"))(100)
# Export the pdf of the result
pdf("lc1.pdf")
# Apply the color ramp palette to levelplot to print UC 2017
levelplot(s2A_2017_class$map, col.regions=cl, main="Unsupervised Classification - 2017")

dev.off()

# Export the pdf of the result
pdf("lc2.pdf")
# Apply the color ramp palette to levelplot to print UC 2017
levelplot(s2A_2021_class$map, col.regions=cl, main="Unsupervised Classification - 2021")
dev.off()

# Calculate the loss of woods

#s2A_2017cr
#s2A_2021cr

sum <- 4014640   # sum = ncell of s2A_2017cr or s2A_2021cr 
# Proportion for s2A_2017_class with the frequency function 
prop1 <- freq(s2A_2017_class$map) / sum
prop1

# Results 2017
# Woods = 0.62484357
# Agriculture and bare soil = 0.34380991
# Lake = 0.03134652

# Agriculture and bare soil + Lake
agri <- 0.34380991 + 0.03134652
agri
# Agriculture and more for 2017 = 0.3751564

# Proportion for s2A_2021_class with the frequency function 
prop2 <- freq(s2A_2021_class$map) / sum
prop2

# Results 2021
# Woods = 0.34471435
# Agriculture and bare soil and Lake = 0.62222092
#Snow = 0.03306473

# Agriculture and bare soil and Lake + Snow
agri2 <- 0.62222092 + 0.03306473
agri2
# Agriculture and more for 2021 = 0.6552856

# Build a dataframe

# Set the fields
year <- c(rep(2017 , 2), rep(2021 , 2))
land_cover <- rep(c("Woods","Agriculture and more"), 1)
value <- c(rep(62.48), rep(37.51), rep(34.47), rep(65.52))
# Generate the dataframe
data <- data.frame(year,land_cover,value)
data

# Results
# year           land_cover value
# 1 2017                Woods 62.48
# 2 2017 Agriculture and more 37.51
# 3 2021                Woods 34.47
# 4 2021 Agriculture and more 65.52

# Let's plot them with bar chart of ggplot!
ggplot(data, aes(fill=land_cover, y=value, x=land_cover)) + 
  geom_bar(position="dodge", stat="identity") +  
  ggtitle("Loss of woodland from 2017 to 2021") +
  facet_grid(~ year) +
  theme(legend.position="none") +
  labs(x="Land Cover", y="Percentage of coverage")

#----------------------------------------------------------------------

# NDVI - Normalized Difference Vegetation Index
# (NIR-RED) / (NIR+RED)

# NDVI 2017
# RStoolbox::spectralIndices
# Vegetation indices, calculate all indices of spectralIndices 
vi2017 <- spectralIndices(s2A_2017cr, green=2, red=3, nir=4)
# Set the color ramp palette for NDVI plot
cl <- colorRampPalette(c('#9f512a','#cca915','#e6ec03','#b9cf00','#72a000','#2c7100'))(100)
# Plot NDVI with the same color rampe palette
plot(vi2017, col=cl)

# NDVI 2021
vi2021 <- spectralIndices(s2A_2021cr, green=2, red=3, nir=4)
# Plot NDVI with color rampe palette
plot(vi2021, col=cl)

# Calculate the differences between the two NDVIs
ndvi_diff <- vi2017$NDVI - vi2021$NDVI
#Set the new color rampe palette to better distinguish the differences
cl_dif <- colorRampPalette(c('blue','white','red'))(100)
# Plot the NDVI difference 
plot(ndvi_diff, col=cl_dif)

# Print the pdf
pdf("ndvi.pdf")
# Plot the NDVI difference, one image next to the other (1x3)
par(mfrow=c(1,3))
plot(vi2017$NDVI, col=cl, main='NDVI to 2017')
plot(vi2021$NDVI, col=cl, main='NDVI to 2021')
plot(ndvi_diff, col=cl_dif, main='Difference between NDVI')

dev.off() # Close the pdf function

# Create random points with function spsample, library(sp)
# Define the bounding box
bbox <- as(extent(vi2017), 'SpatialPolygons')
# Create 10 ramdom point
pt <- spsample(bbox, n=10, type='random')
# Print the pdf of NDVI with random points
pdf("ramdomPoint.pdf")
plot(vi2017$NDVI, col=cl)
plot(pt, add=T, col='red')
dev.off()

# Get the values of both NDVI and the difference in the point locations
# and set the field of dataframe
pt_NDVI2017 <- vi2017$NDVI[pt]
pt_NDVI2021 <- vi2021$NDVI[pt]
pt_NDVI_diff <- ndvi_diff[pt]
pt_id <- c(1,2,3,4,5,6,7,8,9,10)
# Create the dataframe 
pt_df <- data.frame(pt_id, pt_NDVI2017, pt_NDVI2021, pt_NDVI_diff)
pt_df

# Print the pdf of the spectral signare chart
pdf("sp_sign.pdf")
# The spectral signature chart with ggplot
ggplot(pt_df, aes(x=pt_id)) +
  geom_line(aes(y=pt_NDVI2017, color="2017"), linetype="twodash", show_guide=TRUE) +
  geom_point(aes(y=pt_NDVI2017, color="2017"), shape=17, show_guide=TRUE) +
  geom_line(aes(y=pt_NDVI2021, color="2021"), linetype="twodash", show_guide=TRUE) +
  geom_point(aes(y=pt_NDVI2021, color="2021"), shape=15, show_guide=TRUE) +
  geom_line(aes(y=pt_NDVI_diff, color="Difference"), linetype="dashed", show_guide=TRUE) +
  geom_point(aes(y=pt_NDVI_diff, color="Difference", show_guide=TRUE)) +
  labs(x="Sampling Points", y="Reflectance", title='Spectral signatures of NDVI of 2017, 2018 and the difference') +
  scale_color_manual(name="NDVI", values = c('2017' = '#56B4E9','2021' = '#E69F00','Difference' = 'black'))

dev.off()

#---------------------------------------------------------------------------

# Create a dataset with only the ndvi
ndvi <- stack(vi2017$NDVI, vi2021$NDVI)
ndvi

# Compute a PCA (principal component analysis) on both NDVI (RStoolbox library)
ndvi_pca <- rasterPCA(ndvi)
# See the Proportion of Variance of the original information of PC1 (component 1)
summary(ndvi_pca$model)
# the first PC contains 79,94463% of the original information
# Plot the map layer of pca
plot(ndvi_pca$map)
# Plot the PC1
plot(ndvi_pca$map$PC1, main="PC1")

# Moving window on PC1 
# Compute the variability (local standard deviation) of the first PCA
# Call the ndvi_pca on $map layer that contains the data, on the $PC1
ndvi_pca_sd <- focal(ndvi_pca$map$PC1, w=matrix(1/9, nrow=3, ncol=3), fun=sd)
ndvi_pca_sd

# Plot the sd with ggplot applying the turbo color palette of the library viridis
ggplot()+ geom_raster(ndvi_pca_sd, mapping = aes(x = x, y = y, fill = layer)) +
  scale_fill_viridis(option = "turbo") + ggtitle("Standard deviation of PC1 by turbo colour scale")

# Plot the sd with ggplot applying the inferno color palette of the library viridis
ggplot()+ geom_raster(ndvi_pca_sd, mapping = aes(x = x, y = y, fill = layer)) +
  scale_fill_viridis(option = "inferno") + ggtitle("Standard deviation of PC1 by inferno colour scale")

#---------------------------------------------------------------------------

#Surface Soil Moisture for multitemporal analisis
#Copernicus Global Land Service

# List of nc files in folder directory with a specific pattern
rlist <- list.files(pattern = "c_gls_SSM1km")
rlist
# Apply the raster function to the whole list to import it with lapply
imp_ssm <- lapply(rlist, raster)
# Create a block raster (unique file)
ssm_collection <- stack(imp_ssm)
# Set the color rampe palette for the collection of image
cl_ssm <- colorRampPalette(c("#88540B", "#E9D66B","#f5edbc", "#318CE7", "#0048BA", "#0018A8"))(100)
# Plot the whole set of data
plot(ssm_collection, col = cl_ssm)

# Project the dataset into the crs of S2A data previously processed
# Define the crs
rs <- "+proj=utm +zone=33 +datum=WGS84 +units=m +no_defs"
# Project the dataset
prj_ssm <- projectRaster(ssm_collection, crs = rs)
prj_ssm

# And crop it with the same extent as before
ssm_rs_cr <- crop(prj_ssm, extent)
ssm_rs_cr
# Plot the collection with levelplot function
levelplot(ssm_rs_cr, col.regions=cl_ssm)

# Compute a PCA over the 10 images
ssm_pca <- rasterPCA(ssm_rs_cr)
# See the Proportion of Variance of the original information
summary(ssm_pca$model)
# The PC1 contains 84,02158% of the original information
# Plot the map layer of pca
plot(ssm_pca$map)
# Plot the PC1
plot(ssm_pca$map$PC1)

# Moving window on PC1 
# Compute the variability (local standard deviation) of the first PCA (PC1)
# Call the ssm_pca on $map layer that contains the data, on the $PC1
ssm_pca_sd <- focal(ssm_pca$map$PC1, w=matrix(1/9, nrow=3, ncol=3), fun=sd)
# Plot the image
levelplot(ssm_pca_sd, col.regions=cl_ssm)
ssm_pca_sd

# Plot the sd with ggplot applying the turbo color palette of the library viridis
ggplot()+ geom_raster(ssm_pca_sd, mapping = aes(x = x, y = y, fill = layer)) +
  scale_fill_viridis(option = "turbo") + ggtitle("Standard deviation of PC1 by turbo colour scale")
