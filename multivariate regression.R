prb<-read_csv(file = "https://raw.githubusercontent.com/coreysparks/data/master/PRB2008_All.csv", col_types = read_rds(url("https://raw.githubusercontent.com/coreysparks/r_courses/master/prbspec.rds")))

mod<-lm(cbind(e0male, e0female)~tfr+continent, data=prb)
summary(mod)

summary(car::Manova(mod))
head(resid(mod))
sigma(mod)
vcov(mod)

linearHypothesis(mod, hypothesis.matrix = c("tfr = 0", "continentAsia = 0","continentEurope=0","continentNorth America=0", "continentOceania=0",  "continentSouth America=0" ))


library(MVLM)
prb<-prb%>%
  filter(complete.cases(e0female, e0male, tfr, continent))
prbx<-data.frame(tfr=prb$tfr)
y<-as.matrix(cbind(as.numeric(prb$e0female), as.numeric(prb$e0male) ))

mod2<-mvlm(y ~ tfr, data=prbx)

mod2
summary(mod2)



