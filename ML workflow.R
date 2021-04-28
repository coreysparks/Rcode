


# set up training and test
intrain.ng<-createDataPartition(y=as.factor(ng$d.event), p=.75, list=F)
train.ng <-ng[intrain.ng,]
test.ng<- ng[-intrain.ng,]

#model control parameters

control <- trainControl(method="repeatedcv", number=10, repeats=2,search="random", sampling = "rose", savePredictions = T, classProbs = T,summaryFunction=twoClassSummary)

# X matrix
ng.dat<-model.matrix(~child_sex+childsize+age_fb+mother_age+child_sex+child_wanted+educ+residence+wealthindex+contraceptive_use+place_delivery+antenatal_visits+Postnatal+b_order+ b_interval+watersource+region-1, data=train.ng)

ng.dat<-data.frame(ng.dat)

# add y to matrix
ng.dat$d.event<-as.factor(train.ng$d.event)

rf_grid<-expand.grid(mtry = c(2,  5, 8, 10, 12))

rfa<-train(as.factor(d.event)~., data=ng.dat, method="rf",trControl=control, tuneGrid=rf_grid)
gl<-train(as.factor(d.event)~., data=ng.dat, method="glm", family=binomial,trControl= control)


# variable importance
plot(varImp(object=rfa), top = 10)
plot(varImp(object=gl), top=10)



## test accuracy
#test x matrix

ng.test<-model.matrix(~child_sex+childsize+age_fb+mother_age+child_sex+child_wanted+educ+residence+wealthindex+contraceptive_use+place_delivery+antenatal_visits+Postnatal+b_order+ b_interval+watersource+region-1, data=test.ng)
ng.test<-data.frame(ng.test)
ng.test$d.event<-as.factor(test.ng$d.event)


pred<-predict(rfa,newdata= ng.test, positive="dead")
confusionMatrix(data=pred, as.factor(ng.test$d.event))

pred2<-predict(gl,newdata= ng.test, positive="dead")
confusionMatrix(data=pred2, as.factor(ng.test$d.event))
