mymean<- function(x){
  sumx<-sum(x)
  mu <- sumx/length(x)
  return(mu)
}

myfun <- function(est, moe){
  sum1<- sqrt(sum(moe^2))
  sum2<- sum(est)
   
  se <- sum1/1.645
  cv <- se/sum2
  return(cv)
}

df<-data.frame(est=c(1,1,1,1,5,3,4,5),
              moe=c(1,1,1,1,2,1,1,1),
              grp=c(1,1,1,1,2,2,2,2))

library(dplyr)
df%>%
  group_by(grp)%>%
  summarise(mycv=myfun(est, moe))
