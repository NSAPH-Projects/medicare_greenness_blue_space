library(stringi)
library(stringr)
library(ggplot2)
library(readxl)
library("writexl")
library(dplyr)
library(data.table)

#read alz
sex1.alz <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/sex1_alz.xlsx")
sex2.alz <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/sex2_alz.xlsx")
age65.alz <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/age65_alz.xlsx")
age75.alz <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/age75_alz.xlsx")
age85.alz <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/age85_alz.xlsx")
dual0.alz <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/dual0_alz.xlsx")
dual1.alz <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/dual1_alz.xlsx")
race1.alz <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/race1_alz.xlsx")
race2.alz <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/race2_alz.xlsx")
race3.alz <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/race3_alz.xlsx")
west.alz <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/west_alz.xlsx")
south.alz <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/south_alz.xlsx")
northeast.alz <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/northeast_alz.xlsx")
midwest.alz <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/midwest_alz.xlsx")

#read urban alz
sex1.alz.urb <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/sex1_alz_urb.xlsx")
sex2.alz.urb <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/sex2_alz_urb.xlsx")
age65.alz.urb <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/age65_alz_urb.xlsx")
age75.alz.urb <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/age75_alz_urb.xlsx")
age85.alz.urb <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/age85_alz_urb.xlsx")
dual0.alz.urb <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/dual0_alz_urb.xlsx")
dual1.alz.urb <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/dual1_alz_urb.xlsx")
race1.alz.urb <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/race1_alz_urb.xlsx")
race2.alz.urb <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/race2_alz_urb.xlsx")
race3.alz.urb <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/race3_alz_urb.xlsx")
west.alz.urb <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/west_alz_urb.xlsx")
south.alz.urb <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/south_alz_urb.xlsx")
northeast.alz.urb <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/northeast_alz_urb.xlsx")
midwest.alz.urb <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/midwest_alz_urb.xlsx")

#read par
sex1.par <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/sex1_par.xlsx")
sex2.par <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/sex2_par.xlsx")
age65.par <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/age65_par.xlsx")
age75.par <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/age75_par.xlsx")
age85.par <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/age85_par.xlsx")
dual0.par <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/dual0_par.xlsx")
dual1.par <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/dual1_par.xlsx")
race1.par <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/race1_par.xlsx")
race2.par <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/race2_par.xlsx")
race3.par <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/race3_par.xlsx")
west.par <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/west_par.xlsx")
south.par <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/south_par.xlsx")
northeast.par <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/northeast_par.xlsx")
midwest.par <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/midwest_par.xlsx")

#read urban par
sex1.par.urb <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/sex1_par_urb.xlsx")
sex2.par.urb <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/sex2_par_urb.xlsx")
age65.par.urb <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/age65_par_urb.xlsx")
age75.par.urb <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/age75_par_urb.xlsx")
age85.par.urb <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/age85_par_urb.xlsx")
dual0.par.urb <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/dual0_par_urb.xlsx")
dual1.par.urb <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/dual1_par_urb.xlsx")
race1.par.urb <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/race1_par_urb.xlsx")
race2.par.urb <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/race2_par_urb.xlsx")
race3.par.urb <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/race3_par_urb.xlsx")
west.par.urb <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/west_par_urb.xlsx")
south.par.urb <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/south_par_urb.xlsx")
northeast.par.urb <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/northeast_par_urb.xlsx")
midwest.par.urb <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/midwest_par_urb.xlsx")

#bind full population
models<-rbind(sex1.alz,sex2.alz,age65.alz,age75.alz,age85.alz,dual0.alz,dual1.alz,
              race1.alz,race2.alz,race3.alz,
              sex1.par,sex2.par,age65.par,age75.par,age85.par,dual0.par,dual1.par,
              race1.par,race2.par,race3.par)
region<-rbind(west.alz,south.alz,northeast.alz,midwest.alz,
              west.par,south.par,northeast.par,midwest.par)
setnames(region,"region","strata")
models<-rbind(models,region)
models$pop<-c("full")

#bind urban population
models_urb<-rbind(sex1.alz.urb,sex2.alz.urb,age65.alz.urb,age75.alz.urb,age85.alz.urb,dual0.alz.urb,dual1.alz.urb,
                  race1.alz.urb,race2.alz.urb,race3.alz.urb,
                  sex1.par.urb,sex2.par.urb,age65.par.urb,age75.par.urb,age85.par.urb,dual0.par.urb,dual1.par.urb,
                  race1.par.urb,race2.par.urb,race3.par.urb)
