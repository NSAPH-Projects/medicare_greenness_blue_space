#install.packages("coxme")
library("fst")
library("writexl")
library("gnm")
library("writexl")
library("data.table")
library("lmtest")

new_merged <- "/nfs/home/J/jok8845/shared_space/ci3_health_data/medicare/gen_admission/1999_2016/Klompmaker/merged_data/par2/"
dir_out <- "/nfs/home/J/jok8845/shared_space/ci3_analysis/medicare_temperature_humidity/Modeloutput/"
#dataplot <- read_fst(paste0(new_merged ,"sample.fst"),
dataplot <- read_fst(paste0(new_merged ,"aggregate_PAR.fst"),
                     columns = c("sex","race","age_entry","dual","followupyear",
                                 "zip","year","hosp","time_count",
                                 "poverty","popdensity",
                                 "medianhousevalue","pct_blk","medhouseholdincome","pct_owner_occ","hispanic",
                                 "education",
                                 "smoke_rate","region4",
                                 "ndvi_summer","occur_bs_1000m","park"), as.data.table = T)
dataplot<-dataplot[popdensity>=1000,]
dataplot$medianhousevalue<-dataplot$medianhousevalue/10000
dataplot$medhouseholdincome<-dataplot$medhouseholdincome/1000
dataplot<-na.omit(dataplot)
nrow(dataplot)
dataplot$occur_bs_1000m_bin<-ifelse(dataplot$occur_bs_1000m>=0.01,1,0)

######################################################################
##################### m-out-n bootstrapping ##########################
######################################################################

dataplot_boots.list<-split(dataplot, list(dataplot$zip))
num_uniq_zip <- length(unique(dataplot$zip))

###model main#############################################################################
print("boots model1")
res_park_boots<-NULL
res_ndvi_boots<-NULL
res_bs_boots<-NULL

Sys.time()
for (boots_id in 1:500){
  set.seed(boots_id)
  zip_sample<-sample(1:num_uniq_zip,floor(2*sqrt(num_uniq_zip)),replace=T)  
  
  dataplot_boots<-data.frame(Reduce(rbind,dataplot_boots.list[zip_sample]))
  
  Sys.time()
  model<-gnm(hosp~park+ndvi_summer+as.factor(occur_bs_1000m_bin)+
               as.factor(year)+as.factor(region4)+
               #medhouseholdincome+medianhousevalue+poverty+education+pct_owner_occ+hispanic+pct_blk+
               #popdensity+
               #mean_bmi+smoke_rate+
               #summer_tmmx+summer_sph+summer_pr+
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
se_vi_bs$model<-c("model 1")
se_vi_bs$out<-c("par")
se_vi_bs$exposure<-c("park","ndvi_summer","as.factor(occur_bs_1000m_bin)1")

write.csv(se_vi_bs,"/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_m1_par_urb.xlsx")


###model main#############################################################################
print("boots model2")
res_park_boots<-NULL
res_ndvi_boots<-NULL
res_bs_boots<-NULL

Sys.time()
for (boots_id in 1:500){
  set.seed(boots_id)
  zip_sample<-sample(1:num_uniq_zip,floor(2*sqrt(num_uniq_zip)),replace=T)  
  
  dataplot_boots<-data.frame(Reduce(rbind,dataplot_boots.list[zip_sample]))
  
  Sys.time()
  model<-gnm(hosp~park+ndvi_summer+as.factor(occur_bs_1000m_bin)+
               as.factor(year)+as.factor(region4)+
               medhouseholdincome+medianhousevalue+poverty+education+pct_owner_occ+hispanic+pct_blk+
               #popdensity+
               #mean_bmi+smoke_rate+
               #summer_tmmx+summer_sph+summer_pr+
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
se_vi_bs$model<-c("model 2")
se_vi_bs$out<-c("par")
se_vi_bs$exposure<-c("park","ndvi_summer","as.factor(occur_bs_1000m_bin)1")

write.csv(se_vi_bs,"/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_m2_par_urb.xlsx")


###model main#############################################################################
print("boots model3")
res_park_boots<-NULL
res_ndvi_boots<-NULL
res_bs_boots<-NULL

Sys.time()
for (boots_id in 1:500){
  set.seed(boots_id)
  zip_sample<-sample(1:num_uniq_zip,floor(2*sqrt(num_uniq_zip)),replace=T)  
  
  dataplot_boots<-data.frame(Reduce(rbind,dataplot_boots.list[zip_sample]))
  
  Sys.time()
  model<-gnm(hosp~park+ndvi_summer+as.factor(occur_bs_1000m_bin)+
               as.factor(year)+as.factor(region4)+
               medhouseholdincome+medianhousevalue+poverty+education+pct_owner_occ+hispanic+pct_blk+
               popdensity+
               #mean_bmi+smoke_rate+
               #summer_tmmx+summer_sph+summer_pr+
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
se_vi_bs$model<-c("model 3")
se_vi_bs$out<-c("par")
se_vi_bs$exposure<-c("park","ndvi_summer","as.factor(occur_bs_1000m_bin)1")

write.csv(se_vi_bs,"/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_m3_par_urb.xlsx")


###model main#############################################################################
print("boots model4")
res_park_boots<-NULL
res_ndvi_boots<-NULL
res_bs_boots<-NULL

Sys.time()
for (boots_id in 1:500){
  set.seed(boots_id)
  zip_sample<-sample(1:num_uniq_zip,floor(2*sqrt(num_uniq_zip)),replace=T)  
  
  dataplot_boots<-data.frame(Reduce(rbind,dataplot_boots.list[zip_sample]))
  
  Sys.time()
  model<-gnm(hosp~park+ndvi_summer+as.factor(occur_bs_1000m_bin)+
               as.factor(year)+as.factor(region4)+
               medhouseholdincome+medianhousevalue+poverty+education+pct_owner_occ+hispanic+pct_blk+
               popdensity+
               smoke_rate+
               #summer_tmmx+summer_sph+summer_pr+
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
se_vi_bs$model<-c("model 4")
se_vi_bs$out<-c("par")
se_vi_bs$exposure<-c("park","ndvi_summer","as.factor(occur_bs_1000m_bin)1")

write.csv(se_vi_bs,"/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_m4_par_urb.xlsx")
