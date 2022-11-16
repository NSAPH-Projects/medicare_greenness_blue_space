#install.packages("coxme")
library("fst")
library("writexl")
library("gnm")
library("writexl")
library("data.table")
library("lmtest")

new_merged <- "/nfs/home/J/jok8845/shared_space/ci3_health_data/medicare/gen_admission/1999_2016/Klompmaker/merged_data/par2/"
dataplot <- read_fst(paste0(new_merged ,"aggregate_PAR.fst"),
                     columns = c("sex","race","age_entry","dual","followupyear",
                                 "zip","year","hosp","time_count",
                                 "poverty","popdensity",
                                 "medianhousevalue","pct_blk","medhouseholdincome","pct_owner_occ","hispanic",
                                 "education","region4","division",
                                 "smoke_rate","summer_tmmx","summer_sph","summer_pr","pm25","no2",
                                 "ndvi_summer","occur_bs","occur_bs_1000m","park"), as.data.table = T)

dataplot<-dataplot[popdensity>=1000,]
dataplot$medianhousevalue<-dataplot$medianhousevalue/10000
dataplot$medhouseholdincome<-dataplot$medhouseholdincome/1000
dataplot$occur_bs_bin<-ifelse(dataplot$occur_bs>0,1,0)
dataplot$occur_bs_1000m_bin<-ifelse(dataplot$occur_bs_1000m>=0.01,1,0)
dataplot$occur_bs_1000m_ter<-ifelse(dataplot$occur_bs_1000m>=0.05,1,0)
gc()
######################################################################
##################### m-out-n bootstrapping ##########################
######################################################################

dataplot_boots.list<-split(dataplot, list(dataplot$zip))
num_uniq_zip <- length(unique(dataplot$zip))

###model main#############################################################################
print("boots model4")
res_park_boots<-NULL
#res_ndvi_boots<-NULL
#res_bs_boots<-NULL

Sys.time()
for (boots_id in 1:500){
  set.seed(boots_id)
  zip_sample<-sample(1:num_uniq_zip,floor(2*sqrt(num_uniq_zip)),replace=T)  
  
  dataplot_boots<-data.frame(Reduce(rbind,dataplot_boots.list[zip_sample]))
  
  Sys.time()
  model<-gnm(hosp~park+#ndvi_summer+as.factor(occur_bs_1000m_bin)+
               as.factor(year)+as.factor(region4)+
               medhouseholdincome+medianhousevalue+poverty+education+pct_owner_occ+hispanic+pct_blk+
               popdensity+
               smoke_rate+
               offset(log(time_count)),
             eliminate=(as.factor(sex):as.factor(race):as.factor(dual):as.factor(age_entry):as.factor(followupyear)),
             data=dataplot,family=poisson(link="log"))
  
  res_park_boots<-c(res_park_boots,model$coefficients[1])
  #res_ndvi_boots<-c(res_ndvi_boots,model$coefficients[2])
  #res_bs_boots<-c(res_bs_boots,model$coefficients[3])
  
  Sys.time()
  gc()
}

#bootstrapping standard error:
se_park<-sd(res_park_boots)*sqrt(floor(2*sqrt(num_uniq_zip)))/sqrt(num_uniq_zip)
#se_ndvi<-sd(res_ndvi_boots)*sqrt(floor(2*sqrt(num_uniq_zip)))/sqrt(num_uniq_zip)
#se_bs<-sd(res_bs_boots)*sqrt(floor(2*sqrt(num_uniq_zip)))/sqrt(num_uniq_zip)

se_vi_bs<-as.data.frame(se_park)
colnames(se_vi_bs)<-"se"
se_vi_bs$model<-c("model park only")
se_vi_bs$out<-c("par")
se_vi_bs$exposure<-c("park")

write.csv(se_vi_bs,"/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/sensitivity/SE/se_m5_only_park_par_urb.xlsx")

###model main#############################################################################
print("boots model4")
#res_park_boots<-NULL
res_ndvi_boots<-NULL
#res_bs_boots<-NULL

