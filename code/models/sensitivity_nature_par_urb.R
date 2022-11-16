#install.packages("coxme")
library("fst")
library("writexl")
library("splines")
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

#model only ndvi
print("model only ndvi")
Sys.time()
model<-gnm(hosp~ndvi_summer+#as.factor(occur_bs_1000m_bin)+park+
             as.factor(year)+as.factor(region4)+
             medhouseholdincome+medianhousevalue+poverty+education+pct_owner_occ+hispanic+pct_blk+
             popdensity+
             smoke_rate+
             offset(log(time_count)),
           eliminate=(as.factor(sex):as.factor(race):as.factor(dual):as.factor(age_entry):as.factor(followupyear)),
           data=dataplot,family=poisson(link="log"))
Sys.time()
print("model finished")
serr<-as.data.frame(model$coefficients[1])
colnames(serr)<-"Beta"
serr$model<-c("model ndvi only")
serr$out<-c("par")
serr$exposure<-rownames(serr)
write.csv(serr,file="/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/sensitivity/m4_ndvi_only_par_urb.xlsx")
rm(model)
gc()

#model blue only
print("model blue only")
Sys.time()
model<-gnm(hosp~as.factor(occur_bs_1000m_bin)+#ndvi_summer+park+
             as.factor(year)+as.factor(region4)+
             medhouseholdincome+medianhousevalue+poverty+education+pct_owner_occ+hispanic+pct_blk+
             popdensity+
             smoke_rate+
             offset(log(time_count)),
           eliminate=(as.factor(sex):as.factor(race):as.factor(dual):as.factor(age_entry):as.factor(followupyear)),
           data=dataplot,family=poisson(link="log"))
Sys.time()
print("model finished")
serr<-as.data.frame(model$coefficients[1])
colnames(serr)<-"Beta"
serr$model<-c("model blue only")
serr$out<-c("par")
serr$exposure<-rownames(serr)
write.csv(serr,file="/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/m4_blue_only_par_urb.xlsx")
rm(model)
gc()

#model park only
print("model park only")
Sys.time()
model<-gnm(hosp~park+#ndvi_summer+as.factor(occur_bs_1000m_bin)+
             as.factor(year)+as.factor(region4)+
             medhouseholdincome+medianhousevalue+poverty+education+pct_owner_occ+hispanic+pct_blk+
             popdensity+
             smoke_rate+
             offset(log(time_count)),
           eliminate=(as.factor(sex):as.factor(race):as.factor(dual):as.factor(age_entry):as.factor(followupyear)),
           data=dataplot,family=poisson(link="log"))
Sys.time()
print("model finished")
serr<-as.data.frame(model$coefficients[1])
colnames(serr)<-"Beta"
serr$model<-c("model park only")
serr$out<-c("par")
serr$exposure<-rownames(serr)
write.csv(serr,file="/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/m4_park_only_par_urb.xlsx")
rm(model)
gc()

#model blue no buffer
print("model blue no buffer")
Sys.time()
model<-gnm(hosp~park+ndvi_summer+as.factor(occur_bs_bin)+
             as.factor(year)+as.factor(region4)+
             medhouseholdincome+medianhousevalue+poverty+education+pct_owner_occ+hispanic+pct_blk+
             popdensity+
             smoke_rate+
             offset(log(time_count)),
           eliminate=(as.factor(sex):as.factor(race):as.factor(dual):as.factor(age_entry):as.factor(followupyear)),
           data=dataplot,family=poisson(link="log"))
Sys.time()
print("model finished")
serr<-as.data.frame(model$coefficients[1:3])
colnames(serr)<-"Beta"
serr$model<-c("model blue no buffer")
serr$out<-c("par")
serr$exposure<-rownames(serr)
write.csv(serr,file="/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/m4_blue_no_buffer_par_urb.xlsx")
rm(model)
gc()

