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
                                 "smoke_rate","summer_tmmx","summer_sph","summer_pr",
                                 "ndvi_summer","occur_bs_1000m","park"), as.data.table = T)

#get only urban zipcodes
dataplot$medianhousevalue<-dataplot$medianhousevalue/10000
dataplot$medhouseholdincome<-dataplot$medhouseholdincome/1000
dataplot<-na.omit(dataplot)
nrow(dataplot)

#create quintiles
setDT(dataplot)
dataplot$popdensity_dec<-quantcut(dataplot$popdensity,8)
table(dataplot$popdensity_dec)

#model 5
print("model 5 popdens 1")
Sys.time()
model<-gnm(hosp~park+ndvi_summer+occur_bs_1000m+
             as.factor(year)+as.factor(region4)+
             medhouseholdincome+medianhousevalue+poverty+education+pct_owner_occ+hispanic+pct_blk+
             #popdensity+
             smoke_rate+
             summer_tmmx+summer_sph+summer_pr+
             offset(log(time_count)),
           eliminate=(as.factor(sex):as.factor(race):as.factor(dual):as.factor(age_entry):as.factor(followupyear)),
           data=dataplot[dataplot$popdensity_dec=="[0,34.9]",],family=poisson(link="log"))
Sys.time()
print("model finished")
serr<-as.data.frame(model$coefficients[1:3])
colnames(serr)<-"Beta"
serr$model<-c("model 5")
serr$out<-c("cvd")
serr$strata<-c("q_popdens 1")
serr$exposure<-rownames(serr)
write.csv(serr,file="/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/popdens_oct1_cvd.xlsx")

#model 5
print("model 5 popdens 2")
Sys.time()
model<-gnm(hosp~park+ndvi_summer+occur_bs_1000m+
             as.factor(year)+as.factor(region4)+
             medhouseholdincome+medianhousevalue+poverty+education+pct_owner_occ+hispanic+pct_blk+
             #popdensity+
             smoke_rate+
             summer_tmmx+summer_sph+summer_pr+
             offset(log(time_count)),
           eliminate=(as.factor(sex):as.factor(race):as.factor(dual):as.factor(age_entry):as.factor(followupyear)),
           data=dataplot[dataplot$popdensity_dec=="(34.9,86.1]",],family=poisson(link="log"))
Sys.time()
print("model finished")
serr<-as.data.frame(model$coefficients[1:3])
colnames(serr)<-"Beta"
serr$model<-c("model 5")
serr$out<-c("cvd")
serr$strata<-c("q_popdens 2")
serr$exposure<-rownames(serr)
write.csv(serr,file="/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/popdens_oct2_cvd.xlsx")

#model 5
print("model 5 popdens 3")
Sys.time()
model<-gnm(hosp~park+ndvi_summer+occur_bs_1000m+
             as.factor(year)+as.factor(region4)+
             medhouseholdincome+medianhousevalue+poverty+education+pct_owner_occ+hispanic+pct_blk+
             #popdensity+
             smoke_rate+
             summer_tmmx+summer_sph+summer_pr+
             offset(log(time_count)),
           eliminate=(as.factor(sex):as.factor(race):as.factor(dual):as.factor(age_entry):as.factor(followupyear)),
           data=dataplot[dataplot$popdensity_dec=="(86.1,224]",],family=poisson(link="log"))
Sys.time()
print("model finished")
serr<-as.data.frame(model$coefficients[1:3])
colnames(serr)<-"Beta"
serr$model<-c("model 5")
serr$out<-c("cvd")
serr$strata<-c("q_popdens 3")
serr$exposure<-rownames(serr)
write.csv(serr,file="/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/popdens_oct3_cvd.xlsx")

#model 5
print("model 5 popdens 4")
Sys.time()
model<-gnm(hosp~park+ndvi_summer+occur_bs_1000m+
             as.factor(year)+as.factor(region4)+
             medhouseholdincome+medianhousevalue+poverty+education+pct_owner_occ+hispanic+pct_blk+
             #popdensity+
             smoke_rate+
             summer_tmmx+summer_sph+summer_pr+
             offset(log(time_count)),
           eliminate=(as.factor(sex):as.factor(race):as.factor(dual):as.factor(age_entry):as.factor(followupyear)),
           data=dataplot[dataplot$popdensity_dec=="(224,629]",],family=poisson(link="log"))
