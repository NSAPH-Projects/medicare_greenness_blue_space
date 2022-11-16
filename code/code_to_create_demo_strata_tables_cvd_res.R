library(stringi)
library(stringr)
library(ggplot2)
library(readxl)
library("writexl")
library(dplyr)
library(data.table)

#read CVD
sex1.cvd <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/sex1_cvd.xlsx")
sex2.cvd <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/sex2_cvd.xlsx")
age65.cvd <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/age65_cvd.xlsx")
age75.cvd <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/age75_cvd.xlsx")
age85.cvd <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/age85_cvd.xlsx")
dual0.cvd <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/dual0_cvd.xlsx")
dual1.cvd <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/dual1_cvd.xlsx")
race1.cvd <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/race1_cvd.xlsx")
race2.cvd <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/race2_cvd.xlsx")
race3.cvd <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/race3_cvd.xlsx")
west.cvd <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/west_cvd.xlsx")
south.cvd <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/south_cvd.xlsx")
northeast.cvd <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/northeast_cvd.xlsx")
midwest.cvd <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/midwest_cvd.xlsx")

#read urban CVD
sex1.cvd.urb <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/sex1_cvd_urb.xlsx")
sex2.cvd.urb <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/sex2_cvd_urb.xlsx")
age65.cvd.urb <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/age65_cvd_urb.xlsx")
age75.cvd.urb <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/age75_cvd_urb.xlsx")
age85.cvd.urb <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/age85_cvd_urb.xlsx")
dual0.cvd.urb <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/dual0_cvd_urb.xlsx")
dual1.cvd.urb <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/dual1_cvd_urb.xlsx")
race1.cvd.urb <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/race1_cvd_urb.xlsx")
race2.cvd.urb <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/race2_cvd_urb.xlsx")
race3.cvd.urb <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/race3_cvd_urb.xlsx")
west.cvd.urb <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/west_cvd_urb.xlsx")
south.cvd.urb <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/south_cvd_urb.xlsx")
northeast.cvd.urb <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/northeast_cvd_urb.xlsx")
midwest.cvd.urb <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/midwest_cvd_urb.xlsx")

#read RES
sex1.res <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/sex1_res.xlsx")
sex2.res <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/sex2_res.xlsx")
age65.res <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/age65_res.xlsx")
age75.res <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/age75_res.xlsx")
age85.res <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/age85_res.xlsx")
dual0.res <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/dual0_res.xlsx")
dual1.res <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/dual1_res.xlsx")
race1.res <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/race1_res.xlsx")
race2.res <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/race2_res.xlsx")
race3.res <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/race3_res.xlsx")
west.res <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/west_res.xlsx")
south.res <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/south_res.xlsx")
northeast.res <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/northeast_res.xlsx")
midwest.res <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/midwest_res.xlsx")

#read urban RES
sex1.res.urb <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/sex1_res_urb.xlsx")
sex2.res.urb <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/sex2_res_urb.xlsx")
age65.res.urb <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/age65_res_urb.xlsx")
age75.res.urb <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/age75_res_urb.xlsx")
age85.res.urb <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/age85_res_urb.xlsx")
dual0.res.urb <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/dual0_res_urb.xlsx")
dual1.res.urb <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/dual1_res_urb.xlsx")
race1.res.urb <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/race1_res_urb.xlsx")
race2.res.urb <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/race2_res_urb.xlsx")
race3.res.urb <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/race3_res_urb.xlsx")
west.res.urb <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/west_res_urb.xlsx")
south.res.urb <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/south_res_urb.xlsx")
northeast.res.urb <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/northeast_res_urb.xlsx")
midwest.res.urb <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/midwest_res_urb.xlsx")

#bind full population
models<-rbind(sex1.cvd,sex2.cvd,age65.cvd,age75.cvd,age85.cvd,dual0.cvd,dual1.cvd,
              race1.cvd,race2.cvd,race3.cvd,
              sex1.res,sex2.res,age65.res,age75.res,age85.res,dual0.res,dual1.res,
              race1.res,race2.res,race3.res)
region<-rbind(west.cvd,south.cvd,northeast.cvd,midwest.cvd,
              west.res,south.res,northeast.res,midwest.res)
setnames(region,"region","strata")
models<-rbind(models,region)
models$pop<-c("full")

