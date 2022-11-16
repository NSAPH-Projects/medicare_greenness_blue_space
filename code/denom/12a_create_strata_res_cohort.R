
library(data.table)
library(fst)
#library(NSAPHutils)
#library(dplyr)

old_merged <- "/nfs/home/J/jok8845/shared_space/ci3_health_data/medicare/gen_admission/1999_2016/Klompmaker/cache_data/hosp_adm/res/correct_followup/"
new_merged <- "/nfs/home/J/jok8845/shared_space/ci3_health_data/medicare/gen_admission/1999_2016/Klompmaker/merged_data/res2/"

merged_files <- list.files(
  old_merged,
  pattern = "confounder_exposure_merged_nodups_health_[0-9]+\\.fst",
  full.names = TRUE
)

RES <- rbindlist(
  lapply(merged_files,
         read_fst,
         columns = c("zip","age","year.medicare","qid",
                     "race","sex","dual","entry_age_break.y",
                     "followup_year","followup_year_plus_one","hosp"),
         as.data.table = TRUE))

print("loaded denom files")
setnames(RES, "year.medicare", "year")

RES[, race3 := integer()][race==2, race3:= 2
                        ][race==3, race3:= 3][race==1, race3:= 1
                          ][race==5, race3:= 3
                            ][race==6, race3:= 3
                              ][race==0, race3:= 3][race==4, race3:= 3][]
  
#get # hospitalizations
sum(RES$hosp)

#to data.frame
RES<-data.frame(RES)

#calculate total person-time at risk
RES$time_count<-RES$followup_year_plus_one-RES$followup_year
print("calculated time count")

# Calculate the total count of res hospitalizations for strata c at 
# follow-up year a, time year t and location zip code z
REScount<-aggregate(RES$hosp, by=list(RES$sex,RES$race3,RES$entry_age_break.y,RES$dual,RES$followup_year,RES$zip,RES$year), FUN=sum)
print("calculated total res hosp")

write_fst(REScount, paste0(new_merged, "RES_count.fst"))

gc()

# Calculate the total person-time at-risk for strata c at follow-up 
# year a, time year t and location zip code z
time_count<-aggregate(RES$time_count, by=list(RES$sex,RES$race3,RES$entry_age_break,RES$dual,RES$followup_year,RES$zip,RES$year), FUN=sum)
print("calculated total person-time at risk")

write_fst(time_count, paste0(new_merged, "time_count.fst"))

rm(RES)
gc()
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
