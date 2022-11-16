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

new_merged <- "/nfs/home/J/jok8845/shared_space/ci3_health_data/medicare/gen_admission/1999_2016/Klompmaker/merged_data/alz2/"
dir_out <- "/nfs/home/J/jok8845/shared_space/ci3_analysis/medicare_temperature_humidity/Modeloutput/"
aggregate_ALZ <- read_fst(paste0(new_merged ,"aggregate_ALZ.fst"), as.data.table = T)

divisions<-read_fst("/nfs/home/J/jok8845/shared_space/ci3_analysis/medicare_temperature_humidity/data/USregions/zip_divisions.fst")

#merge with dataset
aggregate_ALZ<-merge(aggregate_ALZ,divisions,by="zip",all.x=T)

write_fst(aggregate_ALZ, "/nfs/home/J/jok8845/shared_space/ci3_health_data/medicare/gen_admission/1999_2016/Klompmaker/merged_data/alz2/aggregate_ALZ.fst")
