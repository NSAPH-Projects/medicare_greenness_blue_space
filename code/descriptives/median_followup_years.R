nthreads <- 1
cachedir <- "/nfs/home/J/jok8845/shared_space/ci3_health_data/medicare/gen_admission/1999_2016/Klompmaker/cache_data/hosp_adm/res/correct_followup/"

## load packages and set options
options(fst_threads = nthreads)
library(data.table)
library(fst)
library(parallel)
#library(dplyr)
#library(NSAPHutils)
setDTthreads(nthreads)
threads_fst(nr_of_threads = nthreads)

## participant - level variables
#print("reading health data")
#health <- rbindlist(
#  mclapply(list.files(paste0(cachedir), pattern = "confounder_exposure_merged_nodups_health_[0-9]{4}\\.fst", full.names = TRUE),
#           read_fst,
#           as.data.table = TRUE,
#           columns = c("qid", "followup_year"),
#           mc.cores = 19))

#calculate max followup years
#max_fpyears<-health[, .(max_fpy = max(followup_year)), by = qid]
#median<-median(max_fpyears$max_fpy)
#print(paste("the median follow-up years per individual was", median, "in the res cohort"))
#iqr<-IQR(max_fpyears$max_fpy)
#print(paste("the IQR follow-up years per individual was", iqr, "in the res cohort"))
#mean<-mean(max_fpyears$max_fpy)
#print(paste("the mean follow-up years per individual was", mean, "in the res cohort"))
#sum<-sum(max_fpyears$max_fpy)
#print(paste("the total person years was", sum, "in the res cohort"))

#alz cohort
cachedir <- "/nfs/home/J/jok8845/shared_space/ci3_health_data/medicare/gen_admission/1999_2016/Klompmaker/cache_data/hosp_adm/alz/correct_followup/"

## participant - level variables
#print("reading health data")
health <- rbindlist(
  mclapply(list.files(paste0(cachedir), pattern = "confounder_exposure_merged_nodups_health_[0-9]{4}\\.fst", full.names = TRUE),
           read_fst,
           as.data.table = TRUE,
           columns = c("qid", "followup_year"),
           mc.cores = 19))

#calculate max followup years
max_fpyears<-health[, .(max_fpy = max(followup_year)), by = qid]
median<-median(max_fpyears$max_fpy)
print(paste("the median follow-up years per individual was", median, "in the alz cohort"))
iqr<-IQR(max_fpyears$max_fpy)
print(paste("the IQR follow-up years per individual was", iqr, "in the alz cohort"))
mean<-mean(max_fpyears$max_fpy)
print(paste("the mean follow-up years per individual was", mean, "in the alz cohort"))
sum<-sum(max_fpyears$max_fpy)
print(paste("the total person years was", sum, "in the alz cohort"))

#par cohort
cachedir <- "/nfs/home/J/jok8845/shared_space/ci3_health_data/medicare/gen_admission/1999_2016/Klompmaker/cache_data/hosp_adm/par/correct_followup/"

## participant - level variables
#print("reading health data")
health <- rbindlist(
  mclapply(list.files(paste0(cachedir), pattern = "confounder_exposure_merged_nodups_health_[0-9]{4}\\.fst", full.names = TRUE),
           read_fst,
           as.data.table = TRUE,
           columns = c("qid", "followup_year"),
           mc.cores = 19))

#calculate max followup years
max_fpyears<-health[, .(max_fpy = max(followup_year)), by = qid]
median<-median(max_fpyears$max_fpy)
print(paste("the median follow-up years per individual was", median, "in the par cohort"))
iqr<-IQR(max_fpyears$max_fpy)
print(paste("the IQR follow-up years per individual was", iqr, "in the par cohort"))
mean<-mean(max_fpyears$max_fpy)
print(paste("the mean follow-up years per individual was", mean, "in the par cohort"))
sum<-sum(max_fpyears$max_fpy)
print(paste("the total person years was", sum, "in the par cohort"))

