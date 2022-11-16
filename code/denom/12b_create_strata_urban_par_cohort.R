
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

PAR <- rbindlist(
  lapply(merged_files,
         read_fst,
         columns = c("zip","age","year.medicare","qid",
                     "race","sex","dual","entry_age_break.y",
                     "followup_year","followup_year_plus_one","hosp"),
         as.data.table = TRUE))

print("loaded denom files")
setnames(PAR, "year.medicare", "year")

print("join denom with urban")
RES<-merge(mdy_data,RES,by="qid",all.x=T)

RES$N<-NULL
print("individuals in rural areas")
sum(RES$urban)
RES$urban<-NULL

PAR[, race3 := integer()][race==2, race3:= 2
                        ][race==3, race3:= 3][race==1, race3:= 1
                          ][race==5, race3:= 3
                            ][race==6, race3:= 3
                              ][race==0, race3:= 3][race==4, race3:= 3][]
  
#get # hospitalizations
sum(PAR$hosp)

print("# rows in urban cohort")
nrow(PAR)
merged_data<-PAR[!followup_year > 1]
print("# individuals in urban cohort in follow-up year 1")
length(unique(PAR$qid))
print("# unique individuals in urban cohort")
nrow(merged_data)
print("# individuals in urban cohort in follow-up year 1 no duplicates")
merged_data<-merged_data[!duplicated(merged_data[,"qid"])]
nrow(merged_data)
rm(merged_data)

#calculate max followup years
max_fpyears<-PAR[, .(max_fpy = max(followup_year)), by = qid]
median<-median(max_fpyears$max_fpy)
print(paste("the median follow-up years per individual was", median, "in the urban PAR cohort"))
iqr<-IQR(max_fpyears$max_fpy)
print(paste("the IQR follow-up years per individual was", iqr, "in the urban PAR cohort"))
sum<-sum(max_fpyears$max_fpy)
print(paste("the total person years was", sum, "in the urban PAR cohort"))
rm(max_fpyears)

#to data.frame
PAR<-data.frame(PAR)

#calculate total person-time at risk
PAR$time_count<-PAR$followup_year_plus_one-PAR$followup_year
print("calculated time count")

# Calculate the total count of par hospitalizations for strata c at 
# follow-up year a, time year t and location zip code z
PARcount<-aggregate(PAR$hosp, by=list(PAR$sex,PAR$race3,PAR$entry_age_break.y,PAR$dual,PAR$followup_year,PAR$zip,PAR$year), FUN=sum)
print("calculated total par hosp")

write_fst(PARcount, paste0(new_merged, "PAR_urban_count.fst"))

gc()

# Calculate the total person-time at-risk for strata c at follow-up 
# year a, time year t and location zip code z
time_count<-aggregate(PAR$time_count, by=list(PAR$sex,PAR$race3,PAR$entry_age_break,PAR$dual,PAR$followup_year,PAR$zip,PAR$year), FUN=sum)
print("calculated total person-time at risk")

write_fst(time_count, paste0(new_merged, "time_urban_count.fst"))

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
write_fst(aggregate_PAR, paste0(new_merged, "aggregate_urban_PAR.fst"))
#saveRDS(aggregate_PAR,paste0(new_merged,"aggregate_PAR_0016.rds"))
