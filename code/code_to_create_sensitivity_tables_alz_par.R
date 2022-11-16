library(stringi)
library(stringr)
library(ggplot2)
library(readxl)
library("writexl")
library(dplyr)
library(data.table)

#read ALZ
park.alz <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/m4_park_only_alz.xlsx")
ndvi.alz <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/m4_ndvi_only_alz.xlsx")
blue.alz <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/m4_blue_only_alz.xlsx")
ter.alz <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/m4_tertiary_blue_alz.xlsx")
no2.alz <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/m4_pm25_no2_alz.xlsx")
meteo.alz <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/m4_temp_humid_precip_alz.xlsx")
noregion.alz <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/m4_no_region_alz.xlsx")
division.alz <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/m4_division_alz.xlsx")
#ipw.alz <- read_xlsx("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/ipw_num1_nature_alz.xlsx")
excl1yr.alz <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/excl_1yr_alz.xlsx")

#read urban ALZ
park.alz.urb <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/m4_park_only_alz_urb.xlsx")
ndvi.alz.urb <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/m4_ndvi_only_alz_urb.xlsx")
blue.alz.urb <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/m4_blue_only_alz_urb.xlsx")
ter.alz.urb <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/m4_tertiary_blue_alz_urb.xlsx")
no2.alz.urb <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/m4_pm25_no2_alz_urb.xlsx")
meteo.alz.urb <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/m4_temp_humid_precip_alz_urb.xlsx")
noregion.alz.urb <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/m4_no_region_alz_urb.xlsx")
division.alz.urb <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/m4_division_alz_urb.xlsx")
#ipw.alz.urb <- read_xlsx("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/ipw_num1_nature_alz_urb.xlsx")
excl1yr.alz.urb <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/excl_1yr_alz_urb.xlsx")

#read PAR
park.par <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/m4_park_only_par.xlsx")
ndvi.par <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/m4_ndvi_only_par.xlsx")
blue.par <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/m4_blue_only_par.xlsx")
ter.par <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/m4_tertiary_blue_par.xlsx")
no2.par <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/m4_pm25_no2_par.xlsx")
meteo.par <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/m4_temp_humid_precip_par.xlsx")
noregion.par <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/m4_no_region_par.xlsx")
division.par <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/m4_division_par.xlsx")
#ipw.par <- read_xlsx("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/ipw_num1_nature_par.xlsx")
excl1yr.par <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/excl_1yr_par.xlsx")

#read urban PAR
park.par.urb <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/m4_park_only_par_urb.xlsx")
ndvi.par.urb <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/m4_ndvi_only_par_urb.xlsx")
blue.par.urb <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/m4_blue_only_par_urb.xlsx")
ter.par.urb <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/m4_tertiary_blue_par_urb.xlsx")
no2.par.urb <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/m4_pm25_no2_par_urb.xlsx")
meteo.par.urb <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/m4_temp_humid_precip_par_urb.xlsx")
noregion.par.urb <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/m4_no_region_par_urb.xlsx")
division.par.urb <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/m4_division_par_urb.xlsx")
#ipw.par.urb <- read_xlsx("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/ipw_num1_nature_par_urb.xlsx")
excl1yr.par.urb <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/excl_1yr_par_urb.xlsx")

#bind full population
models<-rbind(park.alz,ndvi.alz,blue.alz,ter.alz,no2.alz,meteo.alz,noregion.alz,division.alz,excl1yr.alz,
              park.par,ndvi.par,blue.par,ter.par,no2.par,meteo.par,noregion.par,division.par,excl1yr.par)
models$X<-NULL
#models<-rbind(models,ipw.alz,ipw.par)
models$pop<-c("full")

#bind urban population
models_urb<-rbind(park.alz.urb,ndvi.alz.urb,blue.alz.urb,ter.alz.urb,no2.alz.urb,meteo.alz.urb,noregion.alz.urb,division.alz.urb,excl1yr.alz.urb,
                  park.par.urb,ndvi.par.urb,blue.par.urb,ter.par.urb,no2.par.urb,meteo.par.urb,noregion.par.urb,division.par.urb,excl1yr.par.urb)
