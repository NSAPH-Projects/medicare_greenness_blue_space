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
                                 "ndvi_summer","occur_bs_1000m","park",
                                 "region4"), as.data.table = T)
dataplot$medianhousevalue<-dataplot$medianhousevalue/10000
dataplot$medhouseholdincome<-dataplot$medhouseholdincome/1000
dataplot<-na.omit(dataplot)
nrow(dataplot)

midwest<-dataplot[dataplot$region4=="Midwest",]
northeast<-dataplot[dataplot$region4=="Northeast",]
south<-dataplot[dataplot$region4=="South",]
west<-dataplot[dataplot$region4=="West",]
rm(dataplot)

#########################################################################################################
##########################################splines########################################################
#########################################################################################################

#ndvi blue space 3df
print("park 3df model")
model<-gnm(hosp~ns(park,df=3)+ndvi_summer+occur_bs_1000m+
             as.factor(year)+
             medhouseholdincome+medianhousevalue+poverty+education+pct_owner_occ+hispanic+pct_blk+
             popdensity+
             smoke_rate+
             offset(log(time_count)),
           eliminate=(as.factor(sex):as.factor(race):as.factor(dual):as.factor(age_entry):as.factor(followupyear)),
           data=midwest,family=poisson(link="log"))

#predict exp-resp curve
print("predict model")
pred <- predict(model, type='terms', terms=2)
rm(model)
print("bind data")
curve.park<-data.frame(cbind(midwest$park, pred[,1]))
print("get unique values")
curve.park<-curve.park[!duplicated(curve.park), ]
colnames(curve.park)<-c("exp","pred")
curve.park<-curve.park[order(curve.park$exp),]
write.csv(curve.park,file="/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/park_3df_sim_curve_alzm4_midwest.xlsx")
rm(curve.park)

#ndvi blue space 3df
print("ndvi 3df model")
model<-gnm(hosp~ns(ndvi_summer,df=3)+park+occur_bs_1000m+
             as.factor(year)+
             medhouseholdincome+medianhousevalue+poverty+education+pct_owner_occ+hispanic+pct_blk+
             popdensity+
             smoke_rate+
             offset(log(time_count)),
           eliminate=(as.factor(sex):as.factor(race):as.factor(dual):as.factor(age_entry):as.factor(followupyear)),
           data=midwest,family=poisson(link="log"))

#predict exp-resp curve
print("predict model")
pred <- predict(model, type='terms', terms=2)
rm(model)
print("bind data")
curve.park<-data.frame(cbind(midwest$ndvi_summer, pred[,1]))
print("get unique values")
curve.park<-curve.park[!duplicated(curve.park), ]
colnames(curve.park)<-c("exp","pred")
curve.park<-curve.park[order(curve.park$exp),]
write.csv(curve.park,file="/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/ndvi_3df_sim_curve_alzm4_midwest.xlsx")
rm(curve.park)

#ndvi blue space 3df
print("blue space 3df model")
model<-gnm(hosp~ns(occur_bs_1000m,df=3)+park+ndvi_summer+
             as.factor(year)+
             medhouseholdincome+medianhousevalue+poverty+education+pct_owner_occ+hispanic+pct_blk+
             popdensity+
             smoke_rate+
             offset(log(time_count)),
           eliminate=(as.factor(sex):as.factor(race):as.factor(dual):as.factor(age_entry):as.factor(followupyear)),
           data=midwest,family=poisson(link="log"))

#predict exp-resp curve
print("predict model")
pred <- predict(model, type='terms', terms=2)
rm(model)
print("bind data")
curve.park<-data.frame(cbind(midwest$occur_bs_1000m, pred[,1]))
print("get unique values")
curve.park<-curve.park[!duplicated(curve.park), ]
colnames(curve.park)<-c("exp","pred")
curve.park<-curve.park[order(curve.park$exp),]
write.csv(curve.park,file="/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/blue_3df_sim_curve_alzm4_midwest.xlsx")
rm(curve.park)


#ndvi blue space 3df
print("park 3df model")
model<-gnm(hosp~ns(park,df=3)+ndvi_summer+occur_bs_1000m+
             as.factor(year)+
             medhouseholdincome+medianhousevalue+poverty+education+pct_owner_occ+hispanic+pct_blk+
             popdensity+
             smoke_rate+
             offset(log(time_count)),
           eliminate=(as.factor(sex):as.factor(race):as.factor(dual):as.factor(age_entry):as.factor(followupyear)),
           data=northeast,family=poisson(link="log"))

