
library(data.table)
library(fst)

old_merged <- "/nfs/home/J/jok8845/shared_space/ci3_health_data/medicare/gen_admission/1999_2016/Klompmaker/cache_data/hosp_adm/res/correct_followup/"
new_merged <- "/nfs/home/J/jok8845/shared_space/ci3_health_data/medicare/gen_admission/1999_2016/Klompmaker/merged_data/res/"

#read_data
REScount<-read_fst("/nfs/home/J/jok8845/shared_space/ci3_health_data/medicare/gen_admission/1999_2016/Klompmaker/merged_data/res/RES_count.fst")
time_count<-read_fst("/nfs/home/J/jok8845/shared_space/ci3_health_data/medicare/gen_admission/1999_2016/Klompmaker/merged_data/res/time_count.fst")

#merge and rename variables
aggregate_data<-merge(REScount,time_count,by=c("Group.1", "Group.2", "Group.3", "Group.4", "Group.5", "Group.6", "Group.7"))
colnames(aggregate_data)[8:9]<-c("hosp","time_count")
colnames(aggregate_data)[1:7]<-c("sex","race","age_entry","dual","followupyear","zip","year")
print("merged hosp and time at risk")
nrow(aggregate_data)
rm(REScount,time_count)

#read zip code covariates
covar<-read_fst("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/data/confounders/merged_covariates.fst")
colnames(covar)
print("loaded covariates")

#merge data
aggregate_RES<-merge(aggregate_data,covar, by=c("zip","year"),all.x=T)
print("merged RES covariates")
nrow(aggregate_RES)

#read US regions per zip
zip_region<-read_fst("/nfs/home/J/jok8845/shared_space/ci3_analysis/medicare_temperature_humidity/data/USregions/zip_regions.fst",
                     columns = c("zip", "region"))

#merge US regions
aggregate_RES<-merge(aggregate_RES, zip_region, by="zip",all.x=T)
nrow(aggregate_RES)

# Save the final dataset
write_fst(aggregate_RES, paste0(new_merged, "aggregate_RES.fst"))
#saveRDS(aggregate_RES,paste0(new_merged,"aggregate_RES_0016.rds"))
