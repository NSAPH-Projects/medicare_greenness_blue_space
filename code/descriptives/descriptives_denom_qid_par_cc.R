nthreads <- 4 ## higher values might require more memory
resultsdir   <- "/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/descriptives/"
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
con<-read_fst("/nfs/home/J/jok8845/shared_space/ci3_analysis/jklompmaker/par2/cc_zipyear_par.fst")

merged_data <-rbindlist(lapply(merged_files,
                               read_fst,
                               columns = c("qid","zip","year.medicare","sex", "race", "dual","entry_age_break.y","statecode","followup_year"),
                               as.data.table = TRUE))

setnames(merged_data,"year.medicare","year")
length(unique(merged_data$qid))
#merged_data<-merge(merged_data, cc, all.x=T)
#length(unique(merged_data$qid))
merged_data<-merge(merged_data, con, by=c("zip","year"))
length(unique(merged_data$qid))
merged_data<-na.omit(merged_data)
length(unique(merged_data$qid))

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

#read US regions per merged_data
merged_data[statecode=="WV" | statecode=="DC" | statecode=="VA" | statecode=="KY" | statecode=="MD" | statecode=="DE" 
            | statecode=="TN" | statecode== "NC" | statecode== "SC" | statecode== "GA" | statecode== "FL" | statecode=="OK" | statecode=="TX"
            | statecode== "AL" | statecode=="MS" | statecode=="LA" | statecode=="AR", region := "South"]#17
merged_data[statecode=="ME" | statecode=="VT" | statecode=="NH" | statecode=="MA" | statecode=="NY" | statecode=="RI" 
            | statecode=="CT" | statecode== "NJ" | statecode== "PA", region := "Northeast"] #9 states delaware and maryland
merged_data[statecode=="ND" | statecode=="MN" | statecode=="WI" | statecode=="MI" | statecode=="OH" | statecode=="IN" 
            | statecode=="IL" | statecode== "MO" | statecode=="KS" | statecode=="NE" | statecode== "SD" | statecode== "IA", region := "Midwest"] #12
merged_data[statecode=="AZ" | statecode=="NM" | statecode=="MT" | statecode=="WY" | statecode=="CO" | statecode=="UT" | statecode=="NV" | statecode=="CA" 
            | statecode=="OR" | statecode== "WA" | statecode=="ID", region := "West"] #11

## Utility functions
des.cat<-function(x){
  res<-data.frame(N=length(x),absolute=table(x),relative=prop.table(table(x)))
}
cat_out<-do.call(rbind,lapply(merged_data[,c("sex", "race", "dual","entry_age_break.y", "region")],des.cat))
fwrite(cat_out, paste0(resultsdir, "merged_2000_2016_data_sum_parcc.csv"), row.names = T)
