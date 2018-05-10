
#Run this prior to the workshop. You can just open this in Rstudion and hit the Source button at the top
#It may take a minute to finish, that's normal
print("This may take a while")

install.packages(c("devtools", "tidyverse","bootstrap", "lmtest", "car", "Hmisc", "sandwich", "multcomp", "knitr", "lattice", "lme4", "survey", "pscl", "readstata13", "ctv","ggplot2", "acs", "ggmap", "dplyr", "sjPlot", "tidyverse","sf"), dep=T)
library(ctv)
install.views(c("SocialSciences", "Spatial"), coreOnly = T)
install.packages("INLA", repos=c(getOption("repos"), INLA="https://inla.r-inla-download.org/R/stable"), dep=TRUE)
