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

new_merged <- "/nfs/home/J/jok8845/shared_space/ci3_health_data/medicare/gen_admission/1999_2016/Klompmaker/merged_data/par2/"
dir_out <- "/nfs/home/J/jok8845/shared_space/ci3_analysis/medicare_temperature_humidity/Modeloutput/"
aggregate_PAR <- read_fst(paste0(new_merged ,"aggregate_PAR.fst"), as.data.table = T)

divisions<-read_fst("/nfs/home/J/jok8845/shared_space/ci3_analysis/medicare_temperature_humidity/data/USregions/zip_divisions.fst")

#merge with dataset
aggregate_PAR<-merge(aggregate_PAR,divisions,by="zip",all.x=T)

write_fst(aggregate_PAR, "/nfs/home/J/jok8845/shared_space/ci3_health_data/medicare/gen_admission/1999_2016/Klompmaker/merged_data/par2/aggregate_PAR.fst")
