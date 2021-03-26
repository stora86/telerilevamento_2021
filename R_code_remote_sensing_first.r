# My first code in R for remote sensing!

#set directory Windows
setwd("C:/lab/") 

#funzione che installa i pacchetti R, il pacchetto raster è già installato
#install.packages("raster") 
#richiamare il pacchetto raster per usare le funzioni che contiene
library(raster)
#funzione che consente di importare tutte insieme le bande del dato satellitare raster 
p224r63_2011mk <- brick("p224r63_2011_masked.grd")
p224r63_2011mk #richiamare il file per avere le informazioni
#plotta tutte le bande contenute nel file p224r63_2011mk
plot(p224r63_2011mk)

## day2

#color change
cl <- colorRampPalette(c("black", "grey", "light grey")) (100)
# plotto il raster con i colori definiti in precedenza con "col"
plot(p224r63_2011mk, col=cl)
#color change new
cl <- colorRampPalette(c("red", "blue", "light grey", "yellow", "green")) (100)
plot(p224r63_2011mk, col=cl)

## day3

# Bande Landsat
# B1: blu
# B2: verde
# B3: rosso
# B4: infrarosso vicino
# B5: infrarosso medio
# B6: infrarosso termico
# B7: ifrarosso medio

# dev.off will clean the current graph
dev.off()
# il $ specifica che banda plottare tra tutte
plot(p224r63_2011mk$B1_sre)
#plot band 1 with a predefined color ramp palette
crp_B1 <- colorRampPalette(c("red", "blue")) (100)
plot(p224r63_2011mk$B1_sre, col=crp_B1)
# clean again the current graph
dev.off()
plot(p224r63_2011mk$B2_sre)
# par multiframe (mf) stabilisce come vogliamo fare il plottaggio, 1 row, 2 columns 
par(mfrow=c(1,2))
plot(p224r63_2011mk$B1_sre)
plot(p224r63_2011mk$B2_sre)
# 2 row, 1 columns
par(mfrow=c(2,1)) #if you are using columns first: par(mfcol...)
plot(p224r63_2011mk$B1_sre)
plot(p224r63_2011mk$B2_sre)
#plot the first four bands of Landsat
par(mfrow=c(4,1))
plot(p224r63_2011mk$B1_sre)
plot(p224r63_2011mk$B2_sre)
plot(p224r63_2011mk$B3_sre)
plot(p224r63_2011mk$B4_sre)
# a quadrat of bands: 2 row, 2 columns
par(mfrow=c(2,2))
plot(p224r63_2011mk$B1_sre)
plot(p224r63_2011mk$B2_sre)
plot(p224r63_2011mk$B3_sre)
plot(p224r63_2011mk$B4_sre)
# a quadrat of bands with a specific color palette
par(mfrow=c(2,2))
crp_b <- colorRampPalette(c("dark blue", "blue", "light blue")) (100)
plot(p224r63_2011mk$B1_sre, col=crp_b)
crp_g <- colorRampPalette(c("dark green", "green", "light green")) (100)
plot(p224r63_2011mk$B2_sre, col=crp_g)
crp_r <- colorRampPalette(c("dark red", "red", "pink")) (100)
plot(p224r63_2011mk$B3_sre, col=crp_r)
crp_near <- colorRampPalette(c("red", "orange", "yellow")) (100)
plot(p224r63_2011mk$B4_sre, col=crp_near)

## day4

# Bande Landsat
# B1: blu
# B2: verde
# B3: rosso
# B4: infrarosso vicino
# B5: infrarosso medio
# B6: infrarosso termico
# B7: ifrarosso medio

#visualizing data by RGB plotting
#natural colours
plotRGB(p224r63_2011mk, r=3, g=2, b=1, stretch="Lin")
#false colours
plotRGB(p224r63_2011mk, r=4, g=3, b=2, stretch="Lin")
#false colours in green with band 4 infrared
plotRGB(p224r63_2011mk, r=3, g=4, b=2, stretch="Lin")
plotRGB(p224r63_2011mk, r=3, g=2, b=4, stretch="Lin")

#exercises: mount a 2x2 multiframe stretch lineare
#export in pdf
pdf("landsat_bands.pdf")
par(mfrow=c(2,2))
plotRGB(p224r63_2011mk, r=3, g=2, b=1, stretch="Lin")
plotRGB(p224r63_2011mk, r=4, g=3, b=2, stretch="Lin")
plotRGB(p224r63_2011mk, r=3, g=4, b=2, stretch="Lin")
plotRGB(p224r63_2011mk, r=3, g=2, b=4, stretch="Lin")
dev.off()

plotRGB(p224r63_2011mk, r=3, g=4, b=2, stretch="Lin")
#mltiframe stretch histogram che evidenzia di più le zone umide
plotRGB(p224r63_2011mk, r=3, g=4, b=2, stretch="hist")

#parnaturl colours, false colours, and false colours with histogram stretch
par(mfrow=c(3,1))
plotRGB(p224r63_2011mk, r=3, g=2, b=1, stretch="Lin")
plotRGB(p224r63_2011mk, r=3, g=4, b=2, stretch="Lin")
plotRGB(p224r63_2011mk, r=3, g=4, b=2, stretch="hist")

#install.packages("RStoolbox")
#library(RStoolbox)
