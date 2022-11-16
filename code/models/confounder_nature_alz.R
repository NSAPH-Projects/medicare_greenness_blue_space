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
                                 "education",
                                 "smoke_rate","region4",
                                 "ndvi_summer","occur_bs_1000m","park"), as.data.table = T)
dataplot$medianhousevalue<-dataplot$medianhousevalue/10000
dataplot$medhouseholdincome<-dataplot$medhouseholdincome/1000
sum(dataplot$hosp)
sum(dataplot$time_count)
dataplot<-na.omit(dataplot)
nrow(dataplot)
dataplot$occur_bs_1000m_bin<-ifelse(dataplot$occur_bs_1000m>=0.01,1,0)

#model 1
print("model 1")
Sys.time()
model<-gnm(hosp~park+ndvi_summer+as.factor(occur_bs_1000m_bin)+
             as.factor(year)+as.factor(region4)+
             #medhouseholdincome+medianhousevalue+poverty+education+pct_owner_occ+hispanic+pct_blk+
             #popdensity+
             #smoke_rate+
             offset(log(time_count)),
           eliminate=(as.factor(sex):as.factor(race):as.factor(dual):as.factor(age_entry):as.factor(followupyear)),
           data=dataplot,family=poisson(link="log"))
Sys.time()
print("model finished")
serr<-as.data.frame(model$coefficients[1:3])
colnames(serr)<-"Beta"
serr$model<-c("model 1")
serr$out<-c("alz")
serr$exposure<-rownames(serr)
write.csv(serr,file="/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/m1_alz.xlsx")
rm(model)
gc()

#model 2
print("model 2")
Sys.time()
model<-gnm(hosp~park+ndvi_summer+as.factor(occur_bs_1000m_bin)+
             as.factor(year)+as.factor(region4)+
             medhouseholdincome+medianhousevalue+poverty+education+pct_owner_occ+hispanic+pct_blk+
             #popdensity+
             #smoke_rate+
             offset(log(time_count)),
           eliminate=(as.factor(sex):as.factor(race):as.factor(dual):as.factor(age_entry):as.factor(followupyear)),
           data=dataplot,family=poisson(link="log"))
Sys.time()
print("model finished")
serr<-as.data.frame(model$coefficients[1:3])
colnames(serr)<-"Beta"
serr$model<-c("model 2")
serr$out<-c("alz")
serr$exposure<-rownames(serr)
write.csv(serr,file="/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/m2_alz.xlsx")
rm(model)
gc()

#model 3
print("model 3")
Sys.time()
model<-gnm(hosp~park+ndvi_summer+as.factor(occur_bs_1000m_bin)+
             as.factor(year)+as.factor(region4)+
             medhouseholdincome+medianhousevalue+poverty+education+pct_owner_occ+hispanic+pct_blk+
             popdensity+
             #smoke_rate+
             offset(log(time_count)),
           eliminate=(as.factor(sex):as.factor(race):as.factor(dual):as.factor(age_entry):as.factor(followupyear)),
           data=dataplot,family=poisson(link="log"))
Sys.time()
print("model finished")
serr<-as.data.frame(model$coefficients[1:3])
colnames(serr)<-"Beta"
serr$model<-c("model 3")
serr$out<-c("alz")
serr$exposure<-rownames(serr)
write.csv(serr,file="/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/m3_alz.xlsx")
rm(model)
gc()

