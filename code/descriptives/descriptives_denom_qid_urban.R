nthreads <- 4 ## higher values might require more memory
resultsdir   <- "/nfs/home/J/jok8845/shared_space/ci3_analysis/medicare_temperature_humidity/Modeloutput/descriptives/"
merged_sharddir <- "/nfs/home/J/jok8845/shared_space/ci3_health_data/medicare/gen_admission/1999_2016/Klompmaker/cache_data/hosp_adm/alz/correct_followup/"

## load packages and set options
options(fst_threads = nthreads)
library(data.table)
library(fst)
library(parallel)
library(reshape)
#library(dplyr)
setDTthreads(nthreads)
threads_fst(nr_of_threads = nthreads)

#list files
merged_files <- list.files(
  merged_sharddir,
  pattern = "confounder_exposure_merged_nodups_health_[0-9]+\\.fst",
  full.names = TRUE
)

#read data
#cc<-read_fst("/nfs/home/J/jok8845/shared_space/ci3_health_data/medicare/gen_admission/1999_2016/Klompmaker/merged_data/cvd2/cc_zipyear_all.fst")
covar<-read_fst("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/data/confounders/merged_covariates.fst")
covar<-covar[,c("zip","year","popdensity")]

merged_data <-rbindlist(lapply(merged_files,
                               read_fst,
                               columns = c("qid","zip","year.medicare","followup_year","hosp"),
                               as.data.table = TRUE))

setnames(merged_data,"year.medicare","year")
length(unique(merged_data$qid))
print("tot hosp")
sum(merged_data$hosp)
#merged_data<-merge(merged_data, cc, all.x=T)
#length(unique(merged_data$qid))
merged_data<-merge(merged_data, covar, by=c("zip","year"),all.x=T)
length(unique(merged_data$qid))
sum(merged_data$hosp)
merged_data<-merged_data[popdensity>=1000,]
length(unique(merged_data$qid))
print("urb hosp")
sum(merged_data$hosp)

setDT(merged_data)
merged_data<-merged_data[order(followup_year), .SD[1], by=qid]
nrow(merged_data)
length(unique(merged_data$qid))
max(merged_data$followup_year)
#sum(merged_data$followup_year)
#merged_data<-merged_data[!followup_year > 1]
#nrow(merged_data)
#merged_data<-merged_data[!duplicated(merged_data[,"qid"])]
#nrow(merged_data)

## Utility functions
#des.cat<-function(x){
#  res<-data.frame(N=length(x),absolute=table(x),relative=prop.table(table(x)))
#}
#cat_out<-do.call(rbind,lapply(merged_data[,c("sex", "race", "dual","entry_age_break.y")],des.cat))
#fwrite(cat_out, paste0(resultsdir, "merged_2000_2016_data_sum_cvd_cc.csv"), row.names = T)


merged_sharddir <- "/nfs/home/J/jok8845/shared_space/ci3_health_data/medicare/gen_admission/1999_2016/Klompmaker/cache_data/hosp_adm/par/correct_followup/"

## load packages and set options
options(fst_threads = nthreads)
library(data.table)
library(fst)
library(parallel)
library(reshape)
#library(dplyr)
setDTthreads(nthreads)
threads_fst(nr_of_threads = nthreads)

#list files
merged_files <- list.files(
  merged_sharddir,
  pattern = "confounder_exposure_merged_nodups_health_[0-9]+\\.fst",
  full.names = TRUE
)

#read data
#cc<-read_fst("/nfs/home/J/jok8845/shared_space/ci3_health_data/medicare/gen_admission/1999_2016/Klompmaker/merged_data/cvd2/cc_zipyear_all.fst")
covar<-read_fst("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/data/confounders/merged_covariates.fst")
covar<-covar[,c("zip","year","popdensity")]

merged_data <-rbindlist(lapply(merged_files,
                               read_fst,
                               columns = c("qid","zip","year.medicare","followup_year","hosp"),
                               as.data.table = TRUE))

setnames(merged_data,"year.medicare","year")
length(unique(merged_data$qid))
print("tot hosp")
sum(merged_data$hosp)
#merged_data<-merge(merged_data, cc, all.x=T)
#length(unique(merged_data$qid))
merged_data<-merge(merged_data, covar, by=c("zip","year"),all.x=T)
length(unique(merged_data$qid))
sum(merged_data$hosp)
merged_data<-merged_data[popdensity>=1000,]
length(unique(merged_data$qid))
print("urb hosp")
sum(merged_data$hosp)


setDT(merged_data)
merged_data<-merged_data[order(followup_year), .SD[1], by=qid]
nrow(merged_data)
length(unique(merged_data$qid))
max(merged_data$followup_year)