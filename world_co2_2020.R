library(tidyverse)
library(sf)
library(WDI)
library(tmap)
co2 <- WDI(indicator = "EN.ATM.CO2E.KT", country = "all") |> 
  dplyr::filter(year == 2020)

wrld <- spData::world

merged <- wrld |> 
  left_join(co2, by = c("iso_a2"= "iso2c"))

merged |> 
  tm_shape()+
  tm_polygons(col = "EN.ATM.CO2E.KT", 
              title="CO2 Emissions (kt), 2020",
              palette="Greens",
              style="quantile",
              n=10,
              alpha = .9,
              legend.hist=T)+
  tm_format("World",
            legend.outside=T)+
  tm_scale_bar(position = c(.5, .2))+
  tm_compass() +
  tm_credits("Data source: \nhttps://data.worldbank.org/indicator/EN.ATM.CO2E.KT\nCreated by Corey S. Sparks", align = "left", width = .95, bg.color = "grey", bg.alpha = .2)
  
tmap_save(filename = "worldco2.png",
          width = 10, 
          height =6, 
          dpi = 150)