models_urb$X<-NULL
#models_urb<-rbind(models_urb,ipw.alz.urb,ipw.par.urb)
models_urb$pop<-c("urban")

models<-rbind(models,models_urb)

rm(list=setdiff(ls(), c("models")))

#read se ALZ
park_se_alz <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_only_park_alz.xlsx")
ndvi_se_alz <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_only_ndvi_alz.xlsx")
blue_se_alz <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_only_blue_alz.xlsx")
ter_se_alz <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_tertiary_blue_alz.xlsx")
no2_se_alz <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_pm25_no2_alz.xlsx")
meteo_se_alz <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_temp_humid_precip_alz.xlsx")
noregion_se_alz <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_no_region_alz.xlsx")
division_se_alz <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_division_alz.xlsx")
#ipw_se_alz <- read_xlsx("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_ipw_num1_nature_alz.xlsx")
excl1yr_se_alz <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_excl_1yr_alz.xlsx")

#read urban se ALZ
park_se_alz.urb <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_only_park_alz_urb.xlsx")
ndvi_se_alz.urb <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_only_ndvi_alz_urb.xlsx")
blue_se_alz.urb <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_only_blue_alz_urb.xlsx")
ter_se_alz.urb <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_tertiary_blue_alz_urb.xlsx")
no2_se_alz.urb <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_pm25_no2_alz_urb.xlsx")
meteo_se_alz.urb <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_temp_humid_precip_alz_urb.xlsx")
noregion_se_alz.urb <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_no_region_alz_urb.xlsx")
division_se_alz.urb <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_division_alz_urb.xlsx")
#ipw_se_alz.urb <- read_xlsx("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_ipw_num1_nature_alz_urb.xlsx")
excl1yr_se_alz.urb <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_excl_1yr_alz_urb.xlsx")

#read se PAR
park_se_par <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_only_park_par.xlsx")
ndvi_se_par <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_only_ndvi_par.xlsx")
blue_se_par <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_only_blue_par.xlsx")
ter_se_par <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_tertiary_blue_par.xlsx")
no2_se_par <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_pm25_no2_par.xlsx")
meteo_se_par <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_temp_humid_precip_par.xlsx")
noregion_se_par <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_no_region_par.xlsx")
division_se_par <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_division_par.xlsx")
#ipw_se_par <- read_xlsx("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_ipw_num1_nature_par.xlsx")
excl1yr_se_par <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_excl_1yr_par.xlsx")

#read urban se PAR
park_se_par.urb <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_only_park_par_urb.xlsx")
ndvi_se_par.urb <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_only_ndvi_par_urb.xlsx")
blue_se_par.urb <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_only_blue_par_urb.xlsx")
ter_se_par.urb <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_tertiary_blue_par_urb.xlsx")
no2_se_par.urb <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_pm25_no2_par_urb.xlsx")
meteo_se_par.urb <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_temp_humid_precip_par_urb.xlsx")
noregion_se_par.urb <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_no_region_par_urb.xlsx")
division_se_par.urb <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_division_par_urb.xlsx")
#ipw_se_par.urb <- read_xlsx("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_ipw_num1_nature_par_urb.xlsx")
excl1yr_se_par.urb <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_excl_1yr_par_urb.xlsx")

#bind full population
se<-rbind(park_se_alz,ndvi_se_alz,blue_se_alz,ter_se_alz,no2_se_alz,meteo_se_alz,noregion_se_alz,division_se_alz,excl1yr_se_alz,
          park_se_par,ndvi_se_par,blue_se_par,ter_se_par,no2_se_par,meteo_se_par,noregion_se_par,division_se_par,excl1yr_se_par)
se$X<-NULL
#se<-rbind(se,ipw_se_alz,ipw_se_par)
se$pop<-c("full")

#bind full population
se_urb<-rbind(park_se_alz.urb,ndvi_se_alz.urb,blue_se_alz.urb,ter_se_alz.urb,no2_se_alz.urb,meteo_se_alz.urb,noregion_se_alz.urb,division_se_alz.urb,excl1yr_se_alz.urb,
              park_se_par.urb,ndvi_se_par.urb,blue_se_par.urb,ter_se_par.urb,no2_se_par.urb,meteo_se_par.urb,noregion_se_par.urb,division_se_par.urb,excl1yr_se_par.urb)
se_urb$X<-NULL
#se_urb<-rbind(se_urb,ipw_se_alz.urb,ipw_se_par.urb)
se_urb$pop<-c("urban")

se<-rbind(se,se_urb)

rm(list=setdiff(ls(), c("models", "se")))

#join models and iqr
models<-left_join(models,se,by=c("model","out","exposure","pop"))

#import main models
m4_ndvi_blue_alz <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/m4_alz.xlsx")
m4_ndvi_blue_urb_alz <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/m4_alz_urb.xlsx")
m4_ndvi_blue_par <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/m4_par.xlsx")
m4_ndvi_blue_urb_par <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/m4_par_urb.xlsx")
m4_ndvi_blue_alz$pop<-c("full")
m4_ndvi_blue_par$pop<-c("full")
m4_ndvi_blue_urb_alz$pop<-c("urban")
m4_ndvi_blue_urb_par$pop<-c("urban")
m4_ndvi_blue_alz$AIC<-NULL
m4_ndvi_blue_alz$BIC<-NULL
m4_ndvi_blue_par$AIC<-NULL
m4_ndvi_blue_par$BIC<-NULL
main<-rbind(m4_ndvi_blue_alz,m4_ndvi_blue_par,m4_ndvi_blue_urb_alz,m4_ndvi_blue_urb_par)

m4_se_alz <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_m4_alz.xlsx")
m4_se_par <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_m4_par.xlsx")
m4_se_alz_urb <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_m4_alz_urb.xlsx")
m4_se_par_urb <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_m4_par_urb.xlsx")
m4_se_alz$pop<-c("full")
m4_se_par$pop<-c("full")
m4_se_alz_urb$pop<-c("urban")
m4_se_par_urb$pop<-c("urban")
main.se<-rbind(m4_se_alz,m4_se_par,m4_se_alz_urb,m4_se_par_urb)

#merge main with main.se
main<-left_join(main,main.se,by=c("model","out","exposure","pop"))
main$strata<-c("main")

main<-main[,c("Beta","model","out","exposure","pop","se")]
#merge main with strata
models<-rbind(main,models)

#import iqr
descr_exposures_strata_alz <- read_excel("shared_space/ci3_analysis/nature_medicare/Modeloutput/descriptives/descr_exposures_strata_alz.xlsx")
iqr_exp<-descr_exposures_strata_alz[,c("pol","iqr")]
iqr_exp<-iqr_exp[iqr_exp$pol=="ndvi_summer"|iqr_exp$pol=="park",]
setnames(iqr_exp,"pol","exposure")
blue<-cbind("as.factor(occur_bs_1000m_bin)1","1")
colnames(blue)<-c("exposure","iqr")
iqr_exp<-rbind(iqr_exp,blue)

#join models and iqr
models<-left_join(models,iqr_exp,by="exposure")
models$iqr<-as.numeric(models$iqr)
models$iqr<-ifelse(is.na(models$iqr),1,models$iqr)

#calculate effect estimates per IQR increase
models$Lower<-models$Beta-qnorm(1-0.05/2)*models$se
models$Upper<-models$Beta+qnorm(1-0.05/2)*models$se
models$beta_exp<-exp(models$iqr*models$Beta)
models$Lower_exp<-exp(models$iqr*models$Lower)
models$Upper_exp<-exp(models$iqr*models$Upper)

#concatenate columns
models$beta_ci<-paste0(round(models$beta_exp,2)," (",round(models$Lower_exp,2),", ",round(models$Upper_exp,2),")")

write.csv(models, file="/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/tables/HR_sensitivity_models_alz_par.csv")

