library(data.table)
library(fst)
#library(NSAPHutils)
#library(dplyr)

old_merged <- "/nfs/home/J/jok8845/shared_space/ci3_health_data/medicare/gen_admission/1999_2016/Klompmaker/cache_data/hosp_adm/par/correct_followup/"

merged_files <- list.files(
  old_merged,
  pattern = "confounder_exposure_merged_nodups_health_[0-9]+\\.fst",
  full.names = TRUE
)

PAR <- rbindlist(
  lapply(merged_files,
         read_fst,
         columns = c("year.medicare","qid",
                     "followup_year","followup_year_plus_one"),
         as.data.table = TRUE))

fyears<-PAR[,.(start_yr=min(year.medicare),
               end_year=max(year.medicare),
               fwyrs=max(followup_year),
               count=uniqueN(year.medicare)),by=qid]

sum<-fyears[(end_year-start_yr+1) != count,]
length(unique(sum$qid))
