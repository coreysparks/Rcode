print("DEM 7093 R packages - Install may take a while")
install.packages(c("devtools","tmap", "mapview", "tidyverse", "car", "Hmisc", "knitr", "lattice","spatialreg",  "survey", "ctv","ggplot2", "acs", "ggmap", "dplyr", "sjPlot", "acs", "tigris", "spdep", "RSAGA", "sf", "tidycensus"), dependencies = T)

ctv::install.views(c("SocialSciences", "ReproducibleResearch", "Spatial"), coreOnly = T )
#devtools::install_github("jannes-m/RQGIS", dep=TRUE)
#devtools::install_github("tidyverse/ggplot2")
remotes::install_github("paleolimbot/qgisprocess")
devtools::install_github("thomasp85/patchwork")
devtools::install_github("oswaldosantos/ggsn")
