
#library(NSAPHutils)
#library(NSAPHplatform)
#set_threads()
library(fst)
library(data.table)
library(lubridate)
#library(icd)
#install.packages("dplyr", repos = "http://cran.us.r-project.org")
#library(dplyr)

old_merged <- "/nfs/home/J/jok8845/shared_space/ci3_health_data/medicare/gen_admission/1999_2016/Klompmaker/cache_data/correct_follow_up_age_entry/"

## Define cardiovascular conditions
#all cardiovascular disease
#par_icd9 <- c("332","3320","3321")
#par_icd10 <- c("G20","G2111","G2119","G218")

## Load all admissions
## Needed because admissions in year of disharge, not admission
#admissions <- read_data("/nfs/home/J/jok8845/shared_space/ci3_health_data/medicare/gen_admission/1999_2016/targeted_conditions/cache_data/admissions_by_year/", years = 2000:2016,
#                        columns = c("QID",
#                                    "ADATE",
#                                    "DDATE",
#                                    "Parkinson_pdx2dx_10"))
adm2000<-read_fst("/nfs/home/J/jok8845/shared_space/ci3_health_data/medicare/gen_admission/1999_2016/targeted_conditions/cache_data/admissions_by_year/admissions_2000.fst",columns = c("QID","ADATE","DDATE","Parkinson_pdx2dx_10"))
adm2001<-read_fst("/nfs/home/J/jok8845/shared_space/ci3_health_data/medicare/gen_admission/1999_2016/targeted_conditions/cache_data/admissions_by_year/admissions_2001.fst",columns = c("QID","ADATE","DDATE","Parkinson_pdx2dx_10"))
adm2002<-read_fst("/nfs/home/J/jok8845/shared_space/ci3_health_data/medicare/gen_admission/1999_2016/targeted_conditions/cache_data/admissions_by_year/admissions_2002.fst",columns = c("QID","ADATE","DDATE","Parkinson_pdx2dx_10"))
adm2003<-read_fst("/nfs/home/J/jok8845/shared_space/ci3_health_data/medicare/gen_admission/1999_2016/targeted_conditions/cache_data/admissions_by_year/admissions_2003.fst",columns = c("QID","ADATE","DDATE","Parkinson_pdx2dx_10"))
adm2004<-read_fst("/nfs/home/J/jok8845/shared_space/ci3_health_data/medicare/gen_admission/1999_2016/targeted_conditions/cache_data/admissions_by_year/admissions_2004.fst",columns = c("QID","ADATE","DDATE","Parkinson_pdx2dx_10"))
adm2005<-read_fst("/nfs/home/J/jok8845/shared_space/ci3_health_data/medicare/gen_admission/1999_2016/targeted_conditions/cache_data/admissions_by_year/admissions_2005.fst",columns = c("QID","ADATE","DDATE","Parkinson_pdx2dx_10"))
adm2006<-read_fst("/nfs/home/J/jok8845/shared_space/ci3_health_data/medicare/gen_admission/1999_2016/targeted_conditions/cache_data/admissions_by_year/admissions_2006.fst",columns = c("QID","ADATE","DDATE","Parkinson_pdx2dx_10"))
adm2007<-read_fst("/nfs/home/J/jok8845/shared_space/ci3_health_data/medicare/gen_admission/1999_2016/targeted_conditions/cache_data/admissions_by_year/admissions_2007.fst",columns = c("QID","ADATE","DDATE","Parkinson_pdx2dx_10"))
adm2008<-read_fst("/nfs/home/J/jok8845/shared_space/ci3_health_data/medicare/gen_admission/1999_2016/targeted_conditions/cache_data/admissions_by_year/admissions_2008.fst",columns = c("QID","ADATE","DDATE","Parkinson_pdx2dx_10"))
adm2009<-read_fst("/nfs/home/J/jok8845/shared_space/ci3_health_data/medicare/gen_admission/1999_2016/targeted_conditions/cache_data/admissions_by_year/admissions_2009.fst",columns = c("QID","ADATE","DDATE","Parkinson_pdx2dx_10"))
adm2010<-read_fst("/nfs/home/J/jok8845/shared_space/ci3_health_data/medicare/gen_admission/1999_2016/targeted_conditions/cache_data/admissions_by_year/admissions_2010.fst",columns = c("QID","ADATE","DDATE","Parkinson_pdx2dx_10"))
adm2011<-read_fst("/nfs/home/J/jok8845/shared_space/ci3_health_data/medicare/gen_admission/1999_2016/targeted_conditions/cache_data/admissions_by_year/admissions_2011.fst",columns = c("QID","ADATE","DDATE","Parkinson_pdx2dx_10"))
adm2012<-read_fst("/nfs/home/J/jok8845/shared_space/ci3_health_data/medicare/gen_admission/1999_2016/targeted_conditions/cache_data/admissions_by_year/admissions_2012.fst",columns = c("QID","ADATE","DDATE","Parkinson_pdx2dx_10"))
adm2013<-read_fst("/nfs/home/J/jok8845/shared_space/ci3_health_data/medicare/gen_admission/1999_2016/targeted_conditions/cache_data/admissions_by_year/admissions_2013.fst",columns = c("QID","ADATE","DDATE","Parkinson_pdx2dx_10"))
adm2014<-read_fst("/nfs/home/J/jok8845/shared_space/ci3_health_data/medicare/gen_admission/1999_2016/targeted_conditions/cache_data/admissions_by_year/admissions_2014.fst",columns = c("QID","ADATE","DDATE","Parkinson_pdx2dx_10"))
adm2015<-read_fst("/nfs/home/J/jok8845/shared_space/ci3_health_data/medicare/gen_admission/1999_2016/targeted_conditions/cache_data/admissions_by_year/admissions_2015.fst",columns = c("QID","ADATE","DDATE","Parkinson_pdx2dx_10"))
adm2016<-read_fst("/nfs/home/J/jok8845/shared_space/ci3_health_data/medicare/gen_admission/1999_2016/targeted_conditions/cache_data/admissions_by_year/admissions_2016.fst",columns = c("QID","ADATE","DDATE","Parkinson_pdx2dx_10"))

