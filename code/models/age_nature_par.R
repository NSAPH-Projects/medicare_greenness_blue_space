#install.packages("coxme")
library("fst")
library("writexl")
library("splines")
library("gnm")
library("writexl")
library("data.table")
library("lmtest")

new_merged <- "/nfs/home/J/jok8845/shared_space/ci3_health_data/medicare/gen_admission/1999_2016/Klompmaker/merged_data/par2/"
dir_out <- "/nfs/home/J/jok8845/shared_space/ci3_analysis/medicare_temperature_humidity/Modeloutput/"
#dataplot <- read_fst(paste0(new_merged ,"sample.fst"),
dataplot <- read_fst(paste0(new_merged ,"aggregate_PAR_65yrs.fst"),
                     columns = c("sex","race","age_entry","dual","followupyear",
                                 "zip","year","hosp","time_count",
                                 "poverty","popdensity",
                                 "medianhousevalue","pct_blk","medhouseholdincome","pct_owner_occ","hispanic",
                                 "education",
                                 "smoke_rate","region4",
                                 "ndvi_summer","occur_bs_1000m","park"), as.data.table = T)

#get only urban zipcodes
dataplot$medianhousevalue<-dataplot$medianhousevalue/10000
dataplot$medhouseholdincome<-dataplot$medhouseholdincome/1000
dataplot$occur_bs_1000m_bin<-ifelse(dataplot$occur_bs_1000m>=0.01,1,0)
dataplot<-na.omit(dataplot)
nrow(dataplot)

#model 5
print("model 5 age 65")
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
serr$model<-c("model 5")
serr$out<-c("par")
serr$strata<-c("age 65")
serr$exposure<-rownames(serr)
write.csv(serr,file="/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/age65_par.xlsx")

dataplot <- read_fst(paste0(new_merged ,"aggregate_PAR_75yrs.fst"),
                     columns = c("sex","race","age_entry","dual","followupyear",
                                 "zip","year","hosp","time_count",
                                 "poverty","popdensity",
                                 "medianhousevalue","pct_blk","medhouseholdincome","pct_owner_occ","hispanic",
                                 "education",
                                 "smoke_rate","region4",
                                 "ndvi_summer","occur_bs_1000m","park"), as.data.table = T)

#get only urban zipcodes
dataplot$medianhousevalue<-dataplot$medianhousevalue/10000
dataplot$medhouseholdincome<-dataplot$medhouseholdincome/1000
dataplot$occur_bs_1000m_bin<-ifelse(dataplot$occur_bs_1000m>=0.01,1,0)
dataplot<-na.omit(dataplot)
nrow(dataplot)

print("model 5 age 75")
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
serr$model<-c("model 5")
serr$out<-c("par")
serr$strata<-c("age 75")
serr$exposure<-rownames(serr)
write.csv(serr,file="/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/age75_par.xlsx")

dataplot <- read_fst(paste0(new_merged ,"aggregate_PAR_85yrs.fst"),
                     columns = c("sex","race","age_entry","dual","followupyear",
                                 "zip","year","hosp","time_count",
                                 "poverty","popdensity",
                                 "medianhousevalue","pct_blk","medhouseholdincome","pct_owner_occ","hispanic",
                                 "education",
                                 "smoke_rate","region4",
                                 "ndvi_summer","occur_bs_1000m","park"), as.data.table = T)

#get only urban zipcodes
dataplot$medianhousevalue<-dataplot$medianhousevalue/10000
dataplot$medhouseholdincome<-dataplot$medhouseholdincome/1000
dataplot$occur_bs_1000m_bin<-ifelse(dataplot$occur_bs_1000m>=0.01,1,0)
dataplot<-na.omit(dataplot)
nrow(dataplot)

print("model 5 age 85")
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
serr$model<-c("model 5")
serr$out<-c("par")
serr$strata<-c("age 85")
serr$exposure<-rownames(serr)
write.csv(serr,file="/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/age85_par.xlsx")
