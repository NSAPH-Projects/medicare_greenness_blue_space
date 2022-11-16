library(NSAPHutils)

set_threads()

library(data.table)
library(fst)
library(dplyr)

old_merged <- "/nfs/home/J/jok8845/shared_space/ci3_health_data/medicare/gen_admission/1999_2016/Klompmaker/cache_data/no_vary_sex/"
covar_dir <- "/nfs/home/J/jok8845/shared_space/ci3_health_data/medicare/gen_admission/1999_2016/Klompmaker/cache_data/age_entry/"
new_merged <- "/nfs/home/J/jok8845/shared_space/ci3_health_data/medicare/gen_admission/1999_2016/Klompmaker/cache_data/correct_follow_up_age_entry/"

followup_entry <- read_fst(paste0(covar_dir, "entry_age.fst"))

for (filename in list.files(old_merged)) {
  year_data <- read_fst(paste0(old_merged , filename), as.data.table = T)
  year_data <-left_join(year_data,followup_entry, by = "qid")
  year_data <- year_data[!is.na(zip)]
  write_fst(year_data, paste0(new_merged, filename))
}
