#install.packages("coxme")
library("fst")
library("writexl")
library("splines")
library("gnm")
library("writexl")
library("data.table")
library("lmtest")

new_merged <- "/nfs/home/J/jok8845/shared_space/ci3_health_data/medicare/gen_admission/1999_2016/Klompmaker/merged_data/alz2/"
dir_out <- "/nfs/home/J/jok8845/shared_space/ci3_analysis/medicare_temperature_humidity/Modeloutput/"
#dataplot <- read_fst(paste0(new_merged ,"sample.fst"),
dataplot <- read_fst(paste0(new_merged ,"aggregate_ALZ.fst"),
                     columns = c("sex","race","age_entry","dual","followupyear",
                                 "zip","year","hosp","time_count",
                                 "poverty","popdensity",
                                 "medianhousevalue","pct_blk","medhouseholdincome","pct_owner_occ","hispanic",
                                 "education","population",
                                 "smoke_rate","mean_bmi",
                                 "ndvi_summer","occur_bs_1000m","park"), as.data.table = T)
dataplot$medianhousevalue<-dataplot$medianhousevalue/10000
dataplot$medhouseholdincome<-dataplot$medhouseholdincome/1000
dataplot<-na.omit(dataplot)
nrow(dataplot)

#########################################################################################################
##########################################splines########################################################
#########################################################################################################

#ndvi blue space 2df
print("park 2df model")
model<-gnm(hosp~ns(park,df=2)+
             as.factor(year)+
             medhouseholdincome+medianhousevalue+poverty+education+pct_owner_occ+hispanic+pct_blk+
             popdensity+
             smoke_rate+
             offset(log(time_count)),
           eliminate=(as.factor(sex):as.factor(race):as.factor(dual):as.factor(age_entry):as.factor(followupyear)),
           data=dataplot,family=poisson(link="log"))

#predict exp-resp curve
stats<-cbind(AIC(model),BIC(model))
colnames(stats)<-c("AIC","BIC")
write.csv(stats,file="/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/park_2df_ind_stats_alzm4.xlsx")
print("predict model")
pred <- predict(model, type='terms', terms=2)
rm(model)
print("bind data")
curve.park<-data.frame(cbind(dataplot$park, pred[,1]))
print("get unique values")
curve.park<-curve.park[!duplicated(curve.park), ]
colnames(curve.park)<-c("exp","pred")
curve.park<-curve.park[order(curve.park$exp),]
write.csv(curve.park,file="/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/park_2df_ind_curve_alzm4.xlsx")
rm(curve.park)

#ndvi blue space 2df
print("ndvi 2df model")
model<-gnm(hosp~ns(ndvi_summer,df=2)+
             as.factor(year)+
             medhouseholdincome+medianhousevalue+poverty+education+pct_owner_occ+hispanic+pct_blk+
             popdensity+
             smoke_rate+
             offset(log(time_count)),
           eliminate=(as.factor(sex):as.factor(race):as.factor(dual):as.factor(age_entry):as.factor(followupyear)),
           data=dataplot,family=poisson(link="log"))

#predict exp-resp curve
stats<-cbind(AIC(model),BIC(model))
colnames(stats)<-c("AIC","BIC")
write.csv(stats,file="/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/ndvi_2df_ind_stats_alzm4.xlsx")
print("predict model")
pred <- predict(model, type='terms', terms=2)
rm(model)
print("bind data")
curve.park<-data.frame(cbind(dataplot$ndvi_summer, pred[,1]))
print("get unique values")
curve.park<-curve.park[!duplicated(curve.park), ]
colnames(curve.park)<-c("exp","pred")
curve.park<-curve.park[order(curve.park$exp),]
write.csv(curve.park,file="/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/ndvi_2df_ind_curve_alzm4.xlsx")
rm(curve.park)

#ndvi blue space 2df
print("blue space 2df model")
model<-gnm(hosp~ns(occur_bs_1000m,df=2)+
             as.factor(year)+
             medhouseholdincome+medianhousevalue+poverty+education+pct_owner_occ+hispanic+pct_blk+
             popdensity+
             smoke_rate+
             offset(log(time_count)),
           eliminate=(as.factor(sex):as.factor(race):as.factor(dual):as.factor(age_entry):as.factor(followupyear)),
           data=dataplot,family=poisson(link="log"))