#model adjusted for pm25
print("model pm25")
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
Sys.time()
print("model finished")
serr<-as.data.frame(model$coefficients[1:3])
colnames(serr)<-"Beta"
serr$model<-c("model pm25 no2")
serr$out<-c("par")
serr$exposure<-rownames(serr)
write.csv(serr,file="/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/m4_pm25_no2_par_urb.xlsx")
rm(model)
gc()

#model adjusted for temperature humidity and precipitation
print("model temp humid precip")
Sys.time()
model<-gnm(hosp~park+ndvi_summer+as.factor(occur_bs_1000m_bin)+
             as.factor(year)+as.factor(region4)+
             medhouseholdincome+medianhousevalue+poverty+education+pct_owner_occ+hispanic+pct_blk+
             popdensity+
             smoke_rate+
             summer_tmmx+summer_sph+summer_pr+
             offset(log(time_count)),
           eliminate=(as.factor(sex):as.factor(race):as.factor(dual):as.factor(age_entry):as.factor(followupyear)),
           data=dataplot,family=poisson(link="log"))
Sys.time()
print("model finished")
serr<-as.data.frame(model$coefficients[1:3])
colnames(serr)<-"Beta"
serr$model<-c("model temp humid precip")
serr$out<-c("par")
serr$exposure<-rownames(serr)
write.csv(serr,file="/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/m4_temp_humid_precip_par_urb.xlsx")

#model not adjusted for region
print("model 5 no region")
Sys.time()
model<-gnm(hosp~park+ndvi_summer+as.factor(occur_bs_1000m_bin)+
             as.factor(year)+
             medhouseholdincome+medianhousevalue+poverty+education+pct_owner_occ+hispanic+pct_blk+
             popdensity+
             smoke_rate+
             offset(log(time_count)),
           eliminate=(as.factor(sex):as.factor(race):as.factor(dual):as.factor(age_entry):as.factor(followupyear)),
           data=dataplot,family=poisson(link="log"))
Sys.time()
print("model finished")
serr<-as.data.frame(model$coefficients[1:3])
colnames(serr)<-"Beta"
serr$model<-c("model no region")
serr$out<-c("par")
serr$exposure<-rownames(serr)
write.csv(serr,file="/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/m4_no_region_par_urb.xlsx")

#model adjusted for division instead of region
print("model division")
Sys.time()
model<-gnm(hosp~park+ndvi_summer+as.factor(occur_bs_1000m_bin)+
             as.factor(year)+as.factor(division)+
             medhouseholdincome+medianhousevalue+poverty+education+pct_owner_occ+hispanic+pct_blk+
             popdensity+
             smoke_rate+
             offset(log(time_count)),
           eliminate=(as.factor(sex):as.factor(race):as.factor(dual):as.factor(age_entry):as.factor(followupyear)),
           data=dataplot,family=poisson(link="log"))
Sys.time()
print("model finished")
serr<-as.data.frame(model$coefficients[1:3])
colnames(serr)<-"Beta"
serr$model<-c("model division")
serr$out<-c("par")
serr$exposure<-rownames(serr)
write.csv(serr,file="/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/m4_division_par_urb.xlsx")

#model with tertiary blue space 
print("model 3 blue space")
Sys.time()
model<-gnm(hosp~park+ndvi_summer+as.factor(occur_bs_1000m_ter)+
             as.factor(year)+as.factor(region4)+
             medhouseholdincome+medianhousevalue+poverty+education+pct_owner_occ+hispanic+pct_blk+
             popdensity+
             smoke_rate+
             offset(log(time_count)),
           eliminate=(as.factor(sex):as.factor(race):as.factor(dual):as.factor(age_entry):as.factor(followupyear)),
           data=dataplot,family=poisson(link="log"))
Sys.time()
print("model finished")
serr<-as.data.frame(model$coefficients[1:3])
colnames(serr)<-"Beta"
serr$model<-c("model blue space 5%")
serr$out<-c("par")
serr$exposure<-rownames(serr)
write.csv(serr,file="/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/m4_tertiary_blue_par_urb.xlsx")
