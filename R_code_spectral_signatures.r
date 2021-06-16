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