admissions<-rbind(adm2000,adm2001,adm2002,adm2003,adm2004,adm2005,adm2006,adm2007,adm2008,adm2009,adm2010,adm2011,adm2012,adm2013,adm2014,adm2015,adm2016)
rm(adm2000,adm2001,adm2002,adm2003,adm2004,adm2005,adm2006,adm2007,adm2008,adm2009,adm2010,adm2011,adm2012,adm2013,adm2014,adm2015,adm2016)
gc()
admissions<-as.data.table(admissions)
admissions[, ADATE := dmy(ADATE)]
admissions[, DDATE := dmy(DDATE)]
admissions[, year := year(ADATE)] #create year row
admissions <- admissions[year %in% 2000:2016] #only keep admissions with admission date in year (2000-2016)

## Process ICD9 codes
#admissions[DDATE < "2015-10-01", par1 := DIAG1 %in% par_icd9]
#admissions[DDATE < "2015-10-01", par2 := DIAG2 %in% par_icd9]

## process ICD 10 Codes
#admissions[DDATE >= "2015-10-01", par1 := DIAG1 %in% par_icd10]
#admissions[DDATE >= "2015-10-01", par2 := DIAG2 %in% par_icd10]

#create one alz indicator
#admissions[,alz:=FALSE]
admissions[Parkinson_pdx2dx_10==T, par:=TRUE]

##keep only alz admissions 
admissions <- admissions[par %in% TRUE]

#admission diagnoses
sum(admissions$par)

admissions$Parkinson_pdx2dx_10<-NULL

##############################################################################################
#merge with individuals from cohortto get only admissions for the years that they are included (no HMO coverage)
##############################################################################################

