#install.packages("coxme")
library("fst")
library("writexl")
library("splines")
library("gnm")
library("writexl")
library("data.table")
library("lmtest")
library("gtools")

new_merged <- "/nfs/home/J/jok8845/shared_space/ci3_health_data/medicare/gen_admission/1999_2016/Klompmaker/merged_data/cvd2/"
dir_out <- "/nfs/home/J/jok8845/shared_space/ci3_analysis/medicare_temperature_humidity/Modeloutput/"
#dataplot <- read_fst(paste0(new_merged ,"sample.fst"),
dataplot <- read_fst(paste0(new_merged ,"aggregate_CVD.fst"),
                     columns = c("sex","race","age_entry","dual","followupyear",
                                 "zip","year","hosp","time_count",
                                 "poverty","popdensity",
                                 "medianhousevalue","pct_blk","medhouseholdincome","pct_owner_occ","hispanic",
                                 "education","region4",
                                 "smoke_rate","summer_tmmx","summer_sph","summer_pr","pm25","no2",
                                 "ndvi_summer","occur_bs_1000m","park"), as.data.table = T)

#get only urban zipcodes
dataplot$medianhousevalue<-dataplot$medianhousevalue/10000
dataplot$medhouseholdincome<-dataplot$medhouseholdincome/1000
dataplot<-na.omit(dataplot)
nrow(dataplot)

#create quintiles
setDT(dataplot)
dataplot$qpm25<-quantcut(dataplot$pm25,3)
dataplot$qno2<-quantcut(dataplot$no2,3)

######################################################################
##################### m-out-n bootstrapping ##########################
######################################################################
sub<-dataplot[dataplot$qpm25=="[0.00783,8.52]",]
dataplot_boots.list<-split(sub, list(sub$zip))
num_uniq_zip <- length(unique(sub$zip))

###model main#############################################################################
print("boots model5")
res_park_boots<-NULL
res_ndvi_boots<-NULL
res_bs_boots<-NULL