#predict exp-resp curve
stats<-cbind(AIC(model),BIC(model))
colnames(stats)<-c("AIC","BIC")
write.csv(stats,file="/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/blue_2df_ind_stats_alzm4.xlsx")
print("predict model")
pred <- predict(model, type='terms', terms=2)
rm(model)
print("bind data")
curve.park<-data.frame(cbind(dataplot$occur_bs_1000m, pred[,1]))
print("get unique values")
curve.park<-curve.park[!duplicated(curve.park), ]
colnames(curve.park)<-c("exp","pred")
curve.park<-curve.park[order(curve.park$exp),]
write.csv(curve.park,file="/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/blue_2df_ind_curve_alzm4.xlsx")
rm(curve.park)


#ndvi blue space 3df
print("park 3df model")
model<-gnm(hosp~ns(park,df=3)+
             as.factor(year)+
             medhouseholdincome+medianhousevalue+poverty+education+pct_owner_occ+hispanic+pct_blk+
             popdensity+
             smoke_rate+
             offset(log(time_count)),
           eliminate=(as.factor(sex):as.factor(race):as.factor(dual):as.factor(age_entry):as.factor(followupyear)),
           data=dataplot,family=poisson(link="log"))

#predict exp-resp curve
stats<-cbind(AIC(model),BIC(model))
colnames(stats)<-c("AIC","BIC")
write.csv(stats,file="/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/park_3df_ind_stats_alzm4.xlsx")
print("predict model")
pred <- predict(model, type='terms', terms=2)
rm(model)
print("bind data")
curve.park<-data.frame(cbind(dataplot$park, pred[,1]))
print("get unique values")
curve.park<-curve.park[!duplicated(curve.park), ]
colnames(curve.park)<-c("exp","pred")
curve.park<-curve.park[order(curve.park$exp),]
write.csv(curve.park,file="/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/park_3df_ind_curve_alzm4.xlsx")
rm(curve.park)

#ndvi blue space 3df
print("ndvi 3df model")
model<-gnm(hosp~ns(ndvi_summer,df=3)+
             as.factor(year)+
             medhouseholdincome+medianhousevalue+poverty+education+pct_owner_occ+hispanic+pct_blk+
             popdensity+
             smoke_rate+
             offset(log(time_count)),
           eliminate=(as.factor(sex):as.factor(race):as.factor(dual):as.factor(age_entry):as.factor(followupyear)),
           data=dataplot,family=poisson(link="log"))

#predict exp-resp curve
stats<-cbind(AIC(model),BIC(model))
colnames(stats)<-c("AIC","BIC")
write.csv(stats,file="/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/ndvi_3df_ind_stats_alzm4.xlsx")
print("predict model")
pred <- predict(model, type='terms', terms=2)
rm(model)
print("bind data")
curve.park<-data.frame(cbind(dataplot$ndvi_summer, pred[,1]))
print("get unique values")
curve.park<-curve.park[!duplicated(curve.park), ]
colnames(curve.park)<-c("exp","pred")
curve.park<-curve.park[order(curve.park$exp),]
write.csv(curve.park,file="/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/ndvi_3df_ind_curve_alzm4.xlsx")
rm(curve.park)

#ndvi blue space 3df
print("blue space 3df model")
model<-gnm(hosp~ns(occur_bs_1000m,df=3)+
             as.factor(year)+
             medhouseholdincome+medianhousevalue+poverty+education+pct_owner_occ+hispanic+pct_blk+
             popdensity+
             smoke_rate+
             offset(log(time_count)),
           eliminate=(as.factor(sex):as.factor(race):as.factor(dual):as.factor(age_entry):as.factor(followupyear)),
           data=dataplot,family=poisson(link="log"))

#predict exp-resp curve
stats<-cbind(AIC(model),BIC(model))
colnames(stats)<-c("AIC","BIC")
write.csv(stats,file="/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/blue_3df_ind_stats_alzm4.xlsx")
print("predict model")
pred <- predict(model, type='terms', terms=2)
rm(model)
print("bind data")
curve.park<-data.frame(cbind(dataplot$occur_bs_1000m, pred[,1]))
print("get unique values")
curve.park<-curve.park[!duplicated(curve.park), ]
colnames(curve.park)<-c("exp","pred")
curve.park<-curve.park[order(curve.park$exp),]
write.csv(curve.park,file="/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/blue_3df_ind_curve_alzm4.xlsx")
rm(curve.park)



