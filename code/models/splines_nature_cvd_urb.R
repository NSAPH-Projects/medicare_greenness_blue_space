#install.packages("coxme")
library("fst")
library("writexl")
library("splines")
library("gnm")
library("writexl")
library("data.table")
library("lmtest")

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
dataplot<-dataplot[popdensity>=1000,]
dataplot$medianhousevalue<-dataplot$medianhousevalue/10000
dataplot$medhouseholdincome<-dataplot$medhouseholdincome/1000
dataplot<-na.omit(dataplot)
nrow(dataplot)

#########################################################################################################
##########################################splines########################################################
#########################################################################################################

#ndvi blue space 2df
print("park 2df model")
model<-gnm(hosp~ns(park,df=2)+ndvi_summer+occur_bs_1000m+
             as.factor(year)+as.factor(region4)+
             medhouseholdincome+medianhousevalue+poverty+education+pct_owner_occ+hispanic+pct_blk+
             popdensity+
             smoke_rate+
             summer_tmmx+summer_sph+summer_pr+
             offset(log(time_count)),
           eliminate=(as.factor(sex):as.factor(race):as.factor(dual):as.factor(age_entry):as.factor(followupyear)),
           data=dataplot,family=poisson(link="log"))

#predict exp-resp curve
stats<-cbind(AIC(model),BIC(model))
colnames(stats)<-c("AIC","BIC")
write.csv(stats,file="/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/park_2df_sim_stats_cvd_urb.xlsx")
print("predict model")
pred <- predict(model, type='terms', terms=2)
rm(model)
print("bind data")
curve.park<-data.frame(cbind(dataplot$park, pred[,1]))
print("get unique values")
curve.park<-curve.park[!duplicated(curve.park), ]
colnames(curve.park)<-c("exp","pred")
curve.park<-curve.park[order(curve.park$exp),]
write.csv(curve.park,file="/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/park_2df_sim_curve_cvd_urb.xlsx")
rm(curve.park)

#ndvi blue space 2df
print("ndvi 2df model")
model<-gnm(hosp~ns(ndvi_summer,df=2)+park+occur_bs_1000m+
             as.factor(year)+as.factor(region4)+
             medhouseholdincome+medianhousevalue+poverty+education+pct_owner_occ+hispanic+pct_blk+
             popdensity+
             smoke_rate+
             summer_tmmx+summer_sph+summer_pr+
             offset(log(time_count)),
           eliminate=(as.factor(sex):as.factor(race):as.factor(dual):as.factor(age_entry):as.factor(followupyear)),
           data=dataplot,family=poisson(link="log"))

#predict exp-resp curve
stats<-cbind(AIC(model),BIC(model))
colnames(stats)<-c("AIC","BIC")
write.csv(stats,file="/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/ndvi_2df_sim_stats_cvd_urb.xlsx")
print("predict model")
pred <- predict(model, type='terms', terms=2)
rm(model)
print("bind data")
curve.park<-data.frame(cbind(dataplot$ndvi_summer, pred[,1]))
print("get unique values")
curve.park<-curve.park[!duplicated(curve.park), ]
colnames(curve.park)<-c("exp","pred")
curve.park<-curve.park[order(curve.park$exp),]
write.csv(curve.park,file="/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/ndvi_2df_sim_curve_cvd_urb.xlsx")
rm(curve.park)

#ndvi blue space 2df
print("blue space 2df model")
model<-gnm(hosp~ns(occur_bs_1000m,df=2)+park+ndvi_summer+
             as.factor(year)+as.factor(region4)+
             medhouseholdincome+medianhousevalue+poverty+education+pct_owner_occ+hispanic+pct_blk+
             popdensity+
             smoke_rate+
             summer_tmmx+summer_sph+summer_pr+
             offset(log(time_count)),
           eliminate=(as.factor(sex):as.factor(race):as.factor(dual):as.factor(age_entry):as.factor(followupyear)),
           data=dataplot,family=poisson(link="log"))

#predict exp-resp curve
stats<-cbind(AIC(model),BIC(model))
colnames(stats)<-c("AIC","BIC")
write.csv(stats,file="/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/blue_2df_sim_stats_cvd_urb.xlsx")
print("predict model")
pred <- predict(model, type='terms', terms=2)
rm(model)
print("bind data")
curve.park<-data.frame(cbind(dataplot$occur_bs_1000m, pred[,1]))
print("get unique values")
curve.park<-curve.park[!duplicated(curve.park), ]
colnames(curve.park)<-c("exp","pred")
curve.park<-curve.park[order(curve.park$exp),]
write.csv(curve.park,file="/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/blue_2df_sim_curve_cvd_urb.xlsx")
rm(curve.park)


