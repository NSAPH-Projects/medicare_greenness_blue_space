library("fst")
library("writexl")
library("splines")
library("gnm")
library("writexl")
library("data.table")
library("lmtest")
library("gtools")

new_merged <- "/nfs/home/J/jok8845/shared_space/ci3_analysis/jklompmaker/res2/"
dir_out <- "/nfs/home/J/jok8845/shared_space/ci3_analysis/medicare_temperature_humidity/Modeloutput/"
#dataplot <- read_fst(paste0(new_merged ,"sample.fst"),
dataplot <- read_fst(paste0(new_merged ,"aggregate_RES.fst"),
                     columns = c("sex","race","age_entry","dual","followupyear",
                                 "zip","year","hosp","time_count","population",
                                 "poverty","popdensity",
                                 "medianhousevalue","pct_blk","medhouseholdincome","pct_owner_occ","hispanic",
                                 "education","region4",
                                 "smoke_rate","summer_tmmx","summer_sph","summer_pr",
                                 "ndvi_summer","occur_bs_1000m","park"), as.data.table = T)

#get only urban zipcodes
dataplot$medianhousevalue<-dataplot$medianhousevalue/10000
dataplot$medhouseholdincome<-dataplot$medhouseholdincome/1000
dataplot<-na.omit(dataplot)
nrow(dataplot)

#create quintiles
setDT(dataplot)
dataplot$area<-dataplot$population/dataplot$popdensity
dataplot$area<-as.numeric(dataplot$area)
min(dataplot$area)
mean(dataplot$area)
max(dataplot$area)
dataplot$area_dec<-quantcut(dataplot$area,q=10)
table(dataplot$area_dec)

######################################################################
##################### m-out-n bootstrapping ##########################
######################################################################
sub<-dataplot[dataplot$area_dec=="[0.00354,3.06]",]
dataplot_boots.list<-split(sub, list(sub$zip))
num_uniq_zip <- length(unique(sub$zip))

###model main#############################################################################
print("boots model5")
res_park_boots<-NULL
res_ndvi_boots<-NULL
res_bs_boots<-NULL

Sys.time()
for (boots_id in 1:100){
  set.seed(boots_id)
  zip_sample<-sample(1:num_uniq_zip,floor(5*sqrt(num_uniq_zip)),replace=T)  
  
  dataplot_boots<-data.frame(Reduce(rbind,dataplot_boots.list[zip_sample]))
  
  Sys.time()
  model<-gnm(hosp~park+ndvi_summer+occur_bs_1000m+
               as.factor(year)+as.factor(region4)+
               medhouseholdincome+medianhousevalue+poverty+education+pct_owner_occ+hispanic+pct_blk+
               popdensity+
               smoke_rate+
               summer_tmmx+summer_sph+summer_pr+
               offset(log(time_count)),
             eliminate=(as.factor(sex):as.factor(race):as.factor(dual):as.factor(age_entry):as.factor(followupyear)),
             data=dataplot_boots,family=poisson(link="log"))
  
  res_park_boots<-c(res_park_boots,model$coefficients[1])
  res_ndvi_boots<-c(res_ndvi_boots,model$coefficients[2])
  res_bs_boots<-c(res_bs_boots,model$coefficients[3])
  
  Sys.time()
  gc()
}

#bootstrapping standard error:
se_park<-sd(res_park_boots)*sqrt(floor(5*sqrt(num_uniq_zip)))/sqrt(num_uniq_zip)
se_ndvi<-sd(res_ndvi_boots)*sqrt(floor(5*sqrt(num_uniq_zip)))/sqrt(num_uniq_zip)
se_bs<-sd(res_bs_boots)*sqrt(floor(5*sqrt(num_uniq_zip)))/sqrt(num_uniq_zip)

se_vi_bs<-as.data.frame(rbind(se_park,se_ndvi,se_bs))
colnames(se_vi_bs)<-"se"
se_vi_bs$model<-c("model 5")
se_vi_bs$quintile<-c("q_popdens 1")
se_vi_bs$out<-c("res")
se_vi_bs$exposure<-c("park","ndvi_summer","occur_bs_1000m")

write.csv(se_vi_bs,"/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_popdens_q1_res.xlsx")

######################################################################
##################### m-out-n bootstrapping ##########################
######################################################################
sub<-dataplot[dataplot$area_dec=="(3.06,5.91]",]
dataplot_boots.list<-split(sub, list(sub$zip))
num_uniq_zip <- length(unique(sub$zip))

