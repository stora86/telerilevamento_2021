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
