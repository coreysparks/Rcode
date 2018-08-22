print("This may take a while")
install.packages(c("devtools", "tidyverse","bootstrap", "lmtest", "car", "Hmisc", "sandwich", "multcomp", "knitr", "lattice", "lme4", "survey", "pscl", "readstata13", "ctv","ggplot2", "acs", "ggmap", "dplyr", "sjPlot", "survey", "devtools", "lme4", "survey", "mice", "pander", "knitr", "questionr", "rstan", "brms" , "rstanarm", "pscl"), dependencies = T)
library(ctv)
install.views(c("SocialSciences", "ReproducibleResearch"), coreOnly = T )
install.packages("INLA", repos=c(getOption("repos"), INLA="https://inla.r-inla-download.org/R/stable"), dep=TRUE)


