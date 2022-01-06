print("This may take a while")

install.packages(c("devtools", "tidyverse","bootstrap","tableone", "srvyr", "lmtest", "car", "Hmisc", "sandwich", "multcomp", "knitr", "lattice", "lme4","lmerTest", "survey", "ctv", "tidycensus", "ggmap", "sjPlot", "survey", "devtools", "lme4", "mice", "pander", "knitr", "questionr", "stargazer", "MetBrewer", "geepack", "patchwork", "haven", "gtsummary"),
                 dependencies = T)
library(ctv)
install.views(c("SocialSciences", "ReproducibleResearch"), coreOnly = T )


