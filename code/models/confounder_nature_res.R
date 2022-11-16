#install.packages("coxme")
library("fst")
library("writexl")
library("splines")
library("gnm")
library("writexl")
library("data.table")
library("lmtest")

new_merged <- "/nfs/home/J/jok8845/shared_space/ci3_health_data/medicare/gen_admission/1999_2016/Klompmaker/merged_data/res2/"
dir_out <- "/nfs/home/J/jok8845/shared_space/ci3_analysis/medicare_temperature_humidity/Modeloutput/"
#dataplot <- read_fst(paste0(new_merged ,"sample.fst"),
dataplot <- read_fst(paste0(new_merged ,"aggregate_RES.fst"),
                     columns = c("sex","race","age_entry","dual","followupyear",
                                 "zip","year","hosp","time_count",
                                 "poverty","popdensity",
                                 "medianhousevalue","pct_blk","medhouseholdincome","pct_owner_occ","hispanic",
                                 "education","region4",
                                 "smoke_rate","summer_tmmx","summer_sph","summer_pr",
                                 "ndvi_summer","occur_bs_1000m","park"), as.data.table = T)
dataplot$medianhousevalue<-dataplot$medianhousevalue/10000
dataplot$medhouseholdincome<-dataplot$medhouseholdincome/1000
dataplot<-na.omit(dataplot)
nrow(dataplot)

#model 1
print("model 1")
Sys.time()
model<-gnm(hosp~park+ndvi_summer+occur_bs_1000m+
             as.factor(year)+as.factor(region4)+
             #medhouseholdincome+medianhousevalue+poverty+education+pct_owner_occ+hispanic+pct_blk+
             #popdensity+
             #smoke_rate+
             #summer_tmmx+summer_sph+summer_pr+
             offset(log(time_count)),
           eliminate=(as.factor(sex):as.factor(race):as.factor(dual):as.factor(age_entry):as.factor(followupyear)),
           data=dataplot,family=poisson(link="log"))
Sys.time()
print("model finished")
serr<-as.data.frame(model$coefficients[1:3])
colnames(serr)<-"Beta"
serr$model<-c("model 1")
serr$out<-c("res")
serr$exposure<-c("park","ndvi_summer","occur_bs_1000m")
write.csv(serr,file="/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/m1_res.xlsx")
rm(model)
gc()

#model 2
print("model 2")
Sys.time()
model<-gnm(hosp~park+ndvi_summer+occur_bs_1000m+
             as.factor(year)+as.factor(region4)+
             medhouseholdincome+medianhousevalue+poverty+education+pct_owner_occ+hispanic+pct_blk+
             #popdensity+
             #smoke_rate+
             #summer_tmmx+summer_sph+summer_pr+
             offset(log(time_count)),
           eliminate=(as.factor(sex):as.factor(race):as.factor(dual):as.factor(age_entry):as.factor(followupyear)),
           data=dataplot,family=poisson(link="log"))
Sys.time()
print("model finished")
serr<-as.data.frame(model$coefficients[1:3])
colnames(serr)<-"Beta"
serr$model<-c("model 2")
serr$out<-c("res")
serr$exposure<-c("park","ndvi_summer","occur_bs_1000m")
write.csv(serr,file="/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/m2_res.xlsx")
rm(model)
gc()

#model 3
print("model 3")
Sys.time()
model<-gnm(hosp~park+ndvi_summer+occur_bs_1000m+
             as.factor(year)+as.factor(region4)+
             medhouseholdincome+medianhousevalue+poverty+education+pct_owner_occ+hispanic+pct_blk+
             popdensity+
             #smoke_rate+
             #summer_tmmx+summer_sph+summer_pr+
             offset(log(time_count)),
           eliminate=(as.factor(sex):as.factor(race):as.factor(dual):as.factor(age_entry):as.factor(followupyear)),
           data=dataplot,family=poisson(link="log"))
Sys.time()
print("model finished")
serr<-as.data.frame(model$coefficients[1:3])
colnames(serr)<-"Beta"
serr$model<-c("model 3")
serr$out<-c("res")
serr$exposure<-c("park","ndvi_summer","occur_bs_1000m")
write.csv(serr,file="/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/m3_res.xlsx")
rm(model)
gc()

#model 4
print("model 4")
Sys.time()
model<-gnm(hosp~park+ndvi_summer+occur_bs_1000m+
             as.factor(year)+as.factor(region4)+
             medhouseholdincome+medianhousevalue+poverty+education+pct_owner_occ+hispanic+pct_blk+
             popdensity+
             smoke_rate+
             #summer_tmmx+summer_sph+summer_pr+
             offset(log(time_count)),
           eliminate=(as.factor(sex):as.factor(race):as.factor(dual):as.factor(age_entry):as.factor(followupyear)),
           data=dataplot,family=poisson(link="log"))
Sys.time()
print("model finished")
serr<-as.data.frame(model$coefficients[1:3])
colnames(serr)<-"Beta"
serr$model<-c("model 4")
serr$out<-c("res")
serr$exposure<-c("park","ndvi_summer","occur_bs_1000m")
serr$AIC<-AIC(model)
serr$BIC<-BIC(model)
write.csv(serr,file="/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/m4_res.xlsx")

