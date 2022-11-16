#install.packages("coxme")
library("coxme")
library("survival")
library("mgcv")
#library("lme4")
library("fst")
library("parallel")
library("doParallel")
library("splines")
library("gnm")
library("writexl")
#library("dplyr")
library("data.table")

region<-read_fst("/nfs/home/J/jok8845/shared_space/ci3_analysis/medicare_temperature_humidity/data/USregions/zip_4regions.fst")
setnames(region,"region","region4")

new_merged <- "/nfs/home/J/jok8845/shared_space/ci3_health_data/medicare/gen_admission/1999_2016/Klompmaker/merged_data/res2/"
dir_out <- "/nfs/home/J/jok8845/shared_space/ci3_analysis/medicare_temperature_humidity/Modeloutput/"

#merge with dataset
aggregate_RES <- read_fst(paste0(new_merged ,"aggregate_RES_65yrs.fst"), as.data.table = T)
aggregate_RES<-merge(aggregate_RES,region,by="zip",all.x=T)
write_fst(aggregate_RES, "/nfs/home/J/jok8845/shared_space/ci3_health_data/medicare/gen_admission/1999_2016/Klompmaker/merged_data/res2/aggregate_RES_65yrs.fst")
rm(aggregate_RES)

#merge with dataset
aggregate_RES <- read_fst(paste0(new_merged ,"aggregate_RES_75yrs.fst"), as.data.table = T)
aggregate_RES<-merge(aggregate_RES,region,by="zip",all.x=T)
write_fst(aggregate_RES, "/nfs/home/J/jok8845/shared_space/ci3_health_data/medicare/gen_admission/1999_2016/Klompmaker/merged_data/res2/aggregate_RES_75yrs.fst")
rm(aggregate_RES)

#merge with dataset
aggregate_RES <- read_fst(paste0(new_merged ,"aggregate_RES_85yrs.fst"), as.data.table = T)
aggregate_RES<-merge(aggregate_RES,region,by="zip",all.x=T)
write_fst(aggregate_RES, "/nfs/home/J/jok8845/shared_space/ci3_health_data/medicare/gen_admission/1999_2016/Klompmaker/merged_data/res2/aggregate_RES_85yrs.fst")
rm(aggregate_RES)
