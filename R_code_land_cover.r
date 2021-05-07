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