#model 5
print("model 5")
Sys.time()
model<-gnm(hosp~park+ndvi_summer+occur_bs_1000m+
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
serr$model<-c("model 5")
serr$out<-c("res")
serr$exposure<-c("park","ndvi_summer","occur_bs_1000m")
serr$AIC<-AIC(model)
serr$BIC<-BIC(model)
write.csv(serr,file="/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/m5_res.xlsx")

#predict exp-resp curve
print("predict model")
pred <- data.frame(predict(model, type='terms', terms=c(2:4)))
rm(model)
#linear park
lin.park<-data.frame(cbind(dataplot$park, pred$park))
lin.park<-lin.park[!duplicated(lin.park), ]
lin.park<-lin.park[order(lin.park$X1),]
write.csv(lin.park,file="/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/park_1df_curve_res.xlsx")
#linear ndvi
lin.ndvi<-data.frame(cbind(dataplot$ndvi_summer, pred$ndvi_summer))
lin.ndvi<-lin.ndvi[!duplicated(lin.ndvi), ]
lin.ndvi<-lin.ndvi[order(lin.ndvi$X1),]
write.csv(lin.ndvi,file="/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/ndvi_1df_curve_res.xlsx")
rm(lin.ndvi)
#linear blue space
lin.blue<-data.frame(cbind(dataplot$occur_bs_1000m, pred$occur_bs_1000m))
lin.blue<-lin.blue[!duplicated(lin.blue), ]
lin.blue<-lin.blue[order(lin.blue$X1),]
write.csv(lin.blue,file="/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/blue_1df_curve_res.xlsx")
rm(lin.blue, pred)
gc()

#########################################################################################################
##########################################splines########################################################
#########################################################################################################

#ndvi blue space 2df
print("ndvi blue space 2df model")
model<-gnm(hosp~ns(park,df=2)+ns(ndvi_summer,df=2)+ns(occur_bs_1000m,df=2)+
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
write.csv(stats,file="/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/ndvi_blue_2df_sim_stats_res.xlsx")
print("predict model")
pred <- predict(model, type='terms', terms=c(2:4))
rm(model)
print("bind data")
curve.park<-data.frame(cbind(dataplot$park, pred[,1]))
print("get unique values")
curve.park<-curve.park[!duplicated(curve.park), ]
colnames(curve.park)<-c("exp","pred")
curve.park<-curve.park[order(curve.park$exp),]
write.csv(curve.park,file="/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/park_2df_sim_curve_res.xlsx")
rm(curve.park)
print("bind data")
curve.ndvi<-data.frame(cbind(dataplot$ndvi_summer, pred[,2]))
print("get unique values")
curve.ndvi<-curve.ndvi[!duplicated(curve.ndvi), ]
colnames(curve.ndvi)<-c("exp","pred")
curve.ndvi<-curve.ndvi[order(curve.ndvi$exp),]
write.csv(curve.ndvi,file="/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/ndvi_2df_sim_curve_res.xlsx")
rm(curve.ndvi)
curve.blue<-data.frame(cbind(dataplot$occur_bs_1000m, pred[,3]))
print("get unique values")
curve.blue<-curve.blue[!duplicated(curve.blue), ]
colnames(curve.blue)<-c("exp","pred")
curve.blue<-curve.blue[order(curve.blue$exp),]
write.csv(curve.blue,file="/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/blue_2df_sim_curve_res.xlsx")
rm(stats,curve.blue,pred)
gc()

#park ndvi blue space 3df
print("park ndvi blue space 3df model")
model<-gnm(hosp~ns(park,df=3)+ns(ndvi_summer,df=3)+ns(occur_bs_1000m,df=3)+
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
write.csv(stats,file="/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/ndvi_blue_3df_sim_stats_res.xlsx")
print("predict model")
pred <- predict(model, type='terms', terms=c(2:4))
rm(model)
print("bind data")
curve.park<-data.frame(cbind(dataplot$park, pred[,1]))
print("get unique values")
curve.park<-curve.park[!duplicated(curve.park), ]
colnames(curve.park)<-c("exp","pred")
curve.park<-curve.park[order(curve.park$exp),]
write.csv(curve.park,file="/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/park_3df_sim_curve_res.xlsx")
rm(curve.park)
print("bind data")
curve.ndvi<-data.frame(cbind(dataplot$ndvi_summer, pred[,2]))
print("get unique values")
curve.ndvi<-curve.ndvi[!duplicated(curve.ndvi), ]
colnames(curve.ndvi)<-c("exp","pred")
curve.ndvi<-curve.ndvi[order(curve.ndvi$exp),]
write.csv(curve.ndvi,file="/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/ndvi_3df_sim_curve_res.xlsx")
rm(curve.ndvi)
curve.blue<-data.frame(cbind(dataplot$occur_bs_1000m, pred[,3]))
print("get unique values")
curve.blue<-curve.blue[!duplicated(curve.blue), ]
colnames(curve.blue)<-c("exp","pred")
curve.blue<-curve.blue[order(curve.blue$exp),]
write.csv(curve.blue,file="/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/blue_3df_sim_curve_res.xlsx")
rm(stats,curve.blue,pred)
gc()