#model 4
print("model 4")
Sys.time()
model<-gnm(hosp~park+ndvi_summer+as.factor(occur_bs_1000m_bin)+
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
serr$model<-c("model 4")
serr$out<-c("alz")
serr$exposure<-rownames(serr)
write.csv(serr,file="/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/m4_alz.xlsx")

#predict exp-resp curve
print("predict model")
pred <- data.frame(predict(model, type='terms', terms=c(2:3)))
rm(model)
#linear park
lin.park<-data.frame(cbind(dataplot$park, pred$park))
lin.park<-lin.park[!duplicated(lin.park), ]
lin.park<-lin.park[order(lin.park$X1),]
write.csv(lin.park,file="/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/park_1df_curve_alz.xlsx")
#linear ndvi
lin.ndvi<-data.frame(cbind(dataplot$ndvi_summer, pred$ndvi_summer))
lin.ndvi<-lin.ndvi[!duplicated(lin.ndvi), ]
lin.ndvi<-lin.ndvi[order(lin.ndvi$X1),]
write.csv(lin.ndvi,file="/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/ndvi_1df_curve_alz.xlsx")
rm(lin.ndvi)

#########################################################################################################
##########################################splines########################################################
#########################################################################################################

#ndvi blue space 2df
print("ndvi blue space 2df model")
model<-gnm(hosp~ns(park,df=2)+ns(ndvi_summer,df=2)+as.factor(occur_bs_1000m_bin)+
             as.factor(year)+as.factor(region4)+
             medhouseholdincome+medianhousevalue+poverty+education+pct_owner_occ+hispanic+pct_blk+
             popdensity+
             smoke_rate+
             offset(log(time_count)),
           eliminate=(as.factor(sex):as.factor(race):as.factor(dual):as.factor(age_entry):as.factor(followupyear)),
           data=dataplot,family=poisson(link="log"))

#predict exp-resp curve
print("predict model")
pred <- predict(model, type='terms', terms=c(2:3))
rm(model)
print("bind data")
curve.park<-data.frame(cbind(dataplot$park, pred[,1]))
print("get unique values")
curve.park<-curve.park[!duplicated(curve.park), ]
colnames(curve.park)<-c("exp","pred")
curve.park<-curve.park[order(curve.park$exp),]
write.csv(curve.park,file="/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/park_2df_sim_curve_alz.xlsx")
rm(curve.park)
print("bind data")
curve.ndvi<-data.frame(cbind(dataplot$ndvi_summer, pred[,2]))
print("get unique values")
curve.ndvi<-curve.ndvi[!duplicated(curve.ndvi), ]
colnames(curve.ndvi)<-c("exp","pred")
curve.ndvi<-curve.ndvi[order(curve.ndvi$exp),]
write.csv(curve.ndvi,file="/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/ndvi_2df_sim_curve_alz.xlsx")
rm(curve.ndvi,pred)
gc()

#park ndvi blue space 3df
print("park ndvi blue space 3df model")
model<-gnm(hosp~ns(park,df=3)+ns(ndvi_summer,df=3)+as.factor(occur_bs_1000m_bin)+
             as.factor(year)+as.factor(region4)+
             medhouseholdincome+medianhousevalue+poverty+education+pct_owner_occ+hispanic+pct_blk+
             popdensity+
             smoke_rate+
             offset(log(time_count)),
           eliminate=(as.factor(sex):as.factor(race):as.factor(dual):as.factor(age_entry):as.factor(followupyear)),
           data=dataplot,family=poisson(link="log"))

#predict exp-resp curve
print("predict model")
pred <- predict(model, type='terms', terms=c(2:3))
rm(model)
print("bind data")
curve.park<-data.frame(cbind(dataplot$park, pred[,1]))
print("get unique values")
curve.park<-curve.park[!duplicated(curve.park), ]
colnames(curve.park)<-c("exp","pred")
curve.park<-curve.park[order(curve.park$exp),]
write.csv(curve.park,file="/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/park_3df_sim_curve_alz.xlsx")
rm(curve.park)
print("bind data")
curve.ndvi<-data.frame(cbind(dataplot$ndvi_summer, pred[,2]))
print("get unique values")
curve.ndvi<-curve.ndvi[!duplicated(curve.ndvi), ]
colnames(curve.ndvi)<-c("exp","pred")
curve.ndvi<-curve.ndvi[order(curve.ndvi$exp),]
write.csv(curve.ndvi,file="/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/ndvi_3df_sim_curve_alz.xlsx")
rm(curve.ndvi,pred)
gc()