#mdy_data <- read_data(old_merged, years = 2000:2016, columns = c("qid","year"))
adm2000<-read_fst("/nfs/home/J/jok8845/shared_space/ci3_health_data/medicare/gen_admission/1999_2016/Klompmaker/cache_data/correct_follow_up_age_entry2/confounder_exposure_merged_nodups_health_2000.fst", columns = c("qid","year"))
adm2001<-read_fst("/nfs/home/J/jok8845/shared_space/ci3_health_data/medicare/gen_admission/1999_2016/Klompmaker/cache_data/correct_follow_up_age_entry2/confounder_exposure_merged_nodups_health_2001.fst", columns = c("qid","year"))
adm2002<-read_fst("/nfs/home/J/jok8845/shared_space/ci3_health_data/medicare/gen_admission/1999_2016/Klompmaker/cache_data/correct_follow_up_age_entry2/confounder_exposure_merged_nodups_health_2002.fst", columns = c("qid","year"))
adm2003<-read_fst("/nfs/home/J/jok8845/shared_space/ci3_health_data/medicare/gen_admission/1999_2016/Klompmaker/cache_data/correct_follow_up_age_entry2/confounder_exposure_merged_nodups_health_2003.fst", columns = c("qid","year"))
adm2004<-read_fst("/nfs/home/J/jok8845/shared_space/ci3_health_data/medicare/gen_admission/1999_2016/Klompmaker/cache_data/correct_follow_up_age_entry2/confounder_exposure_merged_nodups_health_2004.fst", columns = c("qid","year"))
adm2005<-read_fst("/nfs/home/J/jok8845/shared_space/ci3_health_data/medicare/gen_admission/1999_2016/Klompmaker/cache_data/correct_follow_up_age_entry2/confounder_exposure_merged_nodups_health_2005.fst", columns = c("qid","year"))
adm2006<-read_fst("/nfs/home/J/jok8845/shared_space/ci3_health_data/medicare/gen_admission/1999_2016/Klompmaker/cache_data/correct_follow_up_age_entry2/confounder_exposure_merged_nodups_health_2006.fst", columns = c("qid","year"))
adm2007<-read_fst("/nfs/home/J/jok8845/shared_space/ci3_health_data/medicare/gen_admission/1999_2016/Klompmaker/cache_data/correct_follow_up_age_entry2/confounder_exposure_merged_nodups_health_2007.fst", columns = c("qid","year"))
adm2008<-read_fst("/nfs/home/J/jok8845/shared_space/ci3_health_data/medicare/gen_admission/1999_2016/Klompmaker/cache_data/correct_follow_up_age_entry2/confounder_exposure_merged_nodups_health_2008.fst", columns = c("qid","year"))
adm2009<-read_fst("/nfs/home/J/jok8845/shared_space/ci3_health_data/medicare/gen_admission/1999_2016/Klompmaker/cache_data/correct_follow_up_age_entry2/confounder_exposure_merged_nodups_health_2009.fst", columns = c("qid","year"))
adm2010<-read_fst("/nfs/home/J/jok8845/shared_space/ci3_health_data/medicare/gen_admission/1999_2016/Klompmaker/cache_data/correct_follow_up_age_entry2/confounder_exposure_merged_nodups_health_2010.fst", columns = c("qid","year"))
adm2011<-read_fst("/nfs/home/J/jok8845/shared_space/ci3_health_data/medicare/gen_admission/1999_2016/Klompmaker/cache_data/correct_follow_up_age_entry2/confounder_exposure_merged_nodups_health_2011.fst", columns = c("qid","year"))
adm2012<-read_fst("/nfs/home/J/jok8845/shared_space/ci3_health_data/medicare/gen_admission/1999_2016/Klompmaker/cache_data/correct_follow_up_age_entry2/confounder_exposure_merged_nodups_health_2012.fst", columns = c("qid","year"))
adm2013<-read_fst("/nfs/home/J/jok8845/shared_space/ci3_health_data/medicare/gen_admission/1999_2016/Klompmaker/cache_data/correct_follow_up_age_entry2/confounder_exposure_merged_nodups_health_2013.fst", columns = c("qid","year"))
adm2014<-read_fst("/nfs/home/J/jok8845/shared_space/ci3_health_data/medicare/gen_admission/1999_2016/Klompmaker/cache_data/correct_follow_up_age_entry2/confounder_exposure_merged_nodups_health_2014.fst", columns = c("qid","year"))
adm2015<-read_fst("/nfs/home/J/jok8845/shared_space/ci3_health_data/medicare/gen_admission/1999_2016/Klompmaker/cache_data/correct_follow_up_age_entry2/confounder_exposure_merged_nodups_health_2015.fst", columns = c("qid","year"))
adm2016<-read_fst("/nfs/home/J/jok8845/shared_space/ci3_health_data/medicare/gen_admission/1999_2016/Klompmaker/cache_data/correct_follow_up_age_entry2/confounder_exposure_merged_nodups_health_2016.fst", columns = c("qid","year"))

mdy_data<-rbind(adm2000,adm2001,adm2002,adm2003,adm2004,adm2005,adm2006,adm2007,adm2008,adm2009,adm2010,adm2011,adm2012,adm2013,adm2014,adm2015,adm2016)
rm(adm2000,adm2001,adm2002,adm2003,adm2004,adm2005,adm2006,adm2007,adm2008,adm2009,adm2010,adm2011,adm2012,adm2013,adm2014,adm2015,adm2016)
gc()
mdy_data<-as.data.table(mdy_data)
setnames(mdy_data, "qid", "QID")
nobs<-length(unique(admissions$QID))
admissions<-merge(admissions, mdy_data, by = c("QID","year"),all.x=F,all.y=F)
ndropped_obs <- nobs - length(unique(admissions$QID))
print(paste("dropped", ndropped_obs, "individuals that are not included in the cohort"))

write_fst(admissions, "/nfs/home/J/jok8845/shared_space/ci3_health_data/medicare/gen_admission/1999_2016/Klompmaker/admission_data/all_par_20002016.fst")