###model main#############################################################################
print("boots model5")
res_park_boots<-NULL
res_ndvi_boots<-NULL
res_bs_boots<-NULL

Sys.time()
for (boots_id in 1:100){
  set.seed(boots_id)
  zip_sample<-sample(1:num_uniq_zip,floor(5*sqrt(num_uniq_zip)),replace=T)  
  
  dataplot_boots<-data.frame(Reduce(rbind,dataplot_boots.list[zip_sample]))
  
  Sys.time()
  model<-gnm(hosp~park+ndvi_summer+occur_bs_1000m+
               as.factor(year)+as.factor(region4)+
               medhouseholdincome+medianhousevalue+poverty+education+pct_owner_occ+hispanic+pct_blk+
               popdensity+
               smoke_rate+
               summer_tmmx+summer_sph+summer_pr+
               offset(log(time_count)),
             eliminate=(as.factor(sex):as.factor(race):as.factor(dual):as.factor(age_entry):as.factor(followupyear)),
             data=dataplot_boots,family=poisson(link="log"))
  
  res_park_boots<-c(res_park_boots,model$coefficients[1])
  res_ndvi_boots<-c(res_ndvi_boots,model$coefficients[2])
  res_bs_boots<-c(res_bs_boots,model$coefficients[3])
  
  Sys.time()
  gc()
}

#bootstrapping standard error:
se_park<-sd(res_park_boots)*sqrt(floor(5*sqrt(num_uniq_zip)))/sqrt(num_uniq_zip)
se_ndvi<-sd(res_ndvi_boots)*sqrt(floor(5*sqrt(num_uniq_zip)))/sqrt(num_uniq_zip)
se_bs<-sd(res_bs_boots)*sqrt(floor(5*sqrt(num_uniq_zip)))/sqrt(num_uniq_zip)

se_vi_bs<-as.data.frame(rbind(se_park,se_ndvi,se_bs))
colnames(se_vi_bs)<-"se"
se_vi_bs$model<-c("model 5")
se_vi_bs$quintile<-c("q_popdens 2")
se_vi_bs$out<-c("res")
se_vi_bs$exposure<-c("park","ndvi_summer","occur_bs_1000m")

write.csv(se_vi_bs,"/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_popdens_q2_res.xlsx")

######################################################################
##################### m-out-n bootstrapping ##########################
######################################################################
sub<-dataplot[dataplot$area_dec=="(5.91,9.32]",]
dataplot_boots.list<-split(sub, list(sub$zip))
num_uniq_zip <- length(unique(sub$zip))

###model main#############################################################################
print("boots model5")
res_park_boots<-NULL
res_ndvi_boots<-NULL
res_bs_boots<-NULL

Sys.time()
for (boots_id in 1:100){
  set.seed(boots_id)
  zip_sample<-sample(1:num_uniq_zip,floor(5*sqrt(num_uniq_zip)),replace=T)  
  
  dataplot_boots<-data.frame(Reduce(rbind,dataplot_boots.list[zip_sample]))
  
  Sys.time()
  model<-gnm(hosp~park+ndvi_summer+occur_bs_1000m+
               as.factor(year)+as.factor(region4)+
               medhouseholdincome+medianhousevalue+poverty+education+pct_owner_occ+hispanic+pct_blk+
               popdensity+
               smoke_rate+
               summer_tmmx+summer_sph+summer_pr+
               offset(log(time_count)),
             eliminate=(as.factor(sex):as.factor(race):as.factor(dual):as.factor(age_entry):as.factor(followupyear)),
             data=dataplot_boots,family=poisson(link="log"))
  
  res_park_boots<-c(res_park_boots,model$coefficients[1])
  res_ndvi_boots<-c(res_ndvi_boots,model$coefficients[2])
  res_bs_boots<-c(res_bs_boots,model$coefficients[3])
  
  Sys.time()
  gc()
}

#bootstrapping standard error:
se_park<-sd(res_park_boots)*sqrt(floor(5*sqrt(num_uniq_zip)))/sqrt(num_uniq_zip)
se_ndvi<-sd(res_ndvi_boots)*sqrt(floor(5*sqrt(num_uniq_zip)))/sqrt(num_uniq_zip)
se_bs<-sd(res_bs_boots)*sqrt(floor(5*sqrt(num_uniq_zip)))/sqrt(num_uniq_zip)

se_vi_bs<-as.data.frame(rbind(se_park,se_ndvi,se_bs))
colnames(se_vi_bs)<-"se"
se_vi_bs$model<-c("model 5")
se_vi_bs$quintile<-c("q_popdens 3")
se_vi_bs$out<-c("res")
se_vi_bs$exposure<-c("park","ndvi_summer","occur_bs_1000m")

