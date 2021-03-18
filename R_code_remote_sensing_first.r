ù# My first code in R for remote sensing!

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
#color change
cl <- colorRampPalette(c("black", "grey", "light grey")) (100)
# plotto il raster con i colori definiti in precedenza con "col"
plot(p224r63_2011mk, col=cl)
#color change new
cl <- colorRampPalette(c("red", "blue", "light grey", "yellow", "green")) (100)
plot(p224r63_2011mk, col=cl)
