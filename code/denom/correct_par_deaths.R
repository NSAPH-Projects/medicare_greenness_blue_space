nthreads <- 1
cachedir <- "/nfs/home/J/jok8845/shared_space/ci3_health_data/medicare/gen_admission/1999_2016/Klompmaker/cache_data/hosp_adm/par_death/"
new_merged <- "/nfs/home/J/jok8845/shared_space/ci3_health_data/medicare/gen_admission/1999_2016/Klompmaker/cache_data/hosp_adm/par_death_correct/"

## load packages and set options
#options(fst_threads = nthreads)
library(data.table)
library(fst)
#library(parallel)
#library(dplyr)
#library(NSAPHutils)
#setDTthreads(nthreads)
#threads_fst(nr_of_threads = nthreads)

#read data
for (filename in list.files(cachedir)) {
  year_data <- read_fst(paste0(cachedir ,filename), as.data.table = T)
  sum(year_data$death)
  year_data$death <- ifelse(year_data$death==1 & year_data$hosp==1,0,year_data$death)
  sum(year_data$death)
  write_fst(year_data, paste0(new_merged, filename))
}
