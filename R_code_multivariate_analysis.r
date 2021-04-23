# R_code_multivariate_analysis.r

# call the library
library(raster)
library(rasterVis)

# set the directory
setwd("C:/lab/")

# import the all band of raster
p224r63_2011 <- brick("p224r63_2011_masked.grd")
plot(p224r63_2011)
#plot the values of B1 and B2 in scatter plot
plot(p224r63_2011$B1_sre,p224r63_2011$B2_sre, col="red", pch=19, cex=2)
#bands inverted in the plot
plot(p224r63_2011$B2_sre,p224r63_2011$B1_sre, col="red", pch=19, cex=2)
#plot all correlations of the bands present in the raster in pairs 
#scatterplot matrices- - pairs function
pairs(p224r63_2011)