write.csv(se_vi_bs,"/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_popdens_q3_res.xlsx")

######################################################################
##################### m-out-n bootstrapping ##########################
######################################################################
sub<-dataplot[dataplot$area_dec=="(14.7,24.4]",]
dataplot_boots.list<-split(sub, list(sub$zip))
num_uniq_zip <- length(unique(sub$zip))

###model main#############################################################################
print("boots model5")
res_park_boots<-NULL
res_ndvi_boots<-NULL
res_bs_boots<-NULL

Sys.time()
for (boots_id in 1:100){
  set.seed(boots_id)
  zip_sample<-sample(1:num_uniq_zip,floor(5*sqrt(num_uniq_zip)),replace=T)  
  
  dataplot_boots<-data.frame(Reduce(rbind,dataplot_boots.list[zip_sample]))
  
  Sys.time()
  model<-gnm(hosp~park+ndvi_summer+occur_bs_1000m+
               as.factor(year)+as.factor(region4)+
               medhouseholdincome+medianhousevalue+poverty+education+pct_owner_occ+hispanic+pct_blk+
               popdensity+
               smoke_rate+
               summer_tmmx+summer_sph+summer_pr+
               offset(log(time_count)),
             eliminate=(as.factor(sex):as.factor(race):as.factor(dual):as.factor(age_entry):as.factor(followupyear)),
             data=dataplot_boots,family=poisson(link="log"))
  
  res_park_boots<-c(res_park_boots,model$coefficients[1])
  res_ndvi_boots<-c(res_ndvi_boots,model$coefficients[2])
  res_bs_boots<-c(res_bs_boots,model$coefficients[3])
  
  Sys.time()
  gc()
}

#bootstrapping standard error:
se_park<-sd(res_park_boots)*sqrt(floor(5*sqrt(num_uniq_zip)))/sqrt(num_uniq_zip)
se_ndvi<-sd(res_ndvi_boots)*sqrt(floor(5*sqrt(num_uniq_zip)))/sqrt(num_uniq_zip)
se_bs<-sd(res_bs_boots)*sqrt(floor(5*sqrt(num_uniq_zip)))/sqrt(num_uniq_zip)

se_vi_bs<-as.data.frame(rbind(se_park,se_ndvi,se_bs))
colnames(se_vi_bs)<-"se"
se_vi_bs$model<-c("model 5")
se_vi_bs$quintile<-c("q_popdens 4")
se_vi_bs$out<-c("res")
se_vi_bs$exposure<-c("park","ndvi_summer","occur_bs_1000m")

write.csv(se_vi_bs,"/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_popdens_q4_res.xlsx")

######################################################################
##################### m-out-n bootstrapping ##########################
######################################################################
sub<-dataplot[dataplot$area_dec=="(14.7,24.4]",]
dataplot_boots.list<-split(sub, list(sub$zip))
num_uniq_zip <- length(unique(sub$zip))

###model main#############################################################################
print("boots model5")
res_park_boots<-NULL
res_ndvi_boots<-NULL
res_bs_boots<-NULL

Sys.time()
for (boots_id in 1:100){
  set.seed(boots_id)
  zip_sample<-sample(1:num_uniq_zip,floor(5*sqrt(num_uniq_zip)),replace=T)  
  
  dataplot_boots<-data.frame(Reduce(rbind,dataplot_boots.list[zip_sample]))
  
  Sys.time()
  model<-gnm(hosp~park+ndvi_summer+occur_bs_1000m+
               as.factor(year)+as.factor(region4)+
               medhouseholdincome+medianhousevalue+poverty+education+pct_owner_occ+hispanic+pct_blk+
               popdensity+
               smoke_rate+
               summer_tmmx+summer_sph+summer_pr+
               offset(log(time_count)),
             eliminate=(as.factor(sex):as.factor(race):as.factor(dual):as.factor(age_entry):as.factor(followupyear)),
             data=dataplot_boots,family=poisson(link="log"))
  
  res_park_boots<-c(res_park_boots,model$coefficients[1])
  res_ndvi_boots<-c(res_ndvi_boots,model$coefficients[2])
  res_bs_boots<-c(res_bs_boots,model$coefficients[3])
  
  Sys.time()
  gc()
}

