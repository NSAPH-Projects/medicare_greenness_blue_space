#install.packages("coxme")
library("fst")
library("writexl")
#library("dplyr")
library("data.table")

new_merged <- "/nfs/home/J/jok8845/shared_space/ci3_health_data/medicare/gen_admission/1999_2016/Klompmaker/merged_data/alz2/"
dir_out <- "/nfs/home/J/jok8845/shared_space/ci3_analysis/medicare_temperature_humidity/Modeloutput/"
aggregate_ALZ <- read_fst(paste0(new_merged ,"aggregate_excl_1yrhosp_ALZ.fst"), as.data.table = T)

#read park data
park<-read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/parks/combined_park_zip20002016.csv")

#ZIP to zip
setnames(park,"ZIP","zip")

#merge with CVD dataset
aggregate_ALZ<-merge(aggregate_ALZ,park,by=c("zip","year"),all.x=T)

print("merged data")
write_fst(aggregate_ALZ, "/nfs/home/J/jok8845/shared_space/ci3_health_data/medicare/gen_admission/1999_2016/Klompmaker/merged_data/alz2/aggregate_excl_1yrhosp_ALZ.fst")
