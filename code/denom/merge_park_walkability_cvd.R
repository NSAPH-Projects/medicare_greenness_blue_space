#install.packages("coxme")
library("fst")
library("writexl")
#library("dplyr")
library("data.table")

new_merged <- "/nfs/home/J/jok8845/shared_space/ci3_health_data/medicare/gen_admission/1999_2016/Klompmaker/merged_data/cvd2/"
dir_out <- "/nfs/home/J/jok8845/shared_space/ci3_analysis/medicare_temperature_humidity/Modeloutput/"
aggregate_CVD <- read_fst(paste0(new_merged ,"aggregate_CVD.fst"), as.data.table = T)

#read walkability and park data
walkability<-read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/data/walkability/walkability.csv")
park<-read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/parks/combined_park_zip20002016.csv")

#ZIP to zip
setnames(walkability,"ZIP","zip")
setnames(park,"ZIP","zip")

#merge walkability and park data
cov<-merge(walkability,park,by = c("year", "zip"),all = TRUE)

#merge with CVD dataset
aggregate_CVD<-merge(aggregate_CVD,cov,by=c("zip","year"),all.x=T)

write_fst(aggregate_CVD, "/nfs/home/J/jok8845/shared_space/ci3_health_data/medicare/gen_admission/1999_2016/Klompmaker/merged_data/cvd2/aggregate_CVD.fst")
