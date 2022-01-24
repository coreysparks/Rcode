dat<-read.csv("~/Downloads/adi-download/TX_2019_ADI_9 Digit Zip Code_v3.1.txt")


sub<-dat[is.na(dat$TYPE)==T,]
head(sub)
sub$zsub<-substr(sub$ZIPID, 2, 6)
library(dplyr)

zip_code_adi<-sub%>%
  group_by(zsub)%>%
  summarise(meanadi = mean(as.numeric(ADI_STATERNK), na.rm=T))%>%
  ungroup()



