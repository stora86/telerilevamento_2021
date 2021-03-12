# My first code in R for remote sensing!

#set directory Windows
setwd("C:/lab/") 

#funzione che installa i pacchetti R, il pacchetto raster è già installato
#install.packages("raster") 
#richiamare il pacchetto raster per usare le funzioni che contiene
library(raster)
#
p224r63_2011mk <- brick("p224r63_2011_masked.grd")
p224r63_2011mk #richiamare il file per avere le informazioni
#plotta tutte le bande contenute nel file p224r63_2011mk
plot(p224r63_2011mk)