#predict exp-resp curve
print("predict model")
pred <- predict(model, type='terms', terms=2)
rm(model)
print("bind data")
curve.park<-data.frame(cbind(northeast$park, pred[,1]))
print("get unique values")
curve.park<-curve.park[!duplicated(curve.park), ]
colnames(curve.park)<-c("exp","pred")
curve.park<-curve.park[order(curve.park$exp),]
write.csv(curve.park,file="/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/park_3df_sim_curve_alzm4_northeast.xlsx")
rm(curve.park)

#ndvi blue space 3df
print("ndvi 3df model")
model<-gnm(hosp~ns(ndvi_summer,df=3)+park+occur_bs_1000m+
             as.factor(year)+
             medhouseholdincome+medianhousevalue+poverty+education+pct_owner_occ+hispanic+pct_blk+
             popdensity+
             smoke_rate+
             offset(log(time_count)),
           eliminate=(as.factor(sex):as.factor(race):as.factor(dual):as.factor(age_entry):as.factor(followupyear)),
           data=northeast,family=poisson(link="log"))

#predict exp-resp curve
print("predict model")
pred <- predict(model, type='terms', terms=2)
rm(model)
print("bind data")
curve.park<-data.frame(cbind(northeast$ndvi_summer, pred[,1]))
print("get unique values")
curve.park<-curve.park[!duplicated(curve.park), ]
colnames(curve.park)<-c("exp","pred")
curve.park<-curve.park[order(curve.park$exp),]
write.csv(curve.park,file="/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/ndvi_3df_sim_curve_alzm4_northeast.xlsx")
rm(curve.park)

#ndvi blue space 3df
print("blue space 3df model")
model<-gnm(hosp~ns(occur_bs_1000m,df=3)+park+ndvi_summer+
             as.factor(year)+
             medhouseholdincome+medianhousevalue+poverty+education+pct_owner_occ+hispanic+pct_blk+
             popdensity+
             smoke_rate+
             offset(log(time_count)),
           eliminate=(as.factor(sex):as.factor(race):as.factor(dual):as.factor(age_entry):as.factor(followupyear)),
           data=northeast,family=poisson(link="log"))

#predict exp-resp curve
print("predict model")
pred <- predict(model, type='terms', terms=2)
rm(model)
print("bind data")
curve.park<-data.frame(cbind(northeast$occur_bs_1000m, pred[,1]))
print("get unique values")
curve.park<-curve.park[!duplicated(curve.park), ]
colnames(curve.park)<-c("exp","pred")
curve.park<-curve.park[order(curve.park$exp),]
write.csv(curve.park,file="/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/blue_3df_sim_curve_alzm4_northeast.xlsx")
rm(curve.park)


#ndvi blue space 3df
print("park 3df model")
model<-gnm(hosp~ns(park,df=3)+ndvi_summer+occur_bs_1000m+
             as.factor(year)+
             medhouseholdincome+medianhousevalue+poverty+education+pct_owner_occ+hispanic+pct_blk+
             popdensity+
             smoke_rate+
             offset(log(time_count)),
           eliminate=(as.factor(sex):as.factor(race):as.factor(dual):as.factor(age_entry):as.factor(followupyear)),
           data=south,family=poisson(link="log"))

#predict exp-resp curve
print("predict model")
pred <- predict(model, type='terms', terms=2)
rm(model)
print("bind data")
curve.park<-data.frame(cbind(south$park, pred[,1]))
print("get unique values")
curve.park<-curve.park[!duplicated(curve.park), ]
colnames(curve.park)<-c("exp","pred")
curve.park<-curve.park[order(curve.park$exp),]
write.csv(curve.park,file="/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/park_3df_sim_curve_alzm4_south.xlsx")
rm(curve.park)

#ndvi blue space 3df
print("ndvi 3df model")
model<-gnm(hosp~ns(ndvi_summer,df=3)+park+occur_bs_1000m+
             as.factor(year)+
             medhouseholdincome+medianhousevalue+poverty+education+pct_owner_occ+hispanic+pct_blk+
             popdensity+
             smoke_rate+
             offset(log(time_count)),
           eliminate=(as.factor(sex):as.factor(race):as.factor(dual):as.factor(age_entry):as.factor(followupyear)),
           data=south,family=poisson(link="log"))

