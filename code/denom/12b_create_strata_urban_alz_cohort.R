
library(data.table)
library(fst)
#library(NSAPHutils)
#library(dplyr)

old_merged <- "/nfs/home/J/jok8845/shared_space/ci3_health_data/medicare/gen_admission/1999_2016/Klompmaker/cache_data/hosp_adm/alz/correct_followup/"
new_merged <- "/nfs/home/J/jok8845/shared_space/ci3_health_data/medicare/gen_admission/1999_2016/Klompmaker/merged_data/alz2/"

merged_files <- list.files(
  old_merged,
  pattern = "confounder_exposure_merged_nodups_health_[0-9]+\\.fst",
  full.names = TRUE
)

print("read data")
mdy_data <- rbindlist(
  lapply(merged_files,
         read_fst,
         columns = c("qid","zip","year.medicare"),
         as.data.table = TRUE))
setnames(mdy_data,"year.medicare","year")

print("read covariates")
#read zip code covariates
covar<-read_fst("/nfs/home/J/jok8845/shared_space/ci3_analysis/medicare_temperature_humidity/data/confounders/merged_covariates.fst",
                columns = c("zip","year","popdensity"), 
                as.data.table = TRUE)
#colnames(covar)
print("loaded covariates")

#mark high level exposure zip codes
covar[, urban := ifelse(popdensity>=1000,0,1)]

#merge data
print("merge data with covariates")
mdy_data<-merge(mdy_data,covar, by=c("zip","year"),all.x=T)
rm(covar)
gc()

#select individuals that live their entire follow-up in urban areas
mdy_data<-as.data.table(mdy_data[,c("qid","urban")])
mdy_data<-mdy_data[, c(.N,lapply(.SD,sum)),by = c("qid")]
mdy_data<-subset(mdy_data,mdy_data$urban==0)

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

print("join denom with urban")
ALZ<-merge(mdy_data,ALZ,by="qid",all.x=T)

ALZ$N<-NULL
print("individuals in rural areas")
sum(ALZ$urban)
ALZ$urban<-NULL

ALZ[, race3 := integer()][race==2, race3:= 2
                        ][race==3, race3:= 3][race==1, race3:= 1
                          ][race==5, race3:= 3
                            ][race==6, race3:= 3
                              ][race==0, race3:= 3][race==4, race3:= 3][]
  
#get # hospitalizations
sum(ALZ$hosp)

print("# rows in urban cohort")
nrow(ALZ)
merged_data<-ALZ[!followup_year > 1]
print("# individuals in urban cohort in follow-up year 1")
length(unique(ALZ$qid))
print("# unique individuals in urban cohort")
nrow(merged_data)
print("# individuals in urban cohort in follow-up year 1 no duplicates")
merged_data<-merged_data[!duplicated(merged_data[,"qid"])]
nrow(merged_data)
rm(merged_data)

#calculate max followup years
max_fpyears<-ALZ[, .(max_fpy = max(followup_year)), by = qid]
median<-median(max_fpyears$max_fpy)
print(paste("the median follow-up years per individual was", median, "in the urban ALZ cohort"))
iqr<-IQR(max_fpyears$max_fpy)
print(paste("the IQR follow-up years per individual was", iqr, "in the urban ALZ cohort"))
sum<-sum(max_fpyears$max_fpy)
print(paste("the total person years was", sum, "in the urban ALZ cohort"))
rm(max_fpyears)

#to data.frame
ALZ<-data.frame(ALZ)

#calculate total person-time at risk
ALZ$time_count<-ALZ$followup_year_plus_one-ALZ$followup_year
print("calculated time count")

# Calculate the total count of ALZ hospitalizations for strata c at 
# follow-up year a, time year t and location zip code z
ALZcount<-aggregate(ALZ$hosp, by=list(ALZ$sex,ALZ$race3,ALZ$entry_age_break.y,ALZ$dual,ALZ$followup_year,ALZ$zip,ALZ$year), FUN=sum)
print("calculated total ALZ hosp")

write_fst(ALZcount, paste0(new_merged, "ALZ_urban_count.fst"))

gc()

# Calculate the total person-time at-risk for strata c at follow-up 
# year a, time year t and location zip code z
time_count<-aggregate(ALZ$time_count, by=list(ALZ$sex,ALZ$race3,ALZ$entry_age_break,ALZ$dual,ALZ$followup_year,ALZ$zip,ALZ$year), FUN=sum)
print("calculated total person-time at risk")

write_fst(time_count, paste0(new_merged, "time_urban_count.fst"))

rm(ALZ)
gc()
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
nrow(aggregate_ALZ)

#read US regions per zip
zip_region<-read_fst("/nfs/home/J/jok8845/shared_space/ci3_analysis/medicare_temperature_humidity/data/USregions/zip_regions.fst",
                     columns = c("zip", "region"))

#merge US regions
aggregate_ALZ<-merge(aggregate_ALZ, zip_region, by="zip",all.x=T)
nrow(aggregate_ALZ)

# Save the final dataset
write_fst(aggregate_ALZ, paste0(new_merged, "aggregate_ALZ_urban.fst"))
#saveRDS(aggregate_ALZ,paste0(new_merged,"aggregate_ALZ_0016.rds"))
