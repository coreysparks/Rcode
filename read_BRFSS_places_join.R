
library(readr)
dat2<- read_csv("C:/Users/ozd504/OneDrive - University of Texas at San Antonio/gis_classwork//PLACES__Local_Data_for_Better_Health__Census_Tract_Data_2021_release.csv")

library(tidyverse)
datsub<- dat2%>%
  filter(Measure == "Diagnosed diabetes among adults aged >=18 years", StateAbbr=="TX")

txtract<- tigris::tracts(state="TX", cb=T, year = 2019)

mdat<- left_join(txtract, datsub, by =c("GEOID"="LocationName"))
library(ggplot2)


  mdat<- mdat%>%
    filter( COUNTYFP=="029")

mdat%>%
  ggplot()+
  geom_sf(aes(fill=Data_Value))

sf::st_write(mdat,dsn = "C:/Users/ozd504/OneDrive - University of Texas at San Antonio/gis_classwork/places_21_bexar_ob.gpkg" ,delete_dsn =T )
