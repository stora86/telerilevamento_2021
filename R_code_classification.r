# R_code_classification.r

#set the directory
setwd("C:/lab/")

# import the library 
library(raster)
library(RStoolbox)

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