# R_code_no2.r

# call the library
library(raster)
library(RStoolbox)

#1. Set the working directory EN
# set the directory
setwd("C:/lab/EN")

#2. Import the first image (single band)
EN1 <- raster("EN_0001.png")

#3. Plot the first imported image with your preferred Color Ramp Palette
cl <- colorRampPalette(c("blue","yellow","red"))(100)
plot(EN1, col = cl)

EN1

#4. Import the last image (13th) and plot it with the previous Color Ramp Palette
EN13 <- raster("EN_0013.png")
plot(EN13, col = cl)

#5. Make the difference between the two images and plot it
# March - January or January - March
ENDiff <- EN1 - EN13
plot(ENDiff, col = cl)

#6. Plot everything, altogether
par(mfrow=c(3,1))
plot(EN1, col=cl, main="No2 March")
plot(EN13, col=cl, main="No2 January")
plot(ENDiff, col=cl, main="DIfference March - January")

#7. Import the whole set
#list of files in folder directory with a specific pattern expression that I want to import in R:
rlist <- list.files(pattern = "EN")
rlist
#apply the raster function to the whole list of files through the lapply function
import_img <- lapply(rlist, raster)
# stack function create a block of raster (collection) in unique file
EN_collection <- stack(import_img)
#plot the whole set
plot(EN_collection, col = cl)

#8. Replicate the plot images 1 and 13 using stack
par(mfrow=c(1,2))
plot(EN_collection$EN_0001, col = cl)
plot(EN_collection$EN_0013, col = cl)

#9. Compute a PCA over the 13 images
EN_pca <- rasterPCA(EN_collection)
summary(EN_pca$model)
plotRGB(EN_pca$map, r=1, g=2, b=3, stretch="lin")

#10. Compute the variability (local standard deviation) of the first PCA
#call the en_pca on $map layer that containe the data, on the $PC1
EN_pca1_sd <- focal(EN_pca$map$PC1, w=matrix(1/9, nrow=3, ncol=3), fun=sd)
plot(EN_pca1_sd, col=cl)







  