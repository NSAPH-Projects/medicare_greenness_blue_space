library(NSAPHutils)

set_threads()
#library(dplyr)
library(data.table)
library(fst)

old_merged <- "/nfs/home/J/jok8845/shared_space/ci3_health_data/medicare/mortality/1999_2016/wu/cache_data/merged_by_year_v2/"
new_merged <- "/nfs/home/J/jok8845/shared_space/ci3_health_data/medicare/gen_admission/1999_2016/Klompmaker/cache_data/no_vary_sex/"

mdy_data <- read_data(old_merged, years = 2000:2016, columns = c("qid","sex"))
length(unique(mdy_data$qid))
mdy_data <- subset(unique(mdy_data))
mdy_data[, num_change := .N, by = "qid"]
change_demo <- mdy_data[num_change > 1]

setkey(change_demo, qid)

chng_sex <- NULL

for (filename in list.files(old_merged)[2:18]) {
  year_data <- read_fst(paste0(old_merged , filename),
                        columns=c("zip","age","year","bene_dod","qid","statecode","fips","hmo_mo",
                                  "race","sex","dual","dead","entry_age","entry_year", "entry_age_break",
                                  "followup_year","followup_year_plus_one"), as.data.table = T)
  
  #remove individuals outside contiguous US
  year_data <-year_data [statecode != "AK"]
  year_data <-year_data [statecode != "PR"]
  year_data <-year_data [statecode != "HI"]
  year_data <-year_data [statecode != "VI"]
  year_data <-year_data [statecode != "MP"]
  year_data <-year_data [statecode != "GU"]
  year_data <-year_data [statecode != "MH"]
  year_data <-year_data [statecode != "AS"]
  year_data <-year_data [statecode != "FM"]
  year_data <-year_data [statecode != "PW"]
  year_data <-year_data [statecode != ""]
  year_data <- year_data[!is.na(fips)] #remove individuals with missing FIPS
  year_data <- year_data[hmo_mo == "0"] #remove subjects with HMO_MO
  setkey(year_data, qid)
  year_data <- year_data[!change_demo]
  
  if (!is.null(chng_sex))  {
    setkey(chng_sex, qid)
    year_data <- year_data[!chng_sex]
  }
  
  write_fst(year_data, paste0(new_merged, filename))
}
