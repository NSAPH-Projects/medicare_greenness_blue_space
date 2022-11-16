
library(data.table)
library(fst)
#library(NSAPHutils)
#library(dplyr)
library("gnm")
library("writexl")

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

print("#hospitalizations")
sum(RES$hosp)

#remove subjects with hospitalization in follow-up year 1
RES<-RES[RES$followup_year !=1 | RES$hosp!=TRUE,]
print("removed subjects with hosp in year 1")

print("#hospitalizations exlcuding follow-up year 1 hosp")
RES<-RES[RES$year !=2000]
print("# individuals")
length(unique(RES$qid))

RES[, race3 := integer()][race==2, race3:= 2
                          ][race==3, race3:= 3][race==1, race3:= 1
                                                ][race==5, race3:= 3
                                                  ][race==6, race3:= 3
                                                    ][race==0, race3:= 3][race==4, race3:= 3][]

#get # hospitalizations
print("number of hospitalizations")
sum(RES$hosp)

#to data.frame
RES<-data.frame(RES)

#calculate total person-time at risk
RES$time_count<-RES$followup_year_plus_one-RES$followup_year
print("calculated time count")

# Calculate the total count of RES hospitalizations for strata c at 
# follow-up year a, time year t and location zip code z
REScount<-aggregate(RES$hosp, by=list(RES$sex,RES$race3,RES$entry_age_break.y,RES$dual,RES$followup_year,RES$zip,RES$year), FUN=sum)
print("calculated total RES hosp")

gc()

# Calculate the total person-time at-risk for strata c at follow-up 
# year a, time year t and location zip code z
time_count<-aggregate(RES$time_count, by=list(RES$sex,RES$race3,RES$entry_age_break,RES$dual,RES$followup_year,RES$zip,RES$year), FUN=sum)
print("calculated total person-time at risk")

rm(RES)

#merge and rename variables
aggregate_data<-merge(REScount,time_count,by=c("Group.1", "Group.2", "Group.3", "Group.4", "Group.5", "Group.6", "Group.7"))
colnames(aggregate_data)[8:9]<-c("hosp","time_count")
colnames(aggregate_data)[1:7]<-c("sex","race","age_entry","dual","followupyear","zip","year")
print("merged hosp and time at risk")
nrow(aggregate_data)
rm(REScount,time_count)

#read zip code covariates
covar<-read_fst("/nfs/home/J/jok8845/shared_space/ci3_analysis/medicare_temperature_humidity/data/confounders/merged_covariates.fst")
colnames(covar)
print("loaded covariates")

#merge data
aggregate_RES<-merge(aggregate_data,covar, by=c("zip","year"),all.x=T)
print("merged RES covariates")

rm(covar)
gc()

#read US regions per zip
zip_region<-read_fst("/nfs/home/J/jok8845/shared_space/ci3_analysis/medicare_temperature_humidity/data/USregions/zip_regions.fst",
                     columns = c("zip", "region"))

#merge US regions
aggregate_RES<-merge(aggregate_RES, zip_region, by="zip",all.x=T)

#save data
write_fst(aggregate_RES, paste0(new_merged, "aggregate_excl_1yrhosp_RES.fst"))