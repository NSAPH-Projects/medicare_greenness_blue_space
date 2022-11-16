nthreads <- 1
cachedir <- "/nfs/home/J/jok8845/shared_space/ci3_health_data/medicare/gen_admission/1999_2016/Klompmaker/cache_data/correct_follow_up_age_entry2/"

## load packages and set options
options(fst_threads = nthreads)
library(data.table)
library(fst)
library(parallel)
#library(dplyr)
#library(NSAPHutils)
#setDTthreads(nthreads)
#threads_fst(nr_of_threads = nthreads)

## participant - level variables
#print("reading health data")
health <- rbindlist(
  mclapply(list.files(paste0(cachedir), pattern = "confounder_exposure_merged_nodups_health_[0-9]{4}\\.fst", full.names = TRUE),
           read_fst,
           as.data.table = TRUE,
           columns = c("zip", "statecode"),
           mc.cores = 19))

#get unique zip codes
zip<-unique(health)

#create 5 US regions
zip[statecode=="WV" | statecode=="DC" | statecode=="VA" | statecode=="KY" | statecode=="MD" | statecode=="DE" 
    | statecode=="TN" | statecode== "NC" | statecode== "SC" | statecode== "GA" | statecode== "FL" | statecode=="OK" | statecode=="TX"
    | statecode== "AL" | statecode=="MS" | statecode=="LA" | statecode=="AR", region := "South"]#17
zip[statecode=="ME" | statecode=="VT" | statecode=="NH" | statecode=="MA" | statecode=="NY" | statecode=="RI" 
    | statecode=="CT" | statecode== "NJ" | statecode== "PA", region := "Northeast"] #9 states delaware and maryland
zip[statecode=="ND" | statecode=="MN" | statecode=="WI" | statecode=="MI" | statecode=="OH" | statecode=="IN" 
    | statecode=="IL" | statecode== "MO" | statecode=="KS" | statecode=="NE" | statecode== "SD" | statecode== "IA", region := "Midwest"] #12
zip[statecode=="AZ" | statecode=="NM" | statecode=="MT" | statecode=="WY" | statecode=="CO" | statecode=="UT" | statecode=="NV" | statecode=="CA" 
    | statecode=="OR" | statecode== "WA" | statecode=="ID", region := "West"] #11

length(unique(zip$zip))
sum(is.na(zip$region))

zip2<-zip[ !duplicated(zip, fromLast=T),]

write_fst(zip2, "/nfs/home/J/jok8845/shared_space/ci3_analysis/medicare_temperature_humidity/data/USregions/zip_4regions.fst")
