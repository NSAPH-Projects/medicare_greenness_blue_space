#script based on new icd codes (check number of hosp with shuxin)
#library(NSAPHutils)
#library(NSAPHplatform)
#set_threads()
library(fst)
library(data.table)
library(lubridate)
#library(icd)
#library(dplyr)

old_merged <- "/nfs/home/J/jok8845/shared_space/ci3_health_data/medicare/gen_admission/1999_2016/Klompmaker/cache_data/correct_follow_up_age_entry2/"

## Define cardiovascular conditions
#all cardiovascular disease
#cbv_icd9 <- expand_range("460","519")
adrd_icd9 <- c("3310","33111","33119","3312","3317","2900","29010","29011","29012","29013",
               "29020","29021","2903","29040","29041","29042","29043",
               "2940","29410","29411","29420","29421","2948","797") 
#children("G310")

#cbv_icd10 <- expand_range("J00","J99")
adrd_icd10<-c("F0150","F0151","F0280","F0281","F0390","F0391","F04","F05","F061","F068",
              "G138","G300","G301","G308","G309","G3101","G3109","G311","G312","G94","R4181","R54")

## Load all admissions
## Needed because admissions in year of disharge, not admission
#admissions <- read_data("/nfs/home/J/jok8845/shared_space/ci3_health_data/medicare/gen_admission/1999_2016/targeted_conditions/cache_data/admissions_by_year/", years = 2000:2016,
#                        columns = c("QID",
#                                    "ADATE",
#                                    "DDATE",
#                                    "DIAG1"))
adm2000<-read_fst("/nfs/home/J/jok8845/shared_space/ci3_health_data/medicare/gen_admission/1999_2016/targeted_conditions/cache_data/admissions_by_year/admissions_2000.fst",columns = c("QID","ADATE","DDATE",'DIAG1','DIAG2','DIAG3','DIAG4','DIAG5','DIAG6','DIAG7','DIAG8','DIAG9','DIAG10'))
adm2001<-read_fst("/nfs/home/J/jok8845/shared_space/ci3_health_data/medicare/gen_admission/1999_2016/targeted_conditions/cache_data/admissions_by_year/admissions_2001.fst",columns = c("QID","ADATE","DDATE",'DIAG1','DIAG2','DIAG3','DIAG4','DIAG5','DIAG6','DIAG7','DIAG8','DIAG9','DIAG10'))
adm2002<-read_fst("/nfs/home/J/jok8845/shared_space/ci3_health_data/medicare/gen_admission/1999_2016/targeted_conditions/cache_data/admissions_by_year/admissions_2002.fst",columns = c("QID","ADATE","DDATE",'DIAG1','DIAG2','DIAG3','DIAG4','DIAG5','DIAG6','DIAG7','DIAG8','DIAG9','DIAG10'))
adm2003<-read_fst("/nfs/home/J/jok8845/shared_space/ci3_health_data/medicare/gen_admission/1999_2016/targeted_conditions/cache_data/admissions_by_year/admissions_2003.fst",columns = c("QID","ADATE","DDATE",'DIAG1','DIAG2','DIAG3','DIAG4','DIAG5','DIAG6','DIAG7','DIAG8','DIAG9','DIAG10'))
adm2004<-read_fst("/nfs/home/J/jok8845/shared_space/ci3_health_data/medicare/gen_admission/1999_2016/targeted_conditions/cache_data/admissions_by_year/admissions_2004.fst",columns = c("QID","ADATE","DDATE",'DIAG1','DIAG2','DIAG3','DIAG4','DIAG5','DIAG6','DIAG7','DIAG8','DIAG9','DIAG10'))
adm2005<-read_fst("/nfs/home/J/jok8845/shared_space/ci3_health_data/medicare/gen_admission/1999_2016/targeted_conditions/cache_data/admissions_by_year/admissions_2005.fst",columns = c("QID","ADATE","DDATE",'DIAG1','DIAG2','DIAG3','DIAG4','DIAG5','DIAG6','DIAG7','DIAG8','DIAG9','DIAG10'))
adm2006<-read_fst("/nfs/home/J/jok8845/shared_space/ci3_health_data/medicare/gen_admission/1999_2016/targeted_conditions/cache_data/admissions_by_year/admissions_2006.fst",columns = c("QID","ADATE","DDATE",'DIAG1','DIAG2','DIAG3','DIAG4','DIAG5','DIAG6','DIAG7','DIAG8','DIAG9','DIAG10'))
adm2007<-read_fst("/nfs/home/J/jok8845/shared_space/ci3_health_data/medicare/gen_admission/1999_2016/targeted_conditions/cache_data/admissions_by_year/admissions_2007.fst",columns = c("QID","ADATE","DDATE",'DIAG1','DIAG2','DIAG3','DIAG4','DIAG5','DIAG6','DIAG7','DIAG8','DIAG9','DIAG10'))
adm2008<-read_fst("/nfs/home/J/jok8845/shared_space/ci3_health_data/medicare/gen_admission/1999_2016/targeted_conditions/cache_data/admissions_by_year/admissions_2008.fst",columns = c("QID","ADATE","DDATE",'DIAG1','DIAG2','DIAG3','DIAG4','DIAG5','DIAG6','DIAG7','DIAG8','DIAG9','DIAG10'))
adm2009<-read_fst("/nfs/home/J/jok8845/shared_space/ci3_health_data/medicare/gen_admission/1999_2016/targeted_conditions/cache_data/admissions_by_year/admissions_2009.fst",columns = c("QID","ADATE","DDATE",'DIAG1','DIAG2','DIAG3','DIAG4','DIAG5','DIAG6','DIAG7','DIAG8','DIAG9','DIAG10'))
adm2010<-read_fst("/nfs/home/J/jok8845/shared_space/ci3_health_data/medicare/gen_admission/1999_2016/targeted_conditions/cache_data/admissions_by_year/admissions_2010.fst",columns = c("QID","ADATE","DDATE",'DIAG1','DIAG2','DIAG3','DIAG4','DIAG5','DIAG6','DIAG7','DIAG8','DIAG9','DIAG10'))
adm2011<-read_fst("/nfs/home/J/jok8845/shared_space/ci3_health_data/medicare/gen_admission/1999_2016/targeted_conditions/cache_data/admissions_by_year/admissions_2011.fst",columns = c("QID","ADATE","DDATE",'DIAG1','DIAG2','DIAG3','DIAG4','DIAG5','DIAG6','DIAG7','DIAG8','DIAG9','DIAG10'))
adm2012<-read_fst("/nfs/home/J/jok8845/shared_space/ci3_health_data/medicare/gen_admission/1999_2016/targeted_conditions/cache_data/admissions_by_year/admissions_2012.fst",columns = c("QID","ADATE","DDATE",'DIAG1','DIAG2','DIAG3','DIAG4','DIAG5','DIAG6','DIAG7','DIAG8','DIAG9','DIAG10'))
adm2013<-read_fst("/nfs/home/J/jok8845/shared_space/ci3_health_data/medicare/gen_admission/1999_2016/targeted_conditions/cache_data/admissions_by_year/admissions_2013.fst",columns = c("QID","ADATE","DDATE",'DIAG1','DIAG2','DIAG3','DIAG4','DIAG5','DIAG6','DIAG7','DIAG8','DIAG9','DIAG10'))
adm2014<-read_fst("/nfs/home/J/jok8845/shared_space/ci3_health_data/medicare/gen_admission/1999_2016/targeted_conditions/cache_data/admissions_by_year/admissions_2014.fst",columns = c("QID","ADATE","DDATE",'DIAG1','DIAG2','DIAG3','DIAG4','DIAG5','DIAG6','DIAG7','DIAG8','DIAG9','DIAG10'))
adm2015<-read_fst("/nfs/home/J/jok8845/shared_space/ci3_health_data/medicare/gen_admission/1999_2016/targeted_conditions/cache_data/admissions_by_year/admissions_2015.fst",columns = c("QID","ADATE","DDATE",'DIAG1','DIAG2','DIAG3','DIAG4','DIAG5','DIAG6','DIAG7','DIAG8','DIAG9','DIAG10'))
adm2016<-read_fst("/nfs/home/J/jok8845/shared_space/ci3_health_data/medicare/gen_admission/1999_2016/targeted_conditions/cache_data/admissions_by_year/admissions_2016.fst",columns = c("QID","ADATE","DDATE",'DIAG1','DIAG2','DIAG3','DIAG4','DIAG5','DIAG6','DIAG7','DIAG8','DIAG9','DIAG10'))

