library(tidycensus)
library(tidyverse)
library(plotly)
dat<- get_acs("county", state="TX", variables = "DP03_0062E", geometry = T)




p<- dat |> 
  ggplot()+
  geom_sf(aes(fill = estimate))+
  scale_fill_viridis_c()+
  labs(title = "Median Household Income",
       subtitle = "2021 American Community Survey")
p

ggplotly(p)