region_urb<-rbind(west.alz.urb,south.alz.urb,northeast.alz.urb,midwest.alz.urb,
              west.par.urb,south.par.urb,northeast.par.urb,midwest.par.urb)
setnames(region_urb,"region","strata")
models_urb<-rbind(models_urb,region_urb)
models_urb$pop<-c("urban")

models<-rbind(models,models_urb)

rm(list=setdiff(ls(), c("models")))

#read se alz
sex1_se_alz <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_sex1_alz.xlsx")
sex2_se_alz <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_sex2_alz.xlsx")
age65_se_alz <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_age65_alz.xlsx")
age75_se_alz <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_age75_alz.xlsx")
age85_se_alz <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_age85_alz.xlsx")
dual0_se_alz <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_dual0_alz.xlsx")
dual1_se_alz <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_dual1_alz.xlsx")
race1_se_alz <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_race1_alz.xlsx")
race2_se_alz <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_race2_alz.xlsx")
race3_se_alz <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_race3_alz.xlsx")
west_se_alz <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_west_alz.xlsx")
south_se_alz <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_south_alz.xlsx")
northeast_se_alz <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_northeast_alz.xlsx")
midwest_se_alz <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_midwest_alz.xlsx")

#read urban se alz
sex1_se_alz.urb <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_sex1_alz_urb.xlsx")
sex2_se_alz.urb <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_sex2_alz_urb.xlsx")
age65_se_alz.urb <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_age65_alz_urb.xlsx")
age75_se_alz.urb <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_age75_alz_urb.xlsx")
age85_se_alz.urb <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_age85_alz_urb.xlsx")
dual0_se_alz.urb <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_dual0_alz_urb.xlsx")
dual1_se_alz.urb <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_dual1_alz_urb.xlsx")
race1_se_alz.urb <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_race1_alz_urb.xlsx")
race2_se_alz.urb <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_race2_alz_urb.xlsx")
race3_se_alz.urb <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_race3_alz_urb.xlsx")
west_se_alz.urb <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_west_alz_urb.xlsx")
south_se_alz.urb <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_south_alz_urb.xlsx")
northeast_se_alz.urb <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_northeast_alz_urb.xlsx")
midwest_se_alz.urb <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_midwest_alz_urb.xlsx")

#read se par
sex1_se_par <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_sex1_par.xlsx")
sex2_se_par <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_sex2_par.xlsx")
age65_se_par <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_age65_par.xlsx")
age75_se_par <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_age75_par.xlsx")
age85_se_par <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_age85_par.xlsx")
dual0_se_par <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_dual0_par.xlsx")
dual1_se_par <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_dual1_par.xlsx")
race1_se_par <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_race1_par.xlsx")
race2_se_par <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_race2_par.xlsx")
race3_se_par <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_race3_par.xlsx")
west_se_par <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_west_par.xlsx")
south_se_par <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_south_par.xlsx")
northeast_se_par <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_northeast_par.xlsx")
midwest_se_par <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_midwest_par.xlsx")

#read se par
sex1_se_par.urb <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_sex1_par_urb.xlsx")
sex2_se_par.urb <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_sex2_par_urb.xlsx")
age65_se_par.urb <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_age65_par_urb.xlsx")
age75_se_par.urb <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_age75_par_urb.xlsx")
age85_se_par.urb <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_age85_par_urb.xlsx")
dual0_se_par.urb <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_dual0_par_urb.xlsx")
dual1_se_par.urb <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_dual1_par_urb.xlsx")
race1_se_par.urb <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_race1_par_urb.xlsx")
race2_se_par.urb <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_race2_par_urb.xlsx")
race3_se_par.urb <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_race3_par_urb.xlsx")
west_se_par.urb <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_west_par_urb.xlsx")
south_se_par.urb <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_south_par_urb.xlsx")
northeast_se_par.urb <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_northeast_par_urb.xlsx")
midwest_se_par.urb <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_midwest_par_urb.xlsx")

