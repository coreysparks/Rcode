print("DEM 7093 R packages - Install may take a while")
install.packages(c("devtools", "tidyverse", "car", "Hmisc", "knitr", "lattice",  "survey", "ctv","ggplot2", "acs", "ggmap", "dplyr", "sjPlot", "acs", "tigris", "spdep", "rsaga", "sf"), dependencies = T)
library(ctv)
install.views(c("SocialSciences", "ReproducibleResearch", "Spatial"), coreOnly = T )
devtools::install_github("jannes-m/RQGIS", dep=TRUE)

