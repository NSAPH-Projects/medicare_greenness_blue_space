library(stringi)
library(stringr)
library(ggplot2)
library(readxl)
library("writexl")
library(dplyr)
library(data.table)

#read CVD
#park ndvi blue space
west_cvd <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/west_quint_cvd_urb.xlsx")
south_cvd <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/south_quint_cvd_urb.xlsx")
northeast_cvd <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/northeast_quint_cvd_urb.xlsx")
midwest_cvd <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/midwest_quint_cvd_urb.xlsx")

#read RES
#park ndvi blue space
west_res <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/west_quint_res_urb.xlsx")
south_res <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/south_quint_res_urb.xlsx")
northeast_res <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/northeast_quint_res_urb.xlsx")
midwest_res <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/midwest_quint_res_urb.xlsx")

#read ALZ
#park ndvi blue space
west_alz <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/west_quint_alz_urb.xlsx")
south_alz <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/south_quint_alz_urb.xlsx")
northeast_alz <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/northeast_quint_alz_urb.xlsx")
midwest_alz <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/midwest_quint_alz_urb.xlsx")

#read PAR
#park ndvi blue space
west_par <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/west_quint_par_urb.xlsx")
south_par <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/south_quint_par_urb.xlsx")
northeast_par <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/northeast_quint_par_urb.xlsx")
midwest_par <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/midwest_quint_par_urb.xlsx")

#bind full population
models<-rbind(west_cvd,south_cvd,northeast_cvd,midwest_cvd,
            west_res,south_res,northeast_res,midwest_res,
            west_alz,south_alz,northeast_alz,midwest_alz,
            west_par,south_par,northeast_par,midwest_par)

rm(list=setdiff(ls(), c("models")))

#read se CVD
#park ndvi blue space
west_se_cvd <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_west_quintiles_cvd_urb.xlsx")
south_se_cvd <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_south_quintiles_cvd_urb.xlsx")
northeast_se_cvd <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_northeast_quintiles_cvd_urb.xlsx")
midwest_se_cvd <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_midwest_quintiles_cvd_urb.xlsx")

#read se RES
#park ndvi blue space
west_se_res <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_west_quintiles_res_urb.xlsx")
south_se_res <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_south_quintiles_res_urb.xlsx")
northeast_se_res <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_northeast_quintiles_res_urb.xlsx")
midwest_se_res <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_midwest_quintiles_res_urb.xlsx")

#read se ALZ
#park ndvi blue space
west_se_alz <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_west_quintiles_alz_urb.xlsx")
south_se_alz <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_south_quintiles_alz_urb.xlsx")
northeast_se_alz <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_northeast_quintiles_alz_urb.xlsx")
midwest_se_alz <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_midwest_quintiles_alz_urb.xlsx")

#read se PAR
#park ndvi blue space
west_se_par <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_west_quintiles_par_urb.xlsx")
south_se_par <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_south_quintiles_par_urb.xlsx")
northeast_se_par <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_northeast_quintiles_par_urb.xlsx")
midwest_se_par <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_midwest_quintiles_par_urb.xlsx")

#bind full population
se<-rbind(west_se_cvd,south_se_cvd,northeast_se_cvd,midwest_se_cvd,
              west_se_res,south_se_res,northeast_se_res,midwest_se_res,
              west_se_alz,south_se_alz,northeast_se_alz,midwest_se_alz,
              west_se_par,south_se_par,northeast_se_par,midwest_se_par)

rm(list=setdiff(ls(), c("models", "se")))

#join models and iqr
models<-left_join(models,se,by=c("model","out","exposure","region"))
models$X.x<-NULL
models$X.y<-NULL

#calculate effect estimates per IQR increase
models$Lower<-models$Beta-qnorm(1-0.05/2)*models$se
models$Upper<-models$Beta+qnorm(1-0.05/2)*models$se
models$beta_exp<-exp(models$Beta)
models$Lower_exp<-exp(models$Lower)
models$Upper_exp<-exp(models$Upper)

#concatenate columns
models$beta_ci<-paste0(round(models$beta_exp,2)," (",round(models$Lower_exp,2),", ",round(models$Upper_exp,2),")")

write.csv(models, file="/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/tables/HR_quintiles_region_urb_models.csv")
