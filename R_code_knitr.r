# R_code_knitr.r

# set the directory
setwd("C:/lab/")

# call the library knitr
library(knitr)

# this function automatically create a report based on an R script and a template in pdf file 
# and the figure folder with single figures in pdf
stitch("R_code_greenland.r", template=system.file("misc", "knitr-template.Rnw", package="knitr"))