#bind urban population
models_urb<-rbind(sex1.cvd.urb,sex2.cvd.urb,age65.cvd.urb,age75.cvd.urb,age85.cvd.urb,dual0.cvd.urb,dual1.cvd.urb,
                  race1.cvd.urb,race2.cvd.urb,race3.cvd.urb,
                  sex1.res.urb,sex2.res.urb,age65.res.urb,age75.res.urb,age85.res.urb,dual0.res.urb,dual1.res.urb,
                  race1.res.urb,race2.res.urb,race3.res.urb)
region_urb<-rbind(west.cvd.urb,south.cvd.urb,northeast.cvd.urb,midwest.cvd.urb,
              west.res.urb,south.res.urb,northeast.res.urb,midwest.res.urb)
setnames(region_urb,"region","strata")
models_urb<-rbind(models_urb,region_urb)
models_urb$pop<-c("urban")

models<-rbind(models,models_urb)

rm(list=setdiff(ls(), c("models")))

#read se CVD
sex1_se_cvd <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_sex1_cvd.xlsx")
sex2_se_cvd <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_sex2_cvd.xlsx")
age65_se_cvd <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_age65_cvd.xlsx")
age75_se_cvd <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_age75_cvd.xlsx")
age85_se_cvd <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_age85_cvd.xlsx")
dual0_se_cvd <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_dual0_cvd.xlsx")
dual1_se_cvd <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_dual1_cvd.xlsx")
race1_se_cvd <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_race1_cvd.xlsx")
race2_se_cvd <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_race2_cvd.xlsx")
race3_se_cvd <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_race3_cvd.xlsx")
west_se_cvd <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_west_cvd.xlsx")
south_se_cvd <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_south_cvd.xlsx")
northeast_se_cvd <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_northeast_cvd.xlsx")
midwest_se_cvd <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_midwest_cvd.xlsx")

#read urban se CVD
sex1_se_cvd.urb <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_sex1_cvd_urb.xlsx")
sex2_se_cvd.urb <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_sex2_cvd_urb.xlsx")
age65_se_cvd.urb <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_age65_cvd_urb.xlsx")
age75_se_cvd.urb <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_age75_cvd_urb.xlsx")
age85_se_cvd.urb <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_age85_cvd_urb.xlsx")
dual0_se_cvd.urb <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_dual0_cvd_urb.xlsx")
dual1_se_cvd.urb <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_dual1_cvd_urb.xlsx")
race1_se_cvd.urb <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_race1_cvd_urb.xlsx")
race2_se_cvd.urb <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_race2_cvd_urb.xlsx")
race3_se_cvd.urb <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_race3_cvd_urb.xlsx")
west_se_cvd.urb <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_west_cvd_urb.xlsx")
south_se_cvd.urb <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_south_cvd_urb.xlsx")
northeast_se_cvd.urb <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_northeast_cvd_urb.xlsx")
midwest_se_cvd.urb <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_midwest_cvd_urb.xlsx")

#read se RES
sex1_se_res <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_sex1_res.xlsx")
sex2_se_res <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_sex2_res.xlsx")
age65_se_res <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_age65_res.xlsx")
age75_se_res <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_age75_res.xlsx")
age85_se_res <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_age85_res.xlsx")
dual0_se_res <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_dual0_res.xlsx")
dual1_se_res <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_dual1_res.xlsx")
race1_se_res <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_race1_res.xlsx")
race2_se_res <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_race2_res.xlsx")
race3_se_res <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_race3_res.xlsx")
west_se_res <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_west_res.xlsx")
south_se_res <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_south_res.xlsx")
northeast_se_res <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_northeast_res.xlsx")
midwest_se_res <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_midwest_res.xlsx")

#read se RES
sex1_se_res.urb <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_sex1_res_urb.xlsx")
sex2_se_res.urb <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_sex2_res_urb.xlsx")
age65_se_res.urb <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_age65_res_urb.xlsx")
age75_se_res.urb <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_age75_res_urb.xlsx")
age85_se_res.urb <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_age85_res_urb.xlsx")
dual0_se_res.urb <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_dual0_res_urb.xlsx")
dual1_se_res.urb <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_dual1_res_urb.xlsx")
race1_se_res.urb <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_race1_res_urb.xlsx")
race2_se_res.urb <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_race2_res_urb.xlsx")
race3_se_res.urb <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_race3_res_urb.xlsx")
west_se_res.urb <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_west_res_urb.xlsx")
south_se_res.urb <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_south_res_urb.xlsx")
northeast_se_res.urb <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_northeast_res_urb.xlsx")
midwest_se_res.urb <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_midwest_res_urb.xlsx")

#bind full population
se<-rbind(sex1_se_cvd,sex2_se_cvd,age65_se_cvd,age75_se_cvd,age85_se_cvd,dual0_se_cvd,dual1_se_cvd,race1_se_cvd,race2_se_cvd,race3_se_cvd,
          sex1_se_res,sex2_se_res,age65_se_res,age75_se_res,age85_se_res,dual0_se_res,dual1_se_res,race1_se_res,race2_se_res,race3_se_res)
se.region<-rbind(west_se_cvd,south_se_cvd,northeast_se_cvd,midwest_se_cvd,
              west_se_res,south_se_res,northeast_se_res,midwest_se_res)
setnames(se.region,"region","strata")
se<-rbind(se,se.region)
se$pop<-c("full")

#bind full population
se_urb<-rbind(sex1_se_cvd.urb,sex2_se_cvd.urb,age65_se_cvd.urb,age75_se_cvd.urb,age85_se_cvd.urb,dual0_se_cvd.urb,dual1_se_cvd.urb,race1_se_cvd.urb,race2_se_cvd.urb,race3_se_cvd.urb,
          sex1_se_res.urb,sex2_se_res.urb,age65_se_res.urb,age75_se_res.urb,age85_se_res.urb,dual0_se_res.urb,dual1_se_res.urb,race1_se_res.urb,race2_se_res.urb,race3_se_res)
se.region_urb<-rbind(west_se_cvd.urb,south_se_cvd.urb,northeast_se_cvd.urb,midwest_se_cvd.urb,
                 west_se_res.urb,south_se_res.urb,northeast_se_res.urb,midwest_se_res)
setnames(se.region_urb,"region","strata")
se_urb<-rbind(se_urb,se.region_urb)
se_urb$pop<-c("urban")

se<-rbind(se,se_urb)

rm(list=setdiff(ls(), c("models", "se")))

models$X<-NULL
se$X<-NULL
models$strata<-tolower(models$strata)
#join models and iqr
models<-left_join(models,se,by=c("model","out","exposure","strata","pop"))

#import main models
m5_ndvi_blue_cvd <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/m5_cvd.xlsx")
m5_ndvi_blue_urb_cvd <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/m5_cvd_urb.xlsx")
m5_ndvi_blue_res <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/m5_res.xlsx")
m5_ndvi_blue_urb_res <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/m5_res_urb.xlsx")
m5_ndvi_blue_cvd$pop<-c("full")
m5_ndvi_blue_res$pop<-c("full")
m5_ndvi_blue_urb_cvd$pop<-c("urban")
m5_ndvi_blue_urb_res$pop<-c("urban")
main<-rbind(m5_ndvi_blue_cvd,m5_ndvi_blue_res,m5_ndvi_blue_urb_cvd,m5_ndvi_blue_urb_res)

m5_se_cvd <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_m5_cvd.xlsx")
m5_se_res <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_m5_res.xlsx")
m5_se_cvd_urb <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_m5_cvd_urb.xlsx")
m5_se_res_urb <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_m5_res_urb.xlsx")
m5_se_cvd$pop<-c("full")
m5_se_res$pop<-c("full")
m5_se_cvd_urb$pop<-c("urban")
m5_se_res_urb$pop<-c("urban")
main.se<-rbind(m5_se_cvd,m5_se_res,m5_se_cvd_urb,m5_se_res_urb)

#merge main with main.se
main<-left_join(main,main.se,by=c("model","out","exposure","pop"))
main$strata<-c("main")

main<-main[,c("Beta","model","out","strata","exposure","pop","se")]
#merge main with strata
models<-rbind(main,models)

#import iqr
descr_exposures_strata_cvd <- read_excel("shared_space/ci3_analysis/nature_medicare/Modeloutput/descriptives/descr_exposures_strata_cvd.xlsx")
iqr_exp<-descr_exposures_strata_cvd[,c("pol","iqr")]
iqr_exp<-iqr_exp[iqr_exp$pol=="ndvi_summer"|iqr_exp$pol=="occur_bs_1000m"|iqr_exp$pol=="park",]
setnames(iqr_exp,"pol","exposure")

#join models and iqr
models<-left_join(models,iqr_exp,by="exposure")

