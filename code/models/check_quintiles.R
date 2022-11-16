
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
                                 "smoke_rate","mean_bmi",
                                 "ndvi_summer","occur_bs_1000m","park"), as.data.table = T)

dataplot<-na.omit(dataplot)
nrow(dataplot)

#create quintiles
setDT(dataplot)
print("full")
quantile(dataplot$park, probs = 0:5/5,na.rm=T)
quantile(dataplot$ndvi_summer, probs = 0:5/5,na.rm=T)
quantile(dataplot$occur_bs_1000m, probs = 0:5/5,na.rm=T)

dataplot<-dataplot[popdensity>=1000,]

#create quintiles
print("urban")
quantile(dataplot$park, probs = 0:5/5,na.rm=T)
quantile(dataplot$ndvi_summer, probs = 0:5/5,na.rm=T)
quantile(dataplot$occur_bs_1000m, probs = 0:5/5,na.rm=T)

new_merged <- "/nfs/home/J/jok8845/shared_space/ci3_health_data/medicare/gen_admission/1999_2016/Klompmaker/merged_data/res2/"
dir_out <- "/nfs/home/J/jok8845/shared_space/ci3_analysis/medicare_temperature_humidity/Modeloutput/"
#dataplot <- read_fst(paste0(new_merged ,"sample.fst"),
dataplot <- read_fst(paste0(new_merged ,"aggregate_RES.fst"),
                     columns = c("sex","race","age_entry","dual","followupyear",
                                 "zip","year","hosp","time_count",
                                 "poverty","popdensity",
                                 "medianhousevalue","pct_blk","medhouseholdincome","pct_owner_occ","hispanic",
                                 "education","population",
                                 "smoke_rate","mean_bmi",
                                 "ndvi_summer","occur_bs_1000m","park"), as.data.table = T)

dataplot<-na.omit(dataplot)
nrow(dataplot)

#create quintiles
setDT(dataplot)
print("full")
quantile(dataplot$park, probs = 0:5/5,na.rm=T)
quantile(dataplot$ndvi_summer, probs = 0:5/5,na.rm=T)
quantile(dataplot$occur_bs_1000m, probs = 0:5/5,na.rm=T)

dataplot<-dataplot[popdensity>=1000,]

#create quintiles
print("urban")
quantile(dataplot$park, probs = 0:5/5,na.rm=T)
quantile(dataplot$ndvi_summer, probs = 0:5/5,na.rm=T)
quantile(dataplot$occur_bs_1000m, probs = 0:5/5,na.rm=T)