#bind full population
se<-rbind(sex1_se_alz,sex2_se_alz,age65_se_alz,age75_se_alz,age85_se_alz,dual0_se_alz,dual1_se_alz,race1_se_alz,race2_se_alz,race3_se_alz,
          sex1_se_par,sex2_se_par,age65_se_par,age75_se_par,age85_se_par,dual0_se_par,dual1_se_par,race1_se_par,race2_se_par,race3_se_par)
se.region<-rbind(west_se_alz,south_se_alz,northeast_se_alz,midwest_se_alz,
              west_se_par,south_se_par,northeast_se_par,midwest_se_par)
setnames(se.region,"region","strata")
se<-rbind(se,se.region)
se$pop<-c("full")

#bind full population
se_urb<-rbind(sex1_se_alz.urb,sex2_se_alz.urb,age65_se_alz.urb,age75_se_alz.urb,age85_se_alz.urb,dual0_se_alz.urb,dual1_se_alz.urb,race1_se_alz.urb,race2_se_alz.urb,race3_se_alz.urb,
          sex1_se_par.urb,sex2_se_par.urb,age65_se_par.urb,age75_se_par.urb,age85_se_par.urb,dual0_se_par.urb,dual1_se_par.urb,race1_se_par.urb,race2_se_par.urb,race3_se_par)
se.region_urb<-rbind(west_se_alz.urb,south_se_alz.urb,northeast_se_alz.urb,midwest_se_alz.urb,
                 west_se_par.urb,south_se_par.urb,northeast_se_par.urb,midwest_se_par)
setnames(se.region_urb,"region","strata")
se_urb<-rbind(se_urb,se.region_urb)
se_urb$pop<-c("urban")

se<-rbind(se,se_urb)

rm(list=setdiff(ls(), c("models", "se")))

models$X<-NULL
se$X<-NULL
models$strata<-tolower(models$strata)
#join models and iqr
models<-left_join(models,se,by=c("out","exposure","strata","pop"))
models$model.x<-NULL
models$model.y<-NULL

#import main models
m5_ndvi_blue_alz <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/m4_alz.xlsx")
m5_ndvi_blue_urb_alz <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/m4_alz_urb.xlsx")
m5_ndvi_blue_par <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/m4_par.xlsx")
m5_ndvi_blue_urb_par <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/m4_par_urb.xlsx")
m5_ndvi_blue_alz$pop<-c("full")
m5_ndvi_blue_par$pop<-c("full")
m5_ndvi_blue_urb_alz$pop<-c("urban")
m5_ndvi_blue_urb_par$pop<-c("urban")
main<-rbind(m5_ndvi_blue_alz,m5_ndvi_blue_par,m5_ndvi_blue_urb_alz,m5_ndvi_blue_urb_par)

m5_se_alz <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_m4_alz.xlsx")
m5_se_par <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_m4_par.xlsx")
m5_se_alz_urb <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_m4_alz_urb.xlsx")
m5_se_par_urb <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_m4_par_urb.xlsx")
m5_se_alz$pop<-c("full")
m5_se_par$pop<-c("full")
m5_se_alz_urb$pop<-c("urban")
m5_se_par_urb$pop<-c("urban")
main.se<-rbind(m5_se_alz,m5_se_par,m5_se_alz_urb,m5_se_par_urb)

#merge main with main.se
main<-left_join(main,main.se,by=c("model","out","exposure","pop"))
main$strata<-c("main")

main<-main[,c("Beta","out","strata","exposure","pop","se")]
#merge main with strata
models<-rbind(main,models)

#import iqr
descr_exposures_strata_alz <- read_excel("shared_space/ci3_analysis/nature_medicare/Modeloutput/descriptives/descr_exposures_strata_alz.xlsx")
iqr_exp<-descr_exposures_strata_alz[,c("pol","iqr")]
iqr_exp<-iqr_exp[iqr_exp$pol=="ndvi_summer"|iqr_exp$pol=="park",]
setnames(iqr_exp,"pol","exposure")

#join models and iqr
models<-left_join(models,iqr_exp,by="exposure")
models$iqr<-ifelse(is.na(models$iqr),1,models$iqr)

#calculate effect estimates per IQR increase
models$Lower<-models$Beta-qnorm(1-0.05/2)*models$se
models$Upper<-models$Beta+qnorm(1-0.05/2)*models$se
models$beta_exp<-exp(models$iqr*models$Beta)
models$Lower_exp<-exp(models$iqr*models$Lower)
models$Upper_exp<-exp(models$iqr*models$Upper)

