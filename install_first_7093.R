print("DEM 7093 R packages - Install may take a while")
install.packages(c("devtools", "tidyverse", "car", "Hmisc", "knitr", "lattice",  "survey", "ctv","ggplot2", "acs", "ggmap", "dplyr", "sjPlot", "acs", "tigris", "spdep", "RSAGA", "sf"), dependencies = T)
library(ctv)
install.views(c("SocialSciences", "ReproducibleResearch", "Spatial"), coreOnly = T )
devtools::install_github("jannes-m/RQGIS", dep=TRUE)
devtools::install_github("tidyverse/ggplot2")

devtools::install_github("thomasp85/patchwork")