#calculate effect estimates per IQR increase
models$Lower<-models$Beta-qnorm(1-0.05/2)*models$se
models$Upper<-models$Beta+qnorm(1-0.05/2)*models$se
models$beta_exp<-exp(models$iqr*models$Beta)
models$Lower_exp<-exp(models$iqr*models$Lower)
models$Upper_exp<-exp(models$iqr*models$Upper)

#concatenate columns
models$beta_ci<-paste0(round(models$beta_exp,2)," (",round(models$Lower_exp,2),", ",round(models$Upper_exp,2),")")

write.csv(models, file="/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/tables/HR_demo_strata_region_models_cvd_res.csv")

park<-subset(models,models$exposure=="park")
ndvi<-subset(models,models$exposure=="ndvi_summer")
blue<-subset(models,models$exposure=="occur_bs_1000m")

cvd.park.full<-subset(park,park$out=="cvd"&park$pop=="full")
cvd.park.urban<-subset(park,park$out=="cvd"&park$pop=="urban")
cvd.ndvi.full<-subset(ndvi,ndvi$out=="cvd"&park$pop=="full")
cvd.ndvi.urban<-subset(ndvi,ndvi$out=="cvd"&park$pop=="urban")
cvd.blue.full<-subset(blue,blue$out=="cvd"&park$pop=="full")
cvd.blue.urban<-subset(blue,blue$out=="cvd"&park$pop=="urban")

res.park.full<-subset(park,park$out=="res"&park$pop=="full")
res.park.urban<-subset(park,park$out=="res"&park$pop=="urban")
res.ndvi.full<-subset(ndvi,ndvi$out=="res"&park$pop=="full")
res.ndvi.urban<-subset(ndvi,ndvi$out=="res"&park$pop=="urban")
res.blue.full<-subset(blue,blue$out=="res"&park$pop=="full")
res.blue.urban<-subset(blue,blue$out=="res"&park$pop=="urban")

#add nmmrs to plot
cvd.park.full$nr<-c(1,3:4,6:8,10:11,13:15,17:20)
cvd.park.urban$nr<-c(1,3:4,6:8,10:11,13:15,17:20)
cvd.ndvi.full$nr<-c(1,3:4,6:8,10:11,13:15,17:20)
cvd.ndvi.urban$nr<-c(1,3:4,6:8,10:11,13:15,17:20)
cvd.blue.full$nr<-c(1,3:4,6:8,10:11,13:15,17:20)
cvd.blue.urban$nr<-c(1,3:4,6:8,10:11,13:15,17:20)

res.park.full$nr<-c(1,3:4,6:8,10:11,13:15,17:20)
res.park.urban$nr<-c(1,3:4,6:8,10:11,13:15,17:20)
res.ndvi.full$nr<-c(1,3:4,6:8,10:11,13:15,17:20)
res.ndvi.urban$nr<-c(1,3:4,6:8,10:11,13:15,17:20)
res.blue.full$nr<-c(1,3:4,6:8,10:11,13:15,17:20)
res.blue.urban$nr<-c(1,3:4,6:8,10:11,13:15,17:20)

pdf(file="/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/figures/green_demo_strata_region_cvd_res_full.pdf", width=8.3, height = 11.7, useDingbats = F)
par(mar = c(4.5, 3.5, 2, 1),oma=c(5,3,4,5), mfrow=c(4,3))

plot(cvd.park.full$nr, cvd.park.full$beta_exp, ylim=c(0.89,1.12), xaxt = 'n', ylab="HR", xlab="", main="",pch =19)
axis(1, at=c(1:20), labels = c("main","","male","female","","65-74 yrs","75-84 yrs","85+ yrs","","not eligible","eligible","","White","Black","Unknown/other","","West","South","Northeast","Midwest"),cex.axis=0.8, font=0.5, las=3)
arrows(cvd.park.full$nr, cvd.park.full$Lower_exp, cvd.park.full$nr, cvd.park.full$Upper_exp, angle=90, length=0)
abline(h=1, lty=2)
par(xpd=T)
abline(v=c(2,5,9,12,16,21),lty=1,lwd=8,col="white")

