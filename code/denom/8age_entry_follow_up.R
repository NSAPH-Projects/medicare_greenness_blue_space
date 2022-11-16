nthreads <- 1
cachedir <- "/nfs/home/J/jok8845/shared_space/ci3_health_data/medicare/gen_admission/1999_2016/Klompmaker/cache_data/no_vary_sex/"
covar_dir <- "/nfs/home/J/jok8845/shared_space/ci3_health_data/medicare/gen_admission/1999_2016/Klompmaker/cache_data/age_entry/"

## load packages and set options
options(fst_threads = nthreads)
library(data.table)
library(fst)
library(parallel)
library(NSAPHutils)
setDTthreads(nthreads)
threads_fst(nr_of_threads = nthreads)

## participant - level variables
#print("reading health data")
health <- rbindlist(
  mclapply(list.files(paste0(cachedir), pattern = "confounder_exposure_merged_nodups_health_[0-9]{4}\\.fst", full.names = TRUE),
           read_fst,
           as.data.table = TRUE,
           columns = c("year", "qid", "age"),
           mc.cores = 19))

#health <- read_data(cachedir, years = 2000:2016, columns = c("qid","age","year"))

print("computing participant level variables")
health <-
  health[,
         .(entry_age = min(age, na.rm = TRUE),
           entry_year = min(year, na.rm = TRUE)),
         by = "qid"
         ]

health <-
  health[,
                 entry_age_break := cut(entry_age,
                                        c(seq(65, 120, by = 2)),
                                        include.lowest = TRUE,
                                        right = FALSE,
                                        labels = FALSE)]

write_fst(health, paste0(covar_dir, "entry_age.fst"))
