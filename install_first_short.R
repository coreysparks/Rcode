print("This may take a while, be patient. Also answer yes to any questions :)")
Sys.sleep(3)

install.packages(c("ctv", "devtools", "tidyverse","bootstrap", "lmtest", "car", "Hmisc", "sandwich", "multcomp", "knitr", "lattice","survey", "pscl", "ctv","ggplot2", "acs", "ggmap", "dplyr", "sjPlot", "survey"), dependencies = T)
library(ctv)
install.views(c("SocialSciences", "ReproducibleResearch"), coreOnly = T )