Sys.time()
print("model finished")
serr<-as.data.frame(model$coefficients[1:3])
colnames(serr)<-"Beta"
serr$model<-c("model 5")
serr$out<-c("cvd")
serr$strata<-c("q_popdens 4")
serr$exposure<-rownames(serr)
write.csv(serr,file="/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/popdens_oct4_cvd.xlsx")

#model 5
print("model 5 popdens 5")
Sys.time()
model<-gnm(hosp~park+ndvi_summer+occur_bs_1000m+
             as.factor(year)+as.factor(region4)+
             medhouseholdincome+medianhousevalue+poverty+education+pct_owner_occ+hispanic+pct_blk+
             #popdensity+
             smoke_rate+
             summer_tmmx+summer_sph+summer_pr+
             offset(log(time_count)),
           eliminate=(as.factor(sex):as.factor(race):as.factor(dual):as.factor(age_entry):as.factor(followupyear)),
           data=dataplot[dataplot$popdensity_dec=="(629,1.64e+03]",],family=poisson(link="log"))
Sys.time()
print("model finished")
serr<-as.data.frame(model$coefficients[1:3])
colnames(serr)<-"Beta"
serr$model<-c("model 5")
serr$out<-c("cvd")
serr$strata<-c("q_popdens 5")
serr$exposure<-rownames(serr)
write.csv(serr,file="/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/popdens_oct5_cvd.xlsx")

#model 5
print("model 5 popdens 6")
Sys.time()
model<-gnm(hosp~park+ndvi_summer+occur_bs_1000m+
             as.factor(year)+as.factor(region4)+
             medhouseholdincome+medianhousevalue+poverty+education+pct_owner_occ+hispanic+pct_blk+
             #popdensity+
             smoke_rate+
             summer_tmmx+summer_sph+summer_pr+
             offset(log(time_count)),
           eliminate=(as.factor(sex):as.factor(race):as.factor(dual):as.factor(age_entry):as.factor(followupyear)),
           data=dataplot[dataplot$popdensity_dec=="(1.64e+03,3.16e+03]",],family=poisson(link="log"))
Sys.time()
print("model finished")
serr<-as.data.frame(model$coefficients[1:3])
colnames(serr)<-"Beta"
serr$model<-c("model 5")
serr$out<-c("cvd")
serr$strata<-c("q_popdens 6")
serr$exposure<-rownames(serr)
write.csv(serr,file="/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/popdens_oct6_cvd.xlsx")

#model 5
print("model 5 popdens 7")
Sys.time()
model<-gnm(hosp~park+ndvi_summer+occur_bs_1000m+
             as.factor(year)+as.factor(region4)+
             medhouseholdincome+medianhousevalue+poverty+education+pct_owner_occ+hispanic+pct_blk+
             #popdensity+
             smoke_rate+
             summer_tmmx+summer_sph+summer_pr+
             offset(log(time_count)),
           eliminate=(as.factor(sex):as.factor(race):as.factor(dual):as.factor(age_entry):as.factor(followupyear)),
           data=dataplot[dataplot$popdensity_dec=="(3.16e+03,5.8e+03]",],family=poisson(link="log"))
Sys.time()
print("model finished")
serr<-as.data.frame(model$coefficients[1:3])
colnames(serr)<-"Beta"
serr$model<-c("model 5")
serr$out<-c("cvd")
serr$strata<-c("q_popdens 7")
serr$exposure<-rownames(serr)
write.csv(serr,file="/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/popdens_oct7_cvd.xlsx")

#model 5
print("model 5 popdens 8")
Sys.time()
model<-gnm(hosp~park+ndvi_summer+occur_bs_1000m+
             as.factor(year)+as.factor(region4)+
             medhouseholdincome+medianhousevalue+poverty+education+pct_owner_occ+hispanic+pct_blk+
             #popdensity+
             smoke_rate+
             summer_tmmx+summer_sph+summer_pr+
             offset(log(time_count)),
           eliminate=(as.factor(sex):as.factor(race):as.factor(dual):as.factor(age_entry):as.factor(followupyear)),
           data=dataplot[dataplot$popdensity_dec=="(5.8e+03,1.54e+05]",],family=poisson(link="log"))
Sys.time()
print("model finished")
serr<-as.data.frame(model$coefficients[1:3])
colnames(serr)<-"Beta"
serr$model<-c("model 5")
serr$out<-c("cvd")
serr$strata<-c("q_popdens 8")
serr$exposure<-rownames(serr)
write.csv(serr,file="/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/popdens_oct8_cvd.xlsx")
