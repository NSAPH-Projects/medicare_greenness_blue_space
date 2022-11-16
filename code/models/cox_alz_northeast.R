
library(data.table)
library(fst)
library(survival)
#library(NSAPHutils)
#library(dplyr)

old_merged <- "/nfs/home/J/jok8845/shared_space/ci3_health_data/medicare/gen_admission/1999_2016/Klompmaker/cache_data/hosp_adm/alz/correct_followup/"
new_merged <- "/nfs/home/J/jok8845/shared_space/ci3_health_data/medicare/gen_admission/1999_2016/Klompmaker/merged_data/alz2/"

merged_files <- list.files(
  old_merged,
  pattern = "confounder_exposure_merged_nodups_health_[0-9]+\\.fst",
  full.names = TRUE
)

ALZ <- rbindlist(
  lapply(merged_files,
         read_fst,
         columns = c("zip","age","year.medicare","qid","statecode",
                     "race","sex","dual","entry_age_break.y",
                     "followup_year","followup_year_plus_one","hosp"),
         as.data.table = TRUE))

ALZ <-ALZ[statecode=="ME" | statecode=="VT" | statecode=="NH" | statecode=="MA" | statecode=="NY" | statecode=="RI" | statecode=="CT" | statecode== "NJ" | statecode== "PA",]
print("number of unique QIDs")
uniqueN(ALZ$qid)

print("loaded denom files")
setnames(ALZ, "year.medicare", "year")

ALZ[, race3 := integer()][race==2, race3:= 2
                          ][race==3, race3:= 3][race==1, race3:= 1
                                                ][race==5, race3:= 3
                                                  ][race==6, race3:= 3
                                                    ][race==0, race3:= 3][race==4, race3:= 3][]

#get # hospitalizations
sum(ALZ$hosp)

#to data.frame
ALZ<-data.frame(ALZ)

#read zip code covariates
covar<-read_fst("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/data/confounders/merged_covariates.fst")
print("loaded covariates")

#merge data
ALZ<-merge(ALZ,covar, by=c("zip","year"),all.x=T)
print("merged ALZ covariates")
nrow(ALZ)

#cox PH
cox_raw<-coxph(Surv(followup_year,followup_year_plus_one,hosp)~
             park+ndvi_summer+occur_bs_1000m+as.factor(year)+
             medhouseholdincome+medianhousevalue+poverty+education+pct_owner_occ+hispanic+pct_blk+
             popdensity+smoke_rate+
             strata(as.factor(entry_age_break.y),as.factor(sex),as.factor(race3),as.factor(dual)),
           data=ALZ,ties=c("efron"),na.action=na.omit)

cox<-summary(cox_raw)
save(cox, file="/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/cox_alz_northeast.RData")