#concatenate columns
models$beta_ci<-paste0(round(models$beta_exp,2)," (",round(models$Lower_exp,2),", ",round(models$Upper_exp,2),")")

write.csv(models, file="/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/tables/HR_demo_strata_models_alz_par.csv")

park<-subset(models,models$exposure=="park")
ndvi<-subset(models,models$exposure=="ndvi_summer")
blue<-subset(models,models$exposure=="as.factor(occur_bs_1000m_bin)1")

alz.park.full<-subset(park,park$out=="alz"&park$pop=="full")
alz.park.urban<-subset(park,park$out=="alz"&park$pop=="urban")
alz.ndvi.full<-subset(ndvi,ndvi$out=="alz"&park$pop=="full")
alz.ndvi.urban<-subset(ndvi,ndvi$out=="alz"&park$pop=="urban")
alz.blue.full<-subset(blue,blue$out=="alz"&park$pop=="full")
alz.blue.urban<-subset(blue,blue$out=="alz"&park$pop=="urban")

par.park.full<-subset(park,park$out=="par"&park$pop=="full")
par.park.urban<-subset(park,park$out=="par"&park$pop=="urban")
par.ndvi.full<-subset(ndvi,ndvi$out=="par"&park$pop=="full")
par.ndvi.urban<-subset(ndvi,ndvi$out=="par"&park$pop=="urban")
par.blue.full<-subset(blue,blue$out=="par"&park$pop=="full")
par.blue.urban<-subset(blue,blue$out=="par"&park$pop=="urban")

#add nmmrs to plot
alz.park.full$nr<-c(1,3:4,6:8,10:11,13:15,17:20)
alz.park.urban$nr<-c(1,3:4,6:8,10:11,13:15,17:20)
alz.ndvi.full$nr<-c(1,3:4,6:8,10:11,13:15,17:20)
alz.ndvi.urban$nr<-c(1,3:4,6:8,10:11,13:15,17:20)
alz.blue.full$nr<-c(1,3:4,6:8,10:11,13:15,17:20)
alz.blue.urban$nr<-c(1,3:4,6:8,10:11,13:15,17:20)

par.park.full$nr<-c(1,3:4,6:8,10:11,13:15,17:20)
par.park.urban$nr<-c(1,3:4,6:8,10:11,13:15,17:20)
par.ndvi.full$nr<-c(1,3:4,6:8,10:11,13:15,17:20)
par.ndvi.urban$nr<-c(1,3:4,6:8,10:11,13:15,17:20)
par.blue.full$nr<-c(1,3:4,6:8,10:11,13:15,17:20)
par.blue.urban$nr<-c(1,3:4,6:8,10:11,13:15,17:20)

pdf(file="/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/figures/green_demo_strata_alz_par_full.pdf", width=8.3, height = 11.7, useDingbats = F)
par(mar = c(4.5, 3.5, 2, 1),oma=c(5,3,4,5), mfrow=c(4,3))

par(xpd=F)
plot(alz.ndvi.full$nr, alz.ndvi.full$beta_exp, ylim=c(0.82,1.08), xaxt = 'n', ylab="", xlab="", main="",pch =19)
axis(1, at=c(1:20), labels = c("main","","male","female","","65-74 yrs","75-84 yrs","85+ yrs","","not eligible","eligible","","White","Black","Unknown/other","","West","South","Northeast","Midwest"),cex.axis=0.8, font=0.5, las=3)
arrows(alz.ndvi.full$nr, alz.ndvi.full$Lower_exp, alz.ndvi.full$nr, alz.ndvi.full$Upper_exp, angle=90, length=0)
abline(h=1, lty=2)
par(xpd=T)
abline(v=c(2,5,9,12,16,21),lty=1,lwd=8,col="white")