#ndvi blue space 3df
print("park 3df model")
model<-gnm(hosp~ns(park,df=3)+ndvi_summer+occur_bs_1000m+
             as.factor(year)+as.factor(region4)+
             medhouseholdincome+medianhousevalue+poverty+education+pct_owner_occ+hispanic+pct_blk+
             popdensity+
             smoke_rate+
             summer_tmmx+summer_sph+summer_pr+
             offset(log(time_count)),
           eliminate=(as.factor(sex):as.factor(race):as.factor(dual):as.factor(age_entry):as.factor(followupyear)),
           data=dataplot,family=poisson(link="log"))

#predict exp-resp curve
stats<-cbind(AIC(model),BIC(model))
colnames(stats)<-c("AIC","BIC")
write.csv(stats,file="/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/park_3df_sim_stats_cvd_urb.xlsx")
print("predict model")
pred <- predict(model, type='terms', terms=2)
rm(model)
print("bind data")
curve.park<-data.frame(cbind(dataplot$park, pred[,1]))
print("get unique values")
curve.park<-curve.park[!duplicated(curve.park), ]
colnames(curve.park)<-c("exp","pred")
curve.park<-curve.park[order(curve.park$exp),]
write.csv(curve.park,file="/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/park_3df_sim_curve_cvd_urb.xlsx")
rm(curve.park)

#ndvi blue space 3df
print("ndvi 3df model")
model<-gnm(hosp~ns(ndvi_summer,df=3)+park+occur_bs_1000m+
             as.factor(year)+as.factor(region4)+
             medhouseholdincome+medianhousevalue+poverty+education+pct_owner_occ+hispanic+pct_blk+
             popdensity+
             smoke_rate+
             summer_tmmx+summer_sph+summer_pr+
             offset(log(time_count)),
           eliminate=(as.factor(sex):as.factor(race):as.factor(dual):as.factor(age_entry):as.factor(followupyear)),
           data=dataplot,family=poisson(link="log"))

#predict exp-resp curve
stats<-cbind(AIC(model),BIC(model))
colnames(stats)<-c("AIC","BIC")
write.csv(stats,file="/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/ndvi_3df_sim_stats_cvd_urb.xlsx")
print("predict model")
pred <- predict(model, type='terms', terms=2)
rm(model)
print("bind data")
curve.park<-data.frame(cbind(dataplot$ndvi_summer, pred[,1]))
print("get unique values")
curve.park<-curve.park[!duplicated(curve.park), ]
colnames(curve.park)<-c("exp","pred")
curve.park<-curve.park[order(curve.park$exp),]
write.csv(curve.park,file="/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/ndvi_3df_sim_curve_cvd_urb.xlsx")
rm(curve.park)

#ndvi blue space 3df
print("blue space 3df model")
model<-gnm(hosp~ns(occur_bs_1000m,df=3)+park+ndvi_summer+
             as.factor(year)+as.factor(region4)+
             medhouseholdincome+medianhousevalue+poverty+education+pct_owner_occ+hispanic+pct_blk+
             popdensity+
             smoke_rate+
             summer_tmmx+summer_sph+summer_pr+
             offset(log(time_count)),
           eliminate=(as.factor(sex):as.factor(race):as.factor(dual):as.factor(age_entry):as.factor(followupyear)),
           data=dataplot,family=poisson(link="log"))

#predict exp-resp curve
stats<-cbind(AIC(model),BIC(model))
colnames(stats)<-c("AIC","BIC")
write.csv(stats,file="/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/blue_3df_sim_stats_cvd_urb.xlsx")
print("predict model")
pred <- predict(model, type='terms', terms=2)
rm(model)
print("bind data")
curve.park<-data.frame(cbind(dataplot$occur_bs_1000m, pred[,1]))
print("get unique values")
curve.park<-curve.park[!duplicated(curve.park), ]
colnames(curve.park)<-c("exp","pred")
curve.park<-curve.park[order(curve.park$exp),]
write.csv(curve.park,file="/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/blue_3df_sim_curve_cvd_urb.xlsx")
rm(curve.park)