Sys.time()
for (boots_id in 1:500){
  set.seed(boots_id)
  zip_sample<-sample(1:num_uniq_zip,floor(2*sqrt(num_uniq_zip)),replace=T)  
  
  dataplot_boots<-data.frame(Reduce(rbind,dataplot_boots.list[zip_sample]))
  
  Sys.time()
  model<-gnm(hosp~ndvi_summer+#park+as.factor(occur_bs_1000m_bin)+
               as.factor(year)+as.factor(region4)+
               medhouseholdincome+medianhousevalue+poverty+education+pct_owner_occ+hispanic+pct_blk+
               popdensity+
               smoke_rate+
               offset(log(time_count)),
             eliminate=(as.factor(sex):as.factor(race):as.factor(dual):as.factor(age_entry):as.factor(followupyear)),
             data=dataplot,family=poisson(link="log"))
  
  #res_park_boots<-c(res_park_boots,model$coefficients[1])
  res_ndvi_boots<-c(res_ndvi_boots,model$coefficients[1])
  #res_bs_boots<-c(res_bs_boots,model$coefficients[3])
  
  Sys.time()
  gc()
}

#bootstrapping standard error:
#se_park<-sd(res_park_boots)*sqrt(floor(2*sqrt(num_uniq_zip)))/sqrt(num_uniq_zip)
se_ndvi<-sd(res_ndvi_boots)*sqrt(floor(2*sqrt(num_uniq_zip)))/sqrt(num_uniq_zip)
#se_bs<-sd(res_bs_boots)*sqrt(floor(2*sqrt(num_uniq_zip)))/sqrt(num_uniq_zip)

se_vi_bs<-as.data.frame(se_ndvi)
colnames(se_vi_bs)<-"se"
se_vi_bs$model<-c("model ndvi only")
se_vi_bs$out<-c("par")
se_vi_bs$exposure<-c("ndvi_summer")

write.csv(se_vi_bs,"/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/sensitivity/SE/se_only_ndvi_par_urb.xlsx")

###model main#############################################################################
print("boots model4")
#res_park_boots<-NULL
#res_ndvi_boots<-NULL
res_bs_boots<-NULL

Sys.time()
for (boots_id in 1:500){
  set.seed(boots_id)
  zip_sample<-sample(1:num_uniq_zip,floor(2*sqrt(num_uniq_zip)),replace=T)  
  
  dataplot_boots<-data.frame(Reduce(rbind,dataplot_boots.list[zip_sample]))
  
  Sys.time()
  model<-gnm(hosp~as.factor(occur_bs_1000m_bin)+#ndvi_summer+park+
               as.factor(year)+as.factor(region4)+
               medhouseholdincome+medianhousevalue+poverty+education+pct_owner_occ+hispanic+pct_blk+
               popdensity+
               smoke_rate+
               offset(log(time_count)),
             eliminate=(as.factor(sex):as.factor(race):as.factor(dual):as.factor(age_entry):as.factor(followupyear)),
             data=dataplot,family=poisson(link="log"))
  
  #res_park_boots<-c(res_park_boots,model$coefficients[1])
  #res_ndvi_boots<-c(res_ndvi_boots,model$coefficients[2])
  res_bs_boots<-c(res_bs_boots,model$coefficients[1])
  
  Sys.time()
  gc()
}

#bootstrapping standard error:
#se_park<-sd(res_park_boots)*sqrt(floor(2*sqrt(num_uniq_zip)))/sqrt(num_uniq_zip)
#se_ndvi<-sd(res_ndvi_boots)*sqrt(floor(2*sqrt(num_uniq_zip)))/sqrt(num_uniq_zip)
se_bs<-sd(res_bs_boots)*sqrt(floor(2*sqrt(num_uniq_zip)))/sqrt(num_uniq_zip)

se_vi_bs<-as.data.frame(se_bs)
colnames(se_vi_bs)<-"se"
se_vi_bs$model<-c("model blue only")
se_vi_bs$out<-c("par")
se_vi_bs$exposure<-c("as.factor(occur_bs_1000m_bin)1")

write.csv(se_vi_bs,"/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/sensitivity/SE/se_only_blue_par_urb.xlsx")

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
               pm25+no2+
               offset(log(time_count)),
             eliminate=(as.factor(sex):as.factor(race):as.factor(dual):as.factor(age_entry):as.factor(followupyear)),
             data=dataplot,family=poisson(link="log"))
  
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
se_vi_bs$model<-c("model pm25 no2")
se_vi_bs$out<-c("par")
se_vi_bs$exposure<-c("park","ndvi_summer","as.factor(occur_bs_1000m_bin)1")

write.csv(se_vi_bs,"/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/sensitivity/SE/se_pm25_no2_par_urb.xlsx")