plot(alz.park.full$nr, alz.park.full$beta_exp, ylim=c(0.82,1.08), xaxt = 'n', ylab="HR", xlab="", main="",pch =19)
axis(1, at=c(1:20), labels = c("main","","male","female","","65-74 yrs","75-84 yrs","85+ yrs","","not eligible","eligible","","White","Black","Unknown/other","","West","South","Northeast","Midwest"),cex.axis=0.8, font=0.5, las=3)
arrows(alz.park.full$nr, alz.park.full$Lower_exp, alz.park.full$nr, alz.park.full$Upper_exp, angle=90, length=0)
abline(h=1, lty=2)
par(xpd=T)
abline(v=c(2,5,9,12,16,21),lty=1,lwd=8,col="white")

par(xpd=F)
plot(alz.blue.full$nr, alz.blue.full$beta_exp, ylim=c(0.82,1.08), xaxt = 'n', ylab="", xlab="", main="",pch =19)
axis(1, at=c(1:20), labels = c("main","","male","female","","65-74 yrs","75-84 yrs","85+ yrs","","not eligible","eligible","","White","Black","Unknown/other","","West","South","Northeast","Midwest"),cex.axis=0.8, font=0.5, las=3)
arrows(alz.blue.full$nr, alz.blue.full$Lower_exp, alz.blue.full$nr, alz.blue.full$Upper_exp, angle=90, length=0)
abline(h=1, lty=2)
par(xpd=T)
abline(v=c(2,5,9,12,16,21),lty=1,lwd=8,col="white")

par(xpd=F)
plot(par.ndvi.full$nr, par.ndvi.full$beta_exp, ylim=c(0.82,1.08), xaxt = 'n', ylab="", xlab="", main="",pch =19)
axis(1, at=c(1:20), labels = c("main","","male","female","","65-74 yrs","75-84 yrs","85+ yrs","","not eligible","eligible","","White","Black","Unknown/other","","West","South","Northeast","Midwest"),cex.axis=0.8, font=0.5, las=3)
arrows(par.ndvi.full$nr, par.ndvi.full$Lower_exp, par.ndvi.full$nr, par.ndvi.full$Upper_exp, angle=90, length=0)
abline(h=1, lty=2)
par(xpd=T)
abline(v=c(2,5,9,12,16,21),lty=1,lwd=8,col="white")

par(xpd=F)
plot(par.park.full$nr, par.park.full$beta_exp, ylim=c(0.82,1.08), xaxt = 'n', ylab="HR", xlab="", main="",pch =19)
axis(1, at=c(1:20), labels = c("main","","male","female","","65-74 yrs","75-84 yrs","85+ yrs","","not eligible","eligible","","White","Black","Unknown/other","","West","South","Northeast","Midwest"),cex.axis=0.8, font=0.5, las=3)
arrows(par.park.full$nr, par.park.full$Lower_exp, par.park.full$nr, par.park.full$Upper_exp, angle=90, length=0)
abline(h=1, lty=2)
par(xpd=T)
abline(v=c(2,5,9,12,16,21),lty=1,lwd=8,col="white")

par(xpd=F)
plot(par.blue.full$nr, par.blue.full$beta_exp, ylim=c(0.82,1.08), xaxt = 'n', ylab="", xlab="", main="",pch =19)
axis(1, at=c(1:20), labels = c("main","","male","female","","65-74 yrs","75-84 yrs","85+ yrs","","not eligible","eligible","","White","Black","Unknown/other","","West","South","Northeast","Midwest"),cex.axis=0.8, font=0.5, las=3)
arrows(par.blue.full$nr, par.blue.full$Lower_exp, par.blue.full$nr, par.blue.full$Upper_exp, angle=90, length=0)
abline(h=1, lty=2)
par(xpd=T)
abline(v=c(2,5,9,12,16,21),lty=1,lwd=8,col="white")

dev.off()

pdf(file="/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/figures/green_demo_strata_alz_par_urban.pdf", width=8.3, height = 11.7, useDingbats = F)
par(mar = c(4.5, 3.5, 2, 1),oma=c(5,3,4,5), mfrow=c(4,3))

par(xpd=F)
plot(alz.ndvi.urban$nr, alz.ndvi.urban$beta_exp, ylim=c(0.82,1.12), xaxt = 'n', ylab="", xlab="", main="",pch =19)
axis(1, at=c(1:20), labels = c("main","","male","female","","65-74 yrs","75-84 yrs","85+ yrs","","not eligible","eligible","","White","Black","Unknown/other","","West","South","Northeast","Midwest"),cex.axis=0.8, font=0.5, las=3)
arrows(alz.ndvi.urban$nr, alz.ndvi.urban$Lower_exp, alz.ndvi.urban$nr, alz.ndvi.urban$Upper_exp, angle=90, length=0)
abline(h=1, lty=2)
par(xpd=T)
abline(v=c(2,5,9,12,16,21),lty=1,lwd=8,col="white")

