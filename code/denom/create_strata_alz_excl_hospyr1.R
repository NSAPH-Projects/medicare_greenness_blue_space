
library(data.table)
library(fst)
#library(NSAPHutils)
#library(dplyr)
library("gnm")
library("writexl")

old_merged <- "/nfs/home/J/jok8845/shared_space/ci3_health_data/medicare/gen_admission/1999_2016/Klompmaker/cache_data/hosp_adm/alz/correct_followup/"
new_merged <- "/nfs/home/J/jok8845/shared_space/ci3_health_data/medicare/gen_admission/1999_2016/Klompmaker/merged_data/alz2/"

merged_files <- list.files(
  old_merged,
  pattern = "confounder_exposure_merged_nodups_health_[0-9]+\\.fst",
  full.names = TRUE
)

ALZ <- rbindlist(
  lapply(merged_files,
         read_fst,
         columns = c("zip","age","year.medicare","qid",
                     "race","sex","dual","entry_age_break.y",
                     "followup_year","followup_year_plus_one","hosp"),
         as.data.table = TRUE))

print("loaded denom files")
setnames(ALZ, "year.medicare", "year")

print("#hospitalizations")
sum(ALZ$hosp)
length(unique(ALZ$qid))

#remove subjects with hospitalization in follow-up year 1
ALZ<-ALZ[ALZ$followup_year !=1 | ALZ$hosp!=TRUE,]
print("removed subjects with hosp in year 1")
length(unique(ALZ$qid))

print("#hospitalizations exlcuding follow-up year 1 hosp")
ALZ<-ALZ[ALZ$year !=2000]
print("# individuals")
length(unique(ALZ$qid))

ALZ[, race3 := integer()][race==2, race3:= 2
                          ][race==3, race3:= 3][race==1, race3:= 1
                                                ][race==5, race3:= 3
                                                  ][race==6, race3:= 3
                                                    ][race==0, race3:= 3][race==4, race3:= 3][]

#get # hospitalizations
print("number of hospitalizations")
sum(ALZ$hosp)

#to data.frame
ALZ<-data.frame(ALZ)

#calculate total person-time at risk
ALZ$time_count<-ALZ$followup_year_plus_one-ALZ$followup_year
print("calculated time count")

# Calculate the total count of ALZ hospitalizations for strata c at 
# follow-up year a, time year t and location zip code z
ALZcount<-aggregate(ALZ$hosp, by=list(ALZ$sex,ALZ$race3,ALZ$entry_age_break.y,ALZ$dual,ALZ$followup_year,ALZ$zip,ALZ$year), FUN=sum)
print("calculated total ALZ hosp")

gc()

# Calculate the total person-time at-risk for strata c at follow-up 
# year a, time year t and location zip code z
time_count<-aggregate(ALZ$time_count, by=list(ALZ$sex,ALZ$race3,ALZ$entry_age_break,ALZ$dual,ALZ$followup_year,ALZ$zip,ALZ$year), FUN=sum)
print("calculated total person-time at risk")

rm(ALZ)

#merge and rename variables
aggregate_data<-merge(ALZcount,time_count,by=c("Group.1", "Group.2", "Group.3", "Group.4", "Group.5", "Group.6", "Group.7"))
colnames(aggregate_data)[8:9]<-c("hosp","time_count")
colnames(aggregate_data)[1:7]<-c("sex","race","age_entry","dual","followupyear","zip","year")
print("merged hosp and time at risk")
nrow(aggregate_data)
rm(ALZcount,time_count)

#read zip code covariates
covar<-read_fst("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/data/confounders/merged_covariates.fst")
colnames(covar)
print("loaded covariates")

#merge data
aggregate_ALZ<-merge(aggregate_data,covar, by=c("zip","year"),all.x=T)
print("merged ALZ covariates")

rm(covar)
gc()

#read US regions per zip
zip_region<-read_fst("/nfs/home/J/jok8845/shared_space/ci3_analysis/medicare_temperature_humidity/data/USregions/zip_4regions.fst",
                     columns = c("zip", "region"))
setnames(zip_region,"region","region4")

#merge US regions
aggregate_ALZ<-merge(aggregate_ALZ, zip_region, by="zip",all.x=T)

#save data
write_fst(aggregate_ALZ, paste0(new_merged, "aggregate_excl_1yrhosp_ALZ.fst"))