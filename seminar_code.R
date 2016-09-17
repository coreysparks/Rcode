
library(RFigisGeo)
library(rgeos)
library(rgdal)
library(rjson) 
library(plyr) 
library(dplyr)
library(sp)
library(RColorBrewer)
library(lmtest)
library(spdep)

#Tell R where I want to work, this is optional, but saves time. 
setwd("~/Google Drive/a&m_stuff/")

#Read shapefiles for all TX census tracts
txtracts<-readOGR(".", "gz_2010_48_140_00_500k")

#And a shapefile for counties in the AACOG 
sa_cos<- readOGR(".", "sa_counties")

#make county polygons into lines
sa_co_lines<-as(sa_cos, "SpatialLines")

#extract tracts within the San Antonio area counties using a spatial intersection (GIS command)
sa_tracts<- RFigisGeo::intersection (txtracts,sa_cos )

plot(sa_tracts)
plot(sa_co_lines, add=T, col=2, lwd=2.5)

#Make an identifier that combines state, county and tract - this is the unique identifier from the Census, called the GEOID
sa_tracts$tract_id<-paste(as.character(sa_tracts$STATE.x), as.character(sa_tracts$COUNTY.x), as.character(sa_tracts$TRACT ), sep="")


#Get data from factfinder

#Here I use the Census developer API (Application program interface) to get data easily and on the fly.
#https://www.census.gov/developers/
  
#Here, i'm using the 2013 5 year American Community Survey data on census tracts in 8 counties in and around San Antonio 
#The list of tables is here: 
#http://api.census.gov/data/2013/acs5/variables.html


#DP05_0001E = total population
#DP02_0009PE = female hh with children %
#DP02_0040E = 15 TO 19 fertility rate per 1000 women
#DP02_0038E = unmarried fertility rate per 1000 women
#DP02_0066PE hs or higher %
#DP02_0067PE ba or higher %
#DP02_0080PE different house 1 year ago %
#DP02_0092PE foreign born %
#DP03_0005PE =  unemployment rate %
#DP03_0028PE = service sector %
#DP03_0062E = median hh income
#DP03_0099PE = % without health insurance
#DP03_0101PE = under 18 without health insurance %
#DP03_0119PE = poverty rate %
#DP04_0046PE = housing units rented %
#DP04_0057PE = housing units without vehicle %
#DP04_0078PE = housing units with > 1.5 persons per room &
#DP05_0072PE nh_white %
#DP05_0073PE nh_black %
#DP05_0066PE latino %

#instructions on doing this are here:
#http://api.census.gov/data/2013/acs5/examples.html


myurl<-"http://api.census.gov/data/2013/acs5/profile?get=DP05_0001E,DP02_0009PE,DP02_0040E,DP02_0038E,DP02_0066PE,DP02_0067PE,DP02_0080PE,DP02_0092PE,DP03_0005PE,DP03_0028PE,DP03_0062E,DP03_0099PE,DP03_0101PE,DP03_0119PE,DP04_0046PE,DP04_0057PE,DP04_0078PE,DP05_0072PE,DP05_0073PE,DP05_0066PE&key=997fb9115102b709d5028501b4b030e84af62525&for=tract:*&in=state:48+county:029,091,259,325,013,019,493,187"

#Here I use some tools in R to read data from the API, and convert it to a flat table:

acs<-fromJSON(file=url(myurl) )
df<-ldply(acs[-1])

#give the table some names that make sense
names(df)<-c("totalpop","pfemhh", "teenfert", "unmarfert", "hsplus", "baplus", "diffhouse1yr", "pforeign",  "unemployment","service","medianhhinc", "nohealthins","childnohealthins","poverty", "rented","novehicle", "highoccupancy", "pnhwhite", "pnhblack", "phispanic", "state", "county" ,"tract")

#The data come down, often times as character values, so I convert them all to numeric
df<- mutate_each(df, funs(as.numeric), -state, -county ,-tract)

#MAke the Census GEOID so I can merge it to my polygons from above
df$tractid<-paste(df$state, df$county, df$tract, sep="")

#Let's have a look
head(df)

#Merge the tracts to the tabular data
sa_tracts2<-merge(sa_tracts, df, by.x=c("COUNTY.x", "TRACT"), by.y= c("county", "tract"))

#get rid of some missing tracts, some of the military bases aren't really valid
sa_tracts2<-sa_tracts2[is.na(sa_tracts2$poverty)==F&is.na(sa_tracts2$childnohealthins)==F, ]
head(sa_tracts2@data)

#Save our new shapefile that has the data on it
#writeOGR(sa_tracts2, ".", "sa_tracts2", driver="ESRI Shapefile")

plot(sa_tracts2)
spplot(sa_tracts2,c( "pnhwhite", "pnhblack", "phispanic"), at=seq(0,100, 20),col.regions=brewer.pal(n=5, "Reds") , col=NA, main = "Distribution of Population by Race/Ethnicity- ACS 2013")

spplot(sa_tracts2,c( "poverty"),col.regions=brewer.pal(n=7, "Reds"), col=NA,at=seq(0,70,10),
       main="ACS Poverty Rate Estimate 2015 5 Year Estimates")



nbs<- poly2nb(sa_tracts2, queen = T)
wts<-nb2listw(nbs, style = "W")

moran.mc(sa_tracts2$poverty, listw=wts, nsim=999, na.action=na.omit)
geary.mc(sa_tracts2$poverty, listw = wts, nsim = 999)

#OLS model for poverty
hist(sa_tracts2$poverty, main="AACOG Poverty Histogram")
fit <- lm( poverty ~baplus+ phispanic+pnhblack, data=sa_tracts2)
summary(fit)

plot(fit)
hist(rstudent(fit))


bptest(fit)
sa_tracts2$olsresid<-rstudent(fit)

lm.morantest(fit, listw = wts)

spplot(sa_tracts2, "olsresid", at=quantile(sa_tracts2$olsresid), col.regions=brewer.pal(n=6, name="RdBu"), col=NA)

lm.LMtests(fit, listw=wts, test="all")

#spatial regression models
#error model
fit.e<-errorsarlm(poverty ~baplus+ phispanic+pnhblack, data=sa_tracts2, listw = wts)
summary(fit.e)

#lag model
fit.l<-lagsarlm(poverty ~baplus+ phispanic+pnhblack, data=sa_tracts2, listw = wts)
summary(fit.l)

#Durbin model
fit.ld<-lagsarlm(poverty ~baplus+ phispanic+pnhblack, data=sa_tracts2, listw = wts, type = "mixed")
summary(fit.ld)

AIC (fit.e)
AIC (fit.l)
AIC (fit.ld)

#Spatial Regimes
#split data by %Hispanic
sa_tracts2$hisp_cut<-cut(sa_tracts2$phispanic, breaks = 3)
table(sa_tracts2$hisp_cut)
spplot(sa_tracts2, "hisp_cut")

fit.r1<-lm(poverty ~baplus+ phispanic+pnhblack, data=sa_tracts2, subset = hisp_cut=="(-0.0994,33.1]")

fit.r2<-lm(poverty ~baplus+ phispanic+pnhblack, data=sa_tracts2, subset = hisp_cut=="(33.1,66.3]")

fit.r3<-lm(poverty ~baplus+ phispanic+pnhblack, data=sa_tracts2, subset = hisp_cut=="(66.3,99.5]")

summary(fit.r1)
summary(fit.r2)
summary(fit.r3)


