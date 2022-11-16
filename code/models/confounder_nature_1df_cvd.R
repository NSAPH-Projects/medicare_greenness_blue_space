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
                                 "education","population",
                                 "smoke_rate","mean_bmi","summer_tmmx","summer_sph","summer_pr",
                                 "ndvi_summer","occur_bs_1000m","park"), as.data.table = T)
dataplot$medianhousevalue<-dataplot$medianhousevalue/10000
dataplot$medhouseholdincome<-dataplot$medhouseholdincome/1000
dataplot<-na.omit(dataplot)
nrow(dataplot)

#model 5
print("model 5")
Sys.time()
model<-gnm(hosp~park+ndvi_summer+occur_bs_1000m+
             as.factor(year)+
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
serr$out<-c("cvd")
serr$exposure<-c("park","ndvi_summer","occur_bs_1000m")
serr$AIC<-AIC(model)
serr$BIC<-BIC(model)
write.csv(serr,file="/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/m5_cvd.xlsx")

#predict exp-resp curve
print("predict model")
pred <- data.frame(predict(model, type='terms', terms=c(2:4)))
rm(model)
#linear park
lin.park<-data.frame(cbind(dataplot$park, pred$park))
lin.park<-lin.park[!duplicated(lin.park), ]
lin.park<-lin.park[order(lin.park$X1),]
write.csv(lin.park,file="/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/park_1df_curve_cvd.xlsx")
#linear ndvi
lin.ndvi<-data.frame(cbind(dataplot$ndvi_summer, pred$ndvi_summer))
lin.ndvi<-lin.ndvi[!duplicated(lin.ndvi), ]
lin.ndvi<-lin.ndvi[order(lin.ndvi$X1),]
write.csv(lin.ndvi,file="/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/ndvi_1df_curve_cvd.xlsx")
rm(lin.ndvi)
#linear blue space
lin.blue<-data.frame(cbind(dataplot$occur_bs_1000m, pred$occur_bs_1000m))
lin.blue<-lin.blue[!duplicated(lin.blue), ]
lin.blue<-lin.blue[order(lin.blue$X1),]
write.csv(lin.blue,file="/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/blue_1df_curve_cvd.xlsx")
rm(lin.blue, pred)
gc()