par(xpd=F)
plot(cvd.ndvi.full$nr, cvd.ndvi.full$beta_exp, ylim=c(0.89,1.12), xaxt = 'n', ylab="", xlab="", main="",pch =19)
axis(1, at=c(1:20), labels = c("main","","male","female","","65-74 yrs","75-84 yrs","85+ yrs","","not eligible","eligible","","White","Black","Unknown/other","","West","South","Northeast","Midwest"),cex.axis=0.8, font=0.5, las=3)
arrows(cvd.ndvi.full$nr, cvd.ndvi.full$Lower_exp, cvd.ndvi.full$nr, cvd.ndvi.full$Upper_exp, angle=90, length=0)
abline(h=1, lty=2)
par(xpd=T)
abline(v=c(2,5,9,12,16,21),lty=1,lwd=8,col="white")

par(xpd=F)
plot(cvd.blue.full$nr, cvd.blue.full$beta_exp, ylim=c(0.89,1.12), xaxt = 'n', ylab="", xlab="", main="",pch =19)
axis(1, at=c(1:20), labels = c("main","","male","female","","65-74 yrs","75-84 yrs","85+ yrs","","not eligible","eligible","","White","Black","Unknown/other","","West","South","Northeast","Midwest"),cex.axis=0.8, font=0.5, las=3)
arrows(cvd.blue.full$nr, cvd.blue.full$Lower_exp, cvd.blue.full$nr, cvd.blue.full$Upper_exp, angle=90, length=0)
abline(h=1, lty=2)
par(xpd=T)
abline(v=c(2,5,9,12,16,21),lty=1,lwd=8,col="white")

par(xpd=F)
plot(res.park.full$nr, res.park.full$beta_exp, ylim=c(0.89,1.12), xaxt = 'n', ylab="HR", xlab="", main="",pch =19)
axis(1, at=c(1:20), labels = c("main","","male","female","","65-74 yrs","75-84 yrs","85+ yrs","","not eligible","eligible","","White","Black","Unknown/other","","West","South","Northeast","Midwest"),cex.axis=0.8, font=0.5, las=3)
arrows(res.park.full$nr, res.park.full$Lower_exp, res.park.full$nr, res.park.full$Upper_exp, angle=90, length=0)
abline(h=1, lty=2)
par(xpd=T)
abline(v=c(2,5,9,12,16,21),lty=1,lwd=8,col="white")

par(xpd=F)
plot(res.ndvi.full$nr, res.ndvi.full$beta_exp, ylim=c(0.89,1.12), xaxt = 'n', ylab="", xlab="", main="",pch =19)
axis(1, at=c(1:20), labels = c("main","","male","female","","65-74 yrs","75-84 yrs","85+ yrs","","not eligible","eligible","","White","Black","Unknown/other","","West","South","Northeast","Midwest"),cex.axis=0.8, font=0.5, las=3)
arrows(res.ndvi.full$nr, res.ndvi.full$Lower_exp, res.ndvi.full$nr, res.ndvi.full$Upper_exp, angle=90, length=0)
abline(h=1, lty=2)
par(xpd=T)
abline(v=c(2,5,9,12,16,21),lty=1,lwd=8,col="white")

par(xpd=F)
plot(res.blue.full$nr, res.blue.full$beta_exp, ylim=c(0.89,1.12), xaxt = 'n', ylab="", xlab="", main="",pch =19)
axis(1, at=c(1:20), labels = c("main","","male","female","","65-74 yrs","75-84 yrs","85+ yrs","","not eligible","eligible","","White","Black","Unknown/other","","West","South","Northeast","Midwest"),cex.axis=0.8, font=0.5, las=3)
arrows(res.blue.full$nr, res.blue.full$Lower_exp, res.blue.full$nr, res.blue.full$Upper_exp, angle=90, length=0)
abline(h=1, lty=2)
par(xpd=T)
abline(v=c(2,5,9,12,16,21),lty=1,lwd=8,col="white")

dev.off()

pdf(file="/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/figures/green_demo_strata_region_cvd_res_urban.pdf", width=8.3, height = 11.7, useDingbats = F)
par(mar = c(4.5, 3.5, 2, 1),oma=c(5,3,4,5), mfrow=c(4,3))

par(xpd=F)
plot(cvd.park.urban$nr, cvd.park.urban$beta_exp, ylim=c(0.89,1.12), xaxt = 'n', ylab="HR", xlab="", main="",pch =19)
axis(1, at=c(1:20), labels = c("main","","male","female","","65-74 yrs","75-84 yrs","85+ yrs","","not eligible","eligible","","White","Black","Unknown/other","","West","South","Northeast","Midwest"),cex.axis=0.8, font=0.5, las=3)
arrows(cvd.park.urban$nr, cvd.park.urban$Lower_exp, cvd.park.urban$nr, cvd.park.urban$Upper_exp, angle=90, length=0)
abline(h=1, lty=2)
par(xpd=T)
abline(v=c(2,5,9,12,16,21),lty=1,lwd=8,col="white")