#predict exp-resp curve
print("predict model")
pred <- predict(model, type='terms', terms=2)
rm(model)
print("bind data")
curve.park<-data.frame(cbind(south$ndvi_summer, pred[,1]))
print("get unique values")
curve.park<-curve.park[!duplicated(curve.park), ]
colnames(curve.park)<-c("exp","pred")
curve.park<-curve.park[order(curve.park$exp),]
write.csv(curve.park,file="/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/ndvi_3df_sim_curve_alzm4_south.xlsx")
rm(curve.park)

#ndvi blue space 3df
print("blue space 3df model")
model<-gnm(hosp~ns(occur_bs_1000m,df=3)+park+ndvi_summer+
             as.factor(year)+
             medhouseholdincome+medianhousevalue+poverty+education+pct_owner_occ+hispanic+pct_blk+
             popdensity+
             smoke_rate+
             offset(log(time_count)),
           eliminate=(as.factor(sex):as.factor(race):as.factor(dual):as.factor(age_entry):as.factor(followupyear)),
           data=south,family=poisson(link="log"))

#predict exp-resp curve
print("predict model")
pred <- predict(model, type='terms', terms=2)
rm(model)
print("bind data")
curve.park<-data.frame(cbind(south$occur_bs_1000m, pred[,1]))
print("get unique values")
curve.park<-curve.park[!duplicated(curve.park), ]
colnames(curve.park)<-c("exp","pred")
curve.park<-curve.park[order(curve.park$exp),]
write.csv(curve.park,file="/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/blue_3df_sim_curve_alzm4_south.xlsx")
rm(curve.park)



#ndvi blue space 3df
print("park 3df model")
model<-gnm(hosp~ns(park,df=3)+ndvi_summer+occur_bs_1000m+
             as.factor(year)+
             medhouseholdincome+medianhousevalue+poverty+education+pct_owner_occ+hispanic+pct_blk+
             popdensity+
             smoke_rate+
             offset(log(time_count)),
           eliminate=(as.factor(sex):as.factor(race):as.factor(dual):as.factor(age_entry):as.factor(followupyear)),
           data=west,family=poisson(link="log"))

#predict exp-resp curve
print("predict model")
pred <- predict(model, type='terms', terms=2)
rm(model)
print("bind data")
curve.park<-data.frame(cbind(west$park, pred[,1]))
print("get unique values")
curve.park<-curve.park[!duplicated(curve.park), ]
colnames(curve.park)<-c("exp","pred")
curve.park<-curve.park[order(curve.park$exp),]
write.csv(curve.park,file="/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/park_3df_sim_curve_alzm4_west.xlsx")
rm(curve.park)

#ndvi blue space 3df
print("ndvi 3df model")
model<-gnm(hosp~ns(ndvi_summer,df=3)+park+occur_bs_1000m+
             as.factor(year)+
             medhouseholdincome+medianhousevalue+poverty+education+pct_owner_occ+hispanic+pct_blk+
             popdensity+
             smoke_rate+
             offset(log(time_count)),
           eliminate=(as.factor(sex):as.factor(race):as.factor(dual):as.factor(age_entry):as.factor(followupyear)),
           data=west,family=poisson(link="log"))

#predict exp-resp curve
print("predict model")
pred <- predict(model, type='terms', terms=2)
rm(model)
print("bind data")
curve.park<-data.frame(cbind(west$ndvi_summer, pred[,1]))
print("get unique values")
curve.park<-curve.park[!duplicated(curve.park), ]
colnames(curve.park)<-c("exp","pred")
curve.park<-curve.park[order(curve.park$exp),]
write.csv(curve.park,file="/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/ndvi_3df_sim_curve_alzm4_west.xlsx")
rm(curve.park)

#ndvi blue space 3df
print("blue space 3df model")
model<-gnm(hosp~ns(occur_bs_1000m,df=3)+park+ndvi_summer+
             as.factor(year)+
             medhouseholdincome+medianhousevalue+poverty+education+pct_owner_occ+hispanic+pct_blk+
             popdensity+
             smoke_rate+
             offset(log(time_count)),
           eliminate=(as.factor(sex):as.factor(race):as.factor(dual):as.factor(age_entry):as.factor(followupyear)),
           data=west,family=poisson(link="log"))

#predict exp-resp curve
print("predict model")
pred <- predict(model, type='terms', terms=2)
rm(model)
print("bind data")
curve.park<-data.frame(cbind(west$occur_bs_1000m, pred[,1]))
print("get unique values")
curve.park<-curve.park[!duplicated(curve.park), ]
colnames(curve.park)<-c("exp","pred")
curve.park<-curve.park[order(curve.park$exp),]
write.csv(curve.park,file="/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/blue_3df_sim_curve_alzm4_west.xlsx")
rm(curve.park)