admissions<-rbind(adm2000,adm2001,adm2002,adm2003,adm2004,adm2005,adm2006,adm2007,adm2008,adm2009,adm2010,adm2011,adm2012,adm2013,adm2014,adm2015,adm2016)
rm(adm2000,adm2001,adm2002,adm2003,adm2004,adm2005,adm2006,adm2007,adm2008,adm2009,adm2010,adm2011,adm2012,adm2013,adm2014,adm2015,adm2016)
gc()
admissions<-as.data.table(admissions)
admissions[, ADATE := dmy(ADATE)]
admissions[, DDATE := dmy(DDATE)]
admissions[, year := year(ADATE)] #create year row
admissions <- admissions[year %in% 2000:2016] #only keep admissions with admission date in year (2000-2016)

## Process codes to get one adrd indicator
admissions[DDATE < "2015-10-01", adrd := DIAG1 %in% adrd_icd9 | 
             DIAG2 %in% adrd_icd9 |DIAG3 %in% adrd_icd9 |DIAG4 %in% adrd_icd9 |DIAG5 %in% adrd_icd9 |DIAG6 %in% adrd_icd9 |
             DIAG7 %in% adrd_icd9 |DIAG8 %in% adrd_icd9 |DIAG9 %in% adrd_icd9 |DIAG10 %in% adrd_icd9]

admissions[DDATE >= "2015-10-01", adrd := DIAG1 %in% adrd_icd10 | 
             DIAG2 %in% adrd_icd10 |DIAG3 %in% adrd_icd10 |DIAG4 %in% adrd_icd10 |DIAG5 %in% adrd_icd10 |DIAG6 %in% adrd_icd10 |
             DIAG7 %in% adrd_icd10 |DIAG8 %in% adrd_icd10 |DIAG9 %in% adrd_icd10 |DIAG10 %in% adrd_icd10]

##keep only adrd admissions 
admissions <- admissions[adrd %in% TRUE]
admissions<-admissions[,c("QID","ADATE","DDATE","year","adrd")]
gc()

#admission first and second diagnoses
sum(admissions$adrd)


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

length(unique(admissions$QID))
write_fst(admissions, "/nfs/home/J/jok8845/shared_space/ci3_health_data/medicare/gen_admission/1999_2016/Klompmaker/admission_data/all_adrd2_20002016.fst")
