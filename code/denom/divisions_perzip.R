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

#create 9 US divisions
zip[statecode=="WV" | statecode=="DC" | statecode=="VA" | statecode=="MD" | statecode=="DE" 
    | statecode== "NC" | statecode== "SC" | statecode== "GA" | statecode== "FL", division := "S_Atlantic"]
zip[statecode=="KY" | statecode=="TN" | statecode== "AL" | statecode=="MS", division := "ES_Central"]
zip[statecode=="OK" | statecode=="TX" | statecode=="LA" | statecode=="AR", division := "WS_Central"]
zip[statecode=="ME" | statecode=="VT" | statecode=="NH" | statecode=="MA" | statecode=="RI" | statecode=="CT", division := "New_England"] 
zip[statecode=="NY" | statecode== "NJ" | statecode== "PA", division := "M_Atlantic"]
zip[statecode=="ND" | statecode=="MN" | statecode== "MO" | statecode=="KS" | statecode=="NE" | statecode== "SD" | statecode== "IA", division := "WN_Central"] 
zip[statecode=="WI" | statecode=="MI" | statecode=="OH" | statecode=="IN" | statecode=="IL", division := "EN_Central"] 
zip[statecode=="AZ" | statecode=="NM" | statecode=="MT" | statecode=="WY" | statecode=="CO" | statecode=="UT" | statecode=="NV" 
    | statecode=="ID", division := "Mountain"]
zip[statecode=="CA" | statecode=="OR" | statecode== "WA", division := "Pacific"]

length(unique(zip$zip))
sum(is.na(zip$division))

zip_div<-zip[ !duplicated(zip, fromLast=T),]

write_fst(zip_div, "/nfs/home/J/jok8845/shared_space/ci3_analysis/medicare_temperature_humidity/data/USregions/zip_divisions.fst")
