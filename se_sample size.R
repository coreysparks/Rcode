samp<-list(NULL)
for(i in 2:49){
  samp[[i]] <- rnorm(n = i, mean =10, sd = 10)
}

sem <- function(x){sd(x)/sqrt(length(x))}
cv<- function(x){(sd(x)/sqrt(length(x)))/mean(x, na.rm=T)}

sds <- unlist(lapply(samp, sem))
cvs <- unlist(lapply(samp, cv))

n <- 2:50

plot(sds~n, xlab="Sample Size", ylab = "S.E.(mean)")
plot(100*cvs~n, xlab="Sample Size", ylab = "CV")