#bootstrapping standard error:
se_park<-sd(res_park_boots)*sqrt(floor(5*sqrt(num_uniq_zip)))/sqrt(num_uniq_zip)
se_ndvi<-sd(res_ndvi_boots)*sqrt(floor(5*sqrt(num_uniq_zip)))/sqrt(num_uniq_zip)
se_bs<-sd(res_bs_boots)*sqrt(floor(5*sqrt(num_uniq_zip)))/sqrt(num_uniq_zip)

se_vi_bs<-as.data.frame(rbind(se_park,se_ndvi,se_bs))
colnames(se_vi_bs)<-"se"
se_vi_bs$model<-c("model 5")
se_vi_bs$quintile<-c("q_popdens 5")
se_vi_bs$out<-c("res")
se_vi_bs$exposure<-c("park","ndvi_summer","occur_bs_1000m")

write.csv(se_vi_bs,"/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_popdens_q5_res.xlsx")

######################################################################
##################### m-out-n bootstrapping ##########################
######################################################################
sub<-dataplot[dataplot$area_dec=="(24.4,38.7]",]
dataplot_boots.list<-split(sub, list(sub$zip))
num_uniq_zip <- length(unique(sub$zip))

###model main#############################################################################
print("boots model5")
res_park_boots<-NULL
res_ndvi_boots<-NULL
res_bs_boots<-NULL

Sys.time()
for (boots_id in 1:100){
  set.seed(boots_id)
  zip_sample<-sample(1:num_uniq_zip,floor(5*sqrt(num_uniq_zip)),replace=T)  
  
  dataplot_boots<-data.frame(Reduce(rbind,dataplot_boots.list[zip_sample]))
  
  Sys.time()
  model<-gnm(hosp~park+ndvi_summer+occur_bs_1000m+
               as.factor(year)+as.factor(region4)+
               medhouseholdincome+medianhousevalue+poverty+education+pct_owner_occ+hispanic+pct_blk+
               popdensity+
               smoke_rate+
               summer_tmmx+summer_sph+summer_pr+
               offset(log(time_count)),
             eliminate=(as.factor(sex):as.factor(race):as.factor(dual):as.factor(age_entry):as.factor(followupyear)),
             data=dataplot_boots,family=poisson(link="log"))
  
  res_park_boots<-c(res_park_boots,model$coefficients[1])
  res_ndvi_boots<-c(res_ndvi_boots,model$coefficients[2])
  res_bs_boots<-c(res_bs_boots,model$coefficients[3])
  
  Sys.time()
  gc()
}

#bootstrapping standard error:
se_park<-sd(res_park_boots)*sqrt(floor(5*sqrt(num_uniq_zip)))/sqrt(num_uniq_zip)
se_ndvi<-sd(res_ndvi_boots)*sqrt(floor(5*sqrt(num_uniq_zip)))/sqrt(num_uniq_zip)
se_bs<-sd(res_bs_boots)*sqrt(floor(5*sqrt(num_uniq_zip)))/sqrt(num_uniq_zip)

se_vi_bs<-as.data.frame(rbind(se_park,se_ndvi,se_bs))
colnames(se_vi_bs)<-"se"
se_vi_bs$model<-c("model 5")
se_vi_bs$quintile<-c("q_popdens 6")
se_vi_bs$out<-c("res")
se_vi_bs$exposure<-c("park","ndvi_summer","occur_bs_1000m")

write.csv(se_vi_bs,"/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_popdens_q6_res.xlsx")

######################################################################
##################### m-out-n bootstrapping ##########################
######################################################################
sub<-dataplot[dataplot$area_dec=="(38.7,60.5]",]
dataplot_boots.list<-split(sub, list(sub$zip))
num_uniq_zip <- length(unique(sub$zip))

###model main#############################################################################
print("boots model5")
res_park_boots<-NULL
res_ndvi_boots<-NULL
res_bs_boots<-NULL

Sys.time()
for (boots_id in 1:100){
  set.seed(boots_id)
  zip_sample<-sample(1:num_uniq_zip,floor(5*sqrt(num_uniq_zip)),replace=T)  
  
  dataplot_boots<-data.frame(Reduce(rbind,dataplot_boots.list[zip_sample]))
  
  Sys.time()
  model<-gnm(hosp~park+ndvi_summer+occur_bs_1000m+
               as.factor(year)+as.factor(region4)+
               medhouseholdincome+medianhousevalue+poverty+education+pct_owner_occ+hispanic+pct_blk+
               popdensity+
               smoke_rate+
               summer_tmmx+summer_sph+summer_pr+
               offset(log(time_count)),
             eliminate=(as.factor(sex):as.factor(race):as.factor(dual):as.factor(age_entry):as.factor(followupyear)),
             data=dataplot_boots,family=poisson(link="log"))
  
  res_park_boots<-c(res_park_boots,model$coefficients[1])
  res_ndvi_boots<-c(res_ndvi_boots,model$coefficients[2])
  res_bs_boots<-c(res_bs_boots,model$coefficients[3])
  
  Sys.time()
  gc()
}

