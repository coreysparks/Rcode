myseg<-function(dat, id,  group1, group2){ #group and total as character
  #higher level total
  htotg1<-tapply(dat[, group1], dat[, id], sum, na.rm=T)
  htotg2<-tapply(dat[, group2], dat[, id], sum, na.rm=T)
  
  #merge totals to smaller units
  hdat<-data.frame(id=names(unlist(htotg1)), htotal=unlist(htotg1)+unlist(htotg2), hg1tot=unlist(htotg1), hg2tot=unlist(htotg2))
  dat$id<-dat[,id]
  mdat<-merge(dat, hdat, by="id", all.x=T)
  mdat$ltotal<-mdat[,group1]+mdat[,group2]
  #dissimilarity   
  mdat$d1<-(abs(mdat[,group1]/mdat$hg1tot - mdat[,group2]/mdat$hg2tot))
  diss1<-.5*tapply(mdat$d1, mdat$id, sum, na.rm=T)
  #interaction
  mdat$int<-(mdat[,group2]/mdat$hg2tot * mdat[,group1]/mdat$ltotal)
  int1<-tapply(mdat$int, mdat$id, sum, na.rm=T)
  #isolation
  mdat$iso<-(mdat[,group2]/mdat$hg2tot * mdat[,group2]/mdat$ltotal)
  iso1<-tapply(mdat$iso, mdat$id, sum, na.rm=T)
  
  
  result<-data.frame(id=unique(dat$id), diss=diss1, interaction=int1, isolation=iso1)
  
}
