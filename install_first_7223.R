print("This may take a while")
install.packages(c("devtools", "tidyverse","bootstrap", "lmtest", "car", "Hmisc", "sandwich", "multcomp", "knitr", "lattice", "lme4", "survey", "pscl", "ctv","ggplot2", "acs", "ggmap", "dplyr", "sjPlot", "survey", "devtools", "muhaz", "coxme","eha", "cmprsk", "knitr"), dependencies = T)
library(ctv)
install.views(c("SocialSciences", "ReproducibleResearch", "Survival"), coreOnly = T )
install.packages("INLA", repos="https://inla.r-inla-download.org/R/stable")