Sys.time()
for (boots_id in 1:250){
  set.seed(boots_id)
  zip_sample<-sample(1:num_uniq_zip,floor(2*sqrt(num_uniq_zip)),replace=T)  
  
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
se_park<-sd(res_park_boots)*sqrt(floor(2*sqrt(num_uniq_zip)))/sqrt(num_uniq_zip)
se_ndvi<-sd(res_ndvi_boots)*sqrt(floor(2*sqrt(num_uniq_zip)))/sqrt(num_uniq_zip)
se_bs<-sd(res_bs_boots)*sqrt(floor(2*sqrt(num_uniq_zip)))/sqrt(num_uniq_zip)

se_vi_bs<-as.data.frame(rbind(se_park,se_ndvi,se_bs))
colnames(se_vi_bs)<-"se"
se_vi_bs$model<-c("model 5")
se_vi_bs$quintile<-c("qpm25 1")
se_vi_bs$out<-c("cvd")
se_vi_bs$exposure<-c("park","ndvi_summer","occur_bs_1000m")

write.csv(se_vi_bs,"/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_pm25_q1_cvd.xlsx")

######################################################################
##################### m-out-n bootstrapping ##########################
######################################################################
sub<-dataplot[dataplot$qpm25=="(8.52,11]",]
dataplot_boots.list<-split(sub, list(sub$zip))
num_uniq_zip <- length(unique(sub$zip))

###model main#############################################################################
print("boots model5")
res_park_boots<-NULL
res_ndvi_boots<-NULL
res_bs_boots<-NULL

Sys.time()
for (boots_id in 1:250){
  set.seed(boots_id)
  zip_sample<-sample(1:num_uniq_zip,floor(2*sqrt(num_uniq_zip)),replace=T)  
  
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
se_park<-sd(res_park_boots)*sqrt(floor(2*sqrt(num_uniq_zip)))/sqrt(num_uniq_zip)
se_ndvi<-sd(res_ndvi_boots)*sqrt(floor(2*sqrt(num_uniq_zip)))/sqrt(num_uniq_zip)
se_bs<-sd(res_bs_boots)*sqrt(floor(2*sqrt(num_uniq_zip)))/sqrt(num_uniq_zip)

se_vi_bs<-as.data.frame(rbind(se_park,se_ndvi,se_bs))
colnames(se_vi_bs)<-"se"
se_vi_bs$model<-c("model 5")
se_vi_bs$quintile<-c("qpm25 2")
se_vi_bs$out<-c("cvd")
se_vi_bs$exposure<-c("park","ndvi_summer","occur_bs_1000m")

write.csv(se_vi_bs,"/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_pm25_q2_cvd.xlsx")

######################################################################
##################### m-out-n bootstrapping ##########################
######################################################################
sub<-dataplot[dataplot$qpm25=="(11,30.9]",]
dataplot_boots.list<-split(sub, list(sub$zip))
num_uniq_zip <- length(unique(sub$zip))

###model main#############################################################################
print("boots model5")
res_park_boots<-NULL
res_ndvi_boots<-NULL
res_bs_boots<-NULL

Sys.time()
for (boots_id in 1:250){
  set.seed(boots_id)
  zip_sample<-sample(1:num_uniq_zip,floor(2*sqrt(num_uniq_zip)),replace=T)  
  
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
se_park<-sd(res_park_boots)*sqrt(floor(2*sqrt(num_uniq_zip)))/sqrt(num_uniq_zip)
se_ndvi<-sd(res_ndvi_boots)*sqrt(floor(2*sqrt(num_uniq_zip)))/sqrt(num_uniq_zip)
se_bs<-sd(res_bs_boots)*sqrt(floor(2*sqrt(num_uniq_zip)))/sqrt(num_uniq_zip)

se_vi_bs<-as.data.frame(rbind(se_park,se_ndvi,se_bs))
colnames(se_vi_bs)<-"se"
se_vi_bs$model<-c("model 5")
se_vi_bs$quintile<-c("qpm25 3")
se_vi_bs$out<-c("cvd")
se_vi_bs$exposure<-c("park","ndvi_summer","occur_bs_1000m")

write.csv(se_vi_bs,"/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_pm25_q3_cvd.xlsx")

######################################################################
##################### m-out-n bootstrapping ##########################
######################################################################
sub<-dataplot[dataplot$qno2=="[0.0108,12.7]",]
dataplot_boots.list<-split(sub, list(sub$zip))
num_uniq_zip <- length(unique(sub$zip))

###model main#############################################################################
print("boots model5")
res_park_boots<-NULL
res_ndvi_boots<-NULL
res_bs_boots<-NULL

Sys.time()
for (boots_id in 1:250){
  set.seed(boots_id)
  zip_sample<-sample(1:num_uniq_zip,floor(2*sqrt(num_uniq_zip)),replace=T)  
  
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
se_park<-sd(res_park_boots)*sqrt(floor(2*sqrt(num_uniq_zip)))/sqrt(num_uniq_zip)
se_ndvi<-sd(res_ndvi_boots)*sqrt(floor(2*sqrt(num_uniq_zip)))/sqrt(num_uniq_zip)
se_bs<-sd(res_bs_boots)*sqrt(floor(2*sqrt(num_uniq_zip)))/sqrt(num_uniq_zip)

se_vi_bs<-as.data.frame(rbind(se_park,se_ndvi,se_bs))
colnames(se_vi_bs)<-"se"
se_vi_bs$model<-c("model 5")
se_vi_bs$quintile<-c("qno2 1")
se_vi_bs$out<-c("cvd")
se_vi_bs$exposure<-c("park","ndvi_summer","occur_bs_1000m")

write.csv(se_vi_bs,"/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_no2_q1_cvd.xlsx")

######################################################################
##################### m-out-n bootstrapping ##########################
######################################################################
sub<-dataplot[dataplot$qno2=="(12.7,21.8]",]
dataplot_boots.list<-split(sub, list(sub$zip))
num_uniq_zip <- length(unique(sub$zip))

###model main#############################################################################
print("boots model5")
res_park_boots<-NULL
res_ndvi_boots<-NULL
res_bs_boots<-NULL

Sys.time()
for (boots_id in 1:250){
  set.seed(boots_id)
  zip_sample<-sample(1:num_uniq_zip,floor(2*sqrt(num_uniq_zip)),replace=T)  
  
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
se_park<-sd(res_park_boots)*sqrt(floor(2*sqrt(num_uniq_zip)))/sqrt(num_uniq_zip)
se_ndvi<-sd(res_ndvi_boots)*sqrt(floor(2*sqrt(num_uniq_zip)))/sqrt(num_uniq_zip)
se_bs<-sd(res_bs_boots)*sqrt(floor(2*sqrt(num_uniq_zip)))/sqrt(num_uniq_zip)

se_vi_bs<-as.data.frame(rbind(se_park,se_ndvi,se_bs))
colnames(se_vi_bs)<-"se"
se_vi_bs$model<-c("model 5")
se_vi_bs$quintile<-c("qno2 2")
se_vi_bs$out<-c("cvd")
se_vi_bs$exposure<-c("park","ndvi_summer","occur_bs_1000m")

write.csv(se_vi_bs,"/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_no2_q2_cvd.xlsx")

######################################################################
##################### m-out-n bootstrapping ##########################
######################################################################
sub<-dataplot[dataplot$qno2=="(21.8,128]",]
dataplot_boots.list<-split(sub, list(sub$zip))
num_uniq_zip <- length(unique(sub$zip))

###model main#############################################################################
print("boots model5")
res_park_boots<-NULL
res_ndvi_boots<-NULL
res_bs_boots<-NULL

Sys.time()
for (boots_id in 1:250){
  set.seed(boots_id)
  zip_sample<-sample(1:num_uniq_zip,floor(2*sqrt(num_uniq_zip)),replace=T)  
  
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
se_park<-sd(res_park_boots)*sqrt(floor(2*sqrt(num_uniq_zip)))/sqrt(num_uniq_zip)
se_ndvi<-sd(res_ndvi_boots)*sqrt(floor(2*sqrt(num_uniq_zip)))/sqrt(num_uniq_zip)
se_bs<-sd(res_bs_boots)*sqrt(floor(2*sqrt(num_uniq_zip)))/sqrt(num_uniq_zip)

se_vi_bs<-as.data.frame(rbind(se_park,se_ndvi,se_bs))
colnames(se_vi_bs)<-"se"
se_vi_bs$model<-c("model 5")
se_vi_bs$quintile<-c("qno2 3")
se_vi_bs$out<-c("cvd")
se_vi_bs$exposure<-c("park","ndvi_summer","occur_bs_1000m")

write.csv(se_vi_bs,"/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_no2_q3_cvd.xlsx")

