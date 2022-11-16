library(NSAPHutils)
#library(NSAPHplatform)
set_threads()
library(fst)
library(data.table)
library(lubridate)
library(icd)
library(dplyr)

admissions<-read_fst("/nfs/home/J/jok8845/shared_space/ci3_health_data/medicare/gen_admission/1999_2016/Klompmaker/admission_data/all_par_20002016.fst")
#2892741
##############################################################################################
#Remove duplicate admissions records##########################################################
##############################################################################################

admissions<-admissions %>% distinct()
adm_duplic<-admissions %>% group_by(QID,ADATE) %>% summarise (N=n())
adm_duplic<-adm_duplic[adm_duplic$N>1,]
adm_duplic$N<-NULL
#get duplicates 
adm2<-inner_join(admissions,adm_duplic)
#get unique records
admissions<-anti_join(admissions,adm2) #2892741-2887802=4939
rm(adm_duplic)

## drop duplicates with less information
setDT(adm2)[,nmissing := apply(.SD, 1, function(x) sum(x == "" | is.na(x))), by = c("QID")]
ndups <- nrow(adm2)
adm2[, keep := nmissing == min(nmissing),
     by = c("QID")]
adm2 <- adm2[keep == TRUE]
ndropped_missing <- ndups - nrow(adm2)
print(paste(ndropped_missing, "duplicates with missing values dropped")) #0 dropped

## drop duplicates with shorter length of stay
adm2$length<-adm2$DDATE-adm2$ADATE
ndups <- nrow(adm2)
adm2[, keep := length == max(length),
     by = c("QID")]
adm2 <- adm2[keep == TRUE]
adm2[, length := NULL]
ndropped_missing <- ndups - nrow(adm2)
print(paste(ndropped_missing, "duplicates with missing values dropped")) #2331 dropepd

## select other duplicates at random
ndups <- nrow(adm2)
adm2[, rand := sample(1:.N), by = c("year", "QID")]
adm2[, keep := rand == max(rand), by = c("year", "QID")]
adm2 <- adm2[keep == TRUE]
adm2[, nmissing := NULL]
adm2[, keep := NULL]
adm2[, rand := NULL]
ndropped_random <- ndups - nrow(adm2)
print(paste(ndropped_random, "duplicates dropped at random")) #0 dropped

##3.Combine with previous data
hosp_add<-rbind(admissions,adm2)

#get first hospitalization 
par<-hosp_add[order(ADATE), .(par_date = ADATE[1]), by = QID]
par$par<-c(1)
par[, year := year(par_date)] #1196981

write_fst(par, "/nfs/home/J/jok8845/shared_space/ci3_health_data/medicare/gen_admission/1999_2016/Klompmaker/admission_data/first_par_20002016.fst")
