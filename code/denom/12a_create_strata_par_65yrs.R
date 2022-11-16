
library(data.table)
library(fst)
#library(NSAPHutils)
#library(dplyr)

old_merged <- "/nfs/home/J/jok8845/shared_space/ci3_health_data/medicare/gen_admission/1999_2016/Klompmaker/cache_data/hosp_adm/par/correct_followup/"
new_merged <- "/nfs/home/J/jok8845/shared_space/ci3_health_data/medicare/gen_admission/1999_2016/Klompmaker/merged_data/par2/"

merged_files <- list.files(
  old_merged,
  pattern = "confounder_exposure_merged_nodups_health_[0-9]+\\.fst",
  full.names = TRUE
)

PAR <- rbindlist(
  lapply(merged_files,
         read_fst,
         columns = c("zip","age","year.medicare","qid",
                     "race","sex","dual","entry_age_break.y",
                     "followup_year","followup_year_plus_one","hosp"),
         as.data.table = TRUE))

print("loaded denom files")
setnames(PAR, "year.medicare", "year")

#create subsets by age categories
PAR<-PAR[age < 75]
#CVD<-CVD[age < 85 & age > 74]
#CVD<-CVD[age > 84]

PAR[, race3 := integer()][race==2, race3:= 2
                        ][race==3, race3:= 3][race==1, race3:= 1
                          ][race==5, race3:= 3
                            ][race==6, race3:= 3
                              ][race==0, race3:= 3][race==4, race3:= 3][]
  
#get # hospitalizations
sum(PAR$hosp)

#to data.frame
PAR<-data.frame(PAR)

#calculate total person-time at risk
PAR$time_count<-PAR$followup_year_plus_one-PAR$followup_year
print("calculated time count")

# Calculate the total count of PAR hospitalizations for strata c at 
# follow-up year a, time year t and location zip code z
PARcount<-aggregate(PAR$hosp, by=list(PAR$sex,PAR$race3,PAR$entry_age_break.y,PAR$dual,PAR$followup_year,PAR$zip,PAR$year), FUN=sum)
print("calculated total PAR hosp")

write_fst(PARcount, paste0(new_merged, "PAR_count.fst"))

gc()

# Calculate the total person-time at-risk for strata c at follow-up 
# year a, time year t and location zip code z
time_count<-aggregate(PAR$time_count, by=list(PAR$sex,PAR$race3,PAR$entry_age_break,PAR$dual,PAR$followup_year,PAR$zip,PAR$year), FUN=sum)
print("calculated total person-time at risk")

write_fst(time_count, paste0(new_merged, "time_count.fst"))

rm(PAR)
gc()
#merge and rename variables
aggregate_data<-merge(PARcount,time_count,by=c("Group.1", "Group.2", "Group.3", "Group.4", "Group.5", "Group.6", "Group.7"))
colnames(aggregate_data)[8:9]<-c("hosp","time_count")
colnames(aggregate_data)[1:7]<-c("sex","race","age_entry","dual","followupyear","zip","year")
print("merged hosp and time at risk")
nrow(aggregate_data)
rm(PARcount,time_count)

#read zip code covariates
covar<-read_fst("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/data/confounders/merged_covariates.fst")
colnames(covar)
print("loaded covariates")

#merge data
aggregate_PAR<-merge(aggregate_data,covar, by=c("zip","year"),all.x=T)
print("merged PAR covariates")
nrow(aggregate_PAR)

#read US regions per zip
zip_region<-read_fst("/nfs/home/J/jok8845/shared_space/ci3_analysis/medicare_temperature_humidity/data/USregions/zip_regions.fst",
                     columns = c("zip", "region"))

#merge US regions
aggregate_PAR<-merge(aggregate_PAR, zip_region, by="zip",all.x=T)
nrow(aggregate_PAR)

# Save the final dataset
write_fst(aggregate_PAR, paste0(new_merged, "aggregate_PAR_65yrs.fst"))
#saveRDS(aggregate_PAR,paste0(new_merged,"aggregate_PAR_0016.rds"))