#bootstrapping standard error:
se_park<-sd(res_park_boots)*sqrt(floor(5*sqrt(num_uniq_zip)))/sqrt(num_uniq_zip)
se_ndvi<-sd(res_ndvi_boots)*sqrt(floor(5*sqrt(num_uniq_zip)))/sqrt(num_uniq_zip)
se_bs<-sd(res_bs_boots)*sqrt(floor(5*sqrt(num_uniq_zip)))/sqrt(num_uniq_zip)

se_vi_bs<-as.data.frame(rbind(se_park,se_ndvi,se_bs))
colnames(se_vi_bs)<-"se"
se_vi_bs$model<-c("model 5")
se_vi_bs$quintile<-c("q_popdens 7")
se_vi_bs$out<-c("res")
se_vi_bs$exposure<-c("park","ndvi_summer","occur_bs_1000m")

write.csv(se_vi_bs,"/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_popdens_q7_res.xlsx")

######################################################################
##################### m-out-n bootstrapping ##########################
######################################################################
sub<-dataplot[dataplot$area_dec=="(60.5,95.1]",]
dataplot_boots.list<-split(sub, list(sub$zip))
num_uniq_zip <- length(unique(sub$zip))

###model main#############################################################################
print("boots model5")
res_park_boots<-NULL
res_ndvi_boots<-NULL
res_bs_boots<-NULL

Sys.time()
for (boots_id in 1:100){
  set.seed(boots_id)
  zip_sample<-sample(1:num_uniq_zip,floor(5*sqrt(num_uniq_zip)),replace=T)  
  
  dataplot_boots<-data.frame(Reduce(rbind,dataplot_boots.list[zip_sample]))
  
  Sys.time()
  model<-gnm(hosp~park+ndvi_summer+occur_bs_1000m+
               as.factor(year)+as.factor(region4)+
               medhouseholdincome+medianhousevalue+poverty+education+pct_owner_occ+hispanic+pct_blk+
               popdensity+
               smoke_rate+
               summer_tmmx+summer_sph+summer_pr+
               offset(log(time_count)),
             eliminate=(as.factor(sex):as.factor(race):as.factor(dual):as.factor(age_entry):as.factor(followupyear)),
             data=dataplot_boots,family=poisson(link="log"))
  
  res_park_boots<-c(res_park_boots,model$coefficients[1])
  res_ndvi_boots<-c(res_ndvi_boots,model$coefficients[2])
  res_bs_boots<-c(res_bs_boots,model$coefficients[3])
  
  Sys.time()
  gc()
}

#bootstrapping standard error:
se_park<-sd(res_park_boots)*sqrt(floor(5*sqrt(num_uniq_zip)))/sqrt(num_uniq_zip)
se_ndvi<-sd(res_ndvi_boots)*sqrt(floor(5*sqrt(num_uniq_zip)))/sqrt(num_uniq_zip)
se_bs<-sd(res_bs_boots)*sqrt(floor(5*sqrt(num_uniq_zip)))/sqrt(num_uniq_zip)

se_vi_bs<-as.data.frame(rbind(se_park,se_ndvi,se_bs))
colnames(se_vi_bs)<-"se"
se_vi_bs$model<-c("model 5")
se_vi_bs$quintile<-c("q_popdens 8")
se_vi_bs$out<-c("res")
se_vi_bs$exposure<-c("park","ndvi_summer","occur_bs_1000m")

write.csv(se_vi_bs,"/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_popdens_q8_res.xlsx")

######################################################################
##################### m-out-n bootstrapping ##########################
######################################################################
sub<-dataplot[dataplot$area_dec=="(95.1,162]",]
dataplot_boots.list<-split(sub, list(sub$zip))
num_uniq_zip <- length(unique(sub$zip))

###model main#############################################################################
print("boots model5")
res_park_boots<-NULL
res_ndvi_boots<-NULL
res_bs_boots<-NULL

