nthreads <- 1
cachedir <- "/nfs/home/J/jok8845/shared_space/ci3_health_data/medicare/gen_admission/1999_2016/Klompmaker/cache_data/hosp_adm/alz/"
new_merged <- "/nfs/home/J/jok8845/shared_space/ci3_health_data/medicare/gen_admission/1999_2016/Klompmaker/cache_data/hosp_adm/alz/correct_followup/"

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
health <- rbindlist(
  mclapply(list.files(paste0(cachedir), pattern = "confounder_exposure_merged_nodups_health_[0-9]{4}\\.fst", full.names = TRUE),
           read_fst,
           as.data.table = TRUE,
           columns = c("year.medicare", "qid", "entry_year.y"),
           mc.cores = 19))

length(unique(health$qid))

#calculate correct followup years
total_years<-health[order(year.medicare), .(followup_year = c(1:.N), year.medicare=year.medicare), by = qid]

for (filename in list.files(cachedir)) {
  year_data <- read_fst(paste0(cachedir , filename), 
                        columns=c("zip","age","year.medicare","qid","statecode",
                        "race","sex","dual","entry_year.y","entry_age.y", 
                        "entry_age_break.y","hosp"), as.data.table = T)
  year_data <-merge(year_data,total_years, by = c("qid","year.medicare"),all.x=T)
  year_data<-as.data.table(year_data)
  year_data[, followup_year_plus_one := followup_year + 1]
  write_fst(year_data, paste0(new_merged, filename))
}