par(xpd=F)
plot(cvd.ndvi.urban$nr, cvd.ndvi.urban$beta_exp, ylim=c(0.89,1.12), xaxt = 'n', ylab="", xlab="", main="",pch =19)
axis(1, at=c(1:20), labels = c("main","","male","female","","65-74 yrs","75-84 yrs","85+ yrs","","not eligible","eligible","","White","Black","Unknown/other","","West","South","Northeast","Midwest"),cex.axis=0.8, font=0.5, las=3)
arrows(cvd.ndvi.urban$nr, cvd.ndvi.urban$Lower_exp, cvd.ndvi.urban$nr, cvd.ndvi.urban$Upper_exp, angle=90, length=0)
abline(h=1, lty=2)
par(xpd=T)
abline(v=c(2,5,9,12,16,21),lty=1,lwd=8,col="white")

par(xpd=F)
plot(cvd.blue.urban$nr, cvd.blue.urban$beta_exp, ylim=c(0.89,1.12), xaxt = 'n', ylab="", xlab="", main="",pch =19)
axis(1, at=c(1:20), labels = c("main","","male","female","","65-74 yrs","75-84 yrs","85+ yrs","","not eligible","eligible","","White","Black","Unknown/other","","West","South","Northeast","Midwest"),cex.axis=0.8, font=0.5, las=3)
arrows(cvd.blue.urban$nr, cvd.blue.urban$Lower_exp, cvd.blue.urban$nr, cvd.blue.urban$Upper_exp, angle=90, length=0)
abline(h=1, lty=2)
par(xpd=T)
abline(v=c(2,5,9,12,16,21),lty=1,lwd=8,col="white")

par(xpd=F)
plot(res.park.urban$nr, res.park.urban$beta_exp, ylim=c(0.89,1.12), xaxt = 'n', ylab="HR", xlab="", main="",pch =19)
axis(1, at=c(1:20), labels = c("main","","male","female","","65-74 yrs","75-84 yrs","85+ yrs","","not eligible","eligible","","White","Black","Unknown/other","","West","South","Northeast","Midwest"),cex.axis=0.8, font=0.5, las=3)
arrows(res.park.urban$nr, res.park.urban$Lower_exp, res.park.urban$nr, res.park.urban$Upper_exp, angle=90, length=0)
abline(h=1, lty=2)
par(xpd=T)
abline(v=c(2,5,9,12,16,21),lty=1,lwd=8,col="white")

par(xpd=F)
plot(res.ndvi.urban$nr, res.ndvi.urban$beta_exp, ylim=c(0.89,1.12), xaxt = 'n', ylab="", xlab="", main="",pch =19)
axis(1, at=c(1:20), labels = c("main","","male","female","","65-74 yrs","75-84 yrs","85+ yrs","","not eligible","eligible","","White","Black","Unknown/other","","West","South","Northeast","Midwest"),cex.axis=0.8, font=0.5, las=3)
arrows(res.ndvi.urban$nr, res.ndvi.urban$Lower_exp, res.ndvi.urban$nr, res.ndvi.urban$Upper_exp, angle=90, length=0)
abline(h=1, lty=2)
par(xpd=T)
abline(v=c(2,5,9,12,16,21),lty=1,lwd=8,col="white")

par(xpd=F)
plot(res.blue.urban$nr, res.blue.urban$beta_exp, ylim=c(0.89,1.12), xaxt = 'n', ylab="", xlab="", main="",pch =19)
axis(1, at=c(1:20), labels = c("main","","male","female","","65-74 yrs","75-84 yrs","85+ yrs","","not eligible","eligible","","White","Black","Unknown/other","","West","South","Northeast","Midwest"),cex.axis=0.8, font=0.5, las=3)
arrows(res.blue.urban$nr, res.blue.urban$Lower_exp, res.blue.urban$nr, res.blue.urban$Upper_exp, angle=90, length=0)
abline(h=1, lty=2)
par(xpd=T)
abline(v=c(2,5,9,12,16,21),lty=1,lwd=8,col="white")

dev.off()