Sys.time()
for (boots_id in 1:100){
  set.seed(boots_id)
  zip_sample<-sample(1:num_uniq_zip,floor(5*sqrt(num_uniq_zip)),replace=T)  
  
  dataplot_boots<-data.frame(Reduce(rbind,dataplot_boots.list[zip_sample]))
  
  Sys.time()
  model<-gnm(hosp~park+ndvi_summer+occur_bs_1000m+
               as.factor(year)+as.factor(region4)+
               medhouseholdincome+medianhousevalue+poverty+education+pct_owner_occ+hispanic+pct_blk+
               popdensity+
               smoke_rate+
               summer_tmmx+summer_sph+summer_pr+
               offset(log(time_count)),
             eliminate=(as.factor(sex):as.factor(race):as.factor(dual):as.factor(age_entry):as.factor(followupyear)),
             data=dataplot_boots,family=poisson(link="log"))
  
  res_park_boots<-c(res_park_boots,model$coefficients[1])
  res_ndvi_boots<-c(res_ndvi_boots,model$coefficients[2])
  res_bs_boots<-c(res_bs_boots,model$coefficients[3])
  
  Sys.time()
  gc()
}

#bootstrapping standard error:
se_park<-sd(res_park_boots)*sqrt(floor(5*sqrt(num_uniq_zip)))/sqrt(num_uniq_zip)
se_ndvi<-sd(res_ndvi_boots)*sqrt(floor(5*sqrt(num_uniq_zip)))/sqrt(num_uniq_zip)
se_bs<-sd(res_bs_boots)*sqrt(floor(5*sqrt(num_uniq_zip)))/sqrt(num_uniq_zip)

se_vi_bs<-as.data.frame(rbind(se_park,se_ndvi,se_bs))
colnames(se_vi_bs)<-"se"
se_vi_bs$model<-c("model 5")
se_vi_bs$quintile<-c("q_popdens 9")
se_vi_bs$out<-c("res")
se_vi_bs$exposure<-c("park","ndvi_summer","occur_bs_1000m")

write.csv(se_vi_bs,"/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_popdens_q9_res.xlsx")

######################################################################
##################### m-out-n bootstrapping ##########################
######################################################################
sub<-dataplot[dataplot$area_dec=="(162,5.5e+03]",]
dataplot_boots.list<-split(sub, list(sub$zip))
num_uniq_zip <- length(unique(sub$zip))

###model main#############################################################################
print("boots model5")
res_park_boots<-NULL
res_ndvi_boots<-NULL
res_bs_boots<-NULL

Sys.time()
for (boots_id in 1:100){
  set.seed(boots_id)
  zip_sample<-sample(1:num_uniq_zip,floor(5*sqrt(num_uniq_zip)),replace=T)  
  
  dataplot_boots<-data.frame(Reduce(rbind,dataplot_boots.list[zip_sample]))
  
  Sys.time()
  model<-gnm(hosp~park+ndvi_summer+occur_bs_1000m+
               as.factor(year)+as.factor(region4)+
               medhouseholdincome+medianhousevalue+poverty+education+pct_owner_occ+hispanic+pct_blk+
               popdensity+
               smoke_rate+
               summer_tmmx+summer_sph+summer_pr+
               offset(log(time_count)),
             eliminate=(as.factor(sex):as.factor(race):as.factor(dual):as.factor(age_entry):as.factor(followupyear)),
             data=dataplot_boots,family=poisson(link="log"))
  
  res_park_boots<-c(res_park_boots,model$coefficients[1])
  res_ndvi_boots<-c(res_ndvi_boots,model$coefficients[2])
  res_bs_boots<-c(res_bs_boots,model$coefficients[3])
  
  Sys.time()
  gc()
}

#bootstrapping standard error:
se_park<-sd(res_park_boots)*sqrt(floor(5*sqrt(num_uniq_zip)))/sqrt(num_uniq_zip)
se_ndvi<-sd(res_ndvi_boots)*sqrt(floor(5*sqrt(num_uniq_zip)))/sqrt(num_uniq_zip)
se_bs<-sd(res_bs_boots)*sqrt(floor(5*sqrt(num_uniq_zip)))/sqrt(num_uniq_zip)

se_vi_bs<-as.data.frame(rbind(se_park,se_ndvi,se_bs))
colnames(se_vi_bs)<-"se"
se_vi_bs$model<-c("model 5")
se_vi_bs$quintile<-c("q_popdens 10")
se_vi_bs$out<-c("res")
se_vi_bs$exposure<-c("park","ndvi_summer","occur_bs_1000m")

write.csv(se_vi_bs,"/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_popdens_q10_res.xlsx")

