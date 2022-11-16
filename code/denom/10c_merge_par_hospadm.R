#library(NSAPHutils)

#set_threads()

library(data.table)
library(fst)
#library(dplyr)

old_merged <- "/nfs/home/J/jok8845/shared_space/ci3_health_data/medicare/gen_admission/1999_2016/Klompmaker/cache_data/correct_follow_up_age_entry2/"
new_merged <- "/nfs/home/J/jok8845/shared_space/ci3_health_data/medicare/gen_admission/1999_2016/Klompmaker/cache_data/hosp_adm/par/"
hospdir <- "/nfs/home/J/jok8845/shared_space/ci3_health_data/medicare/gen_admission/1999_2016/Klompmaker/admission_data/"

par_first <- read_fst(paste0(hospdir, "first_par_20002016.fst"))

par_first$qid<-as.character(par_first$QID)
par_first$QID<-NULL

for (filename in list.files(old_merged)) {
  year_data <- read_fst(paste0(old_merged , filename),
                        columns=c("zip","age","year","qid","statecode",
                                  "race","sex","dual","entry_age.y","entry_year.y", 
                                  "entry_age_break.y"), as.data.table = T)
  year_data <-merge(year_data,par_first, by = "qid",all.x=T,
                        suffix = c(".medicare", ".hosp_adm"))
  #remove hospitalizations from earlier years
  year_data<-as.data.table(year_data)
  nobs <- nrow(year_data)
  year_data[, par_hosp := is.na(year.hosp_adm) | year.hosp_adm >= year.medicare]
  year_data<-year_data[par_hosp!=F]
  ndropped_obs <- nobs - nrow(year_data)
  print(paste("dropped", ndropped_obs, "individuals with first hospitalization <",year_data$year.medicare[1],"year"))
  #get hospitalization from this year
  year_data[, hosp := par==1 & year.hosp_adm == year.medicare][is.na(year.hosp_adm), hosp := FALSE][]
  #calculate follow_up_year
  year_data[, followup_year := year.medicare - entry_year.y + 1]
  year_data[, followup_year_plus_one := followup_year + 1]
  #remove columns
  year_data[, par_hosp := NULL]
  year_data[, par := NULL]
  year_data[, year.hosp_adm := NULL]
  write_fst(year_data, paste0(new_merged, filename))
}