par(xpd=F)
plot(alz.park.urban$nr, alz.park.urban$beta_exp, ylim=c(0.82,1.12), xaxt = 'n', ylab="HR", xlab="", main="",pch =19)
axis(1, at=c(1:20), labels = c("main","","male","female","","65-74 yrs","75-84 yrs","85+ yrs","","not eligible","eligible","","White","Black","Unknown/other","","West","South","Northeast","Midwest"),cex.axis=0.8, font=0.5, las=3)
arrows(alz.park.urban$nr, alz.park.urban$Lower_exp, alz.park.urban$nr, alz.park.urban$Upper_exp, angle=90, length=0)
abline(h=1, lty=2)
par(xpd=T)
abline(v=c(2,5,9,12,16,21),lty=1,lwd=8,col="white")

par(xpd=F)
plot(alz.blue.urban$nr, alz.blue.urban$beta_exp, ylim=c(0.82,1.12), xaxt = 'n', ylab="", xlab="", main="",pch =19)
axis(1, at=c(1:20), labels = c("main","","male","female","","65-74 yrs","75-84 yrs","85+ yrs","","not eligible","eligible","","White","Black","Unknown/other","","West","South","Northeast","Midwest"),cex.axis=0.8, font=0.5, las=3)
arrows(alz.blue.urban$nr, alz.blue.urban$Lower_exp, alz.blue.urban$nr, alz.blue.urban$Upper_exp, angle=90, length=0)
abline(h=1, lty=2)
par(xpd=T)
abline(v=c(2,5,9,12,16,21),lty=1,lwd=8,col="white")

par(xpd=F)
plot(par.ndvi.urban$nr, par.ndvi.urban$beta_exp, ylim=c(0.82,1.12), xaxt = 'n', ylab="", xlab="", main="",pch =19)
axis(1, at=c(1:20), labels = c("main","","male","female","","65-74 yrs","75-84 yrs","85+ yrs","","not eligible","eligible","","White","Black","Unknown/other","","West","South","Northeast","Midwest"),cex.axis=0.8, font=0.5, las=3)
arrows(par.ndvi.urban$nr, par.ndvi.urban$Lower_exp, par.ndvi.urban$nr, par.ndvi.urban$Upper_exp, angle=90, length=0)
abline(h=1, lty=2)
par(xpd=T)
abline(v=c(2,5,9,12,16,21),lty=1,lwd=8,col="white")

par(xpd=F)
plot(par.park.urban$nr, par.park.urban$beta_exp, ylim=c(0.82,1.12), xaxt = 'n', ylab="HR", xlab="", main="",pch =19)
axis(1, at=c(1:20), labels = c("main","","male","female","","65-74 yrs","75-84 yrs","85+ yrs","","not eligible","eligible","","White","Black","Unknown/other","","West","South","Northeast","Midwest"),cex.axis=0.8, font=0.5, las=3)
arrows(par.park.urban$nr, par.park.urban$Lower_exp, par.park.urban$nr, par.park.urban$Upper_exp, angle=90, length=0)
abline(h=1, lty=2)
par(xpd=T)
abline(v=c(2,5,9,12,16,21),lty=1,lwd=8,col="white")

par(xpd=F)
plot(par.blue.urban$nr, par.blue.urban$beta_exp, ylim=c(0.82,1.12), xaxt = 'n', ylab="", xlab="", main="",pch =19)
axis(1, at=c(1:20), labels = c("main","","male","female","","65-74 yrs","75-84 yrs","85+ yrs","","not eligible","eligible","","White","Black","Unknown/other","","West","South","Northeast","Midwest"),cex.axis=0.8, font=0.5, las=3)
arrows(par.blue.urban$nr, par.blue.urban$Lower_exp, par.blue.urban$nr, par.blue.urban$Upper_exp, angle=90, length=0)
abline(h=1, lty=2)
par(xpd=T)
abline(v=c(2,5,9,12,16,21),lty=1,lwd=8,col="white")

dev.off()
