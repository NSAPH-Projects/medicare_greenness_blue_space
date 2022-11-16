library(stringi)
library(stringr)
library(ggplot2)
library(readxl)
library("writexl")
library(dplyr)
library(data.table)

#read CVD
#ndvi blue space
m1_ndvi_blue_urb_cvd <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/m1_cvd_urb.xlsx")
m2_ndvi_blue_urb_cvd <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/m2_cvd_urb.xlsx")
m3_ndvi_blue_urb_cvd <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/m3_cvd_urb.xlsx")
m4_ndvi_blue_urb_cvd <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/m4_cvd_urb.xlsx")
m4_ndvi_blue_urb_cvd$AIC<-NULL
m4_ndvi_blue_urb_cvd$BIC<-NULL

#read RES
#ndvi blue space
m1_ndvi_blue_urb_res <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/m1_res_urb.xlsx")
m2_ndvi_blue_urb_res <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/m2_res_urb.xlsx")
m3_ndvi_blue_urb_res <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/m3_res_urb.xlsx")
m4_ndvi_blue_urb_res <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/m4_res_urb.xlsx")
m4_ndvi_blue_urb_res$AIC<-NULL
m4_ndvi_blue_urb_res$BIC<-NULL

#read ALZ
#ndvi blue space
m1_ndvi_blue_urb_alz <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/m1_alz_urb.xlsx")
m2_ndvi_blue_urb_alz <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/m2_alz_urb.xlsx")
m3_ndvi_blue_urb_alz <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/m3_alz_urb.xlsx")
m4_ndvi_blue_urb_alz <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/m4_alz_urb.xlsx")
m4_ndvi_blue_urb_alz$AIC<-NULL
m4_ndvi_blue_urb_alz$BIC<-NULL

#read PAR
#ndvi blue space
m1_ndvi_blue_urb_par <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/m1_par_urb.xlsx")
m2_ndvi_blue_urb_par <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/m2_par_urb.xlsx")
m3_ndvi_blue_urb_par <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/m3_par_urb.xlsx")
m4_ndvi_blue_urb_par <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/m4_par_urb.xlsx")
m4_ndvi_blue_urb_par$AIC<-NULL
m4_ndvi_blue_urb_par$BIC<-NULL


#bind full population
models<-rbind(m1_ndvi_blue_urb_cvd,m2_ndvi_blue_urb_cvd,m3_ndvi_blue_urb_cvd,m4_ndvi_blue_urb_cvd,
              m1_ndvi_blue_urb_res,m2_ndvi_blue_urb_res,m3_ndvi_blue_urb_res,m4_ndvi_blue_urb_res,
              m1_ndvi_blue_urb_alz,m2_ndvi_blue_urb_alz,m3_ndvi_blue_urb_alz,m4_ndvi_blue_urb_alz,
              m1_ndvi_blue_urb_par,m2_ndvi_blue_urb_par,m3_ndvi_blue_urb_par,m4_ndvi_blue_urb_par)

rm(list=setdiff(ls(), c("models")))


#read se CVD
#park ndvi blue space
m1_se_cvd <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_m1_cvd_urb.xlsx")
m2_se_cvd <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_m2_cvd_urb.xlsx")
m3_se_cvd <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_m3_cvd_urb.xlsx")
m4_se_cvd <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_m4_cvd_urb.xlsx")

#read se RES
#park ndvi blue space
m1_se_res <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_m1_res_urb.xlsx")
m2_se_res <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_m2_res_urb.xlsx")
m3_se_res <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_m3_res_urb.xlsx")
m4_se_res <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_m4_res_urb.xlsx")

#read se ALZ
#park ndvi blue space
m1_se_alz <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_m1_alz_urb.xlsx")
m2_se_alz <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_m2_alz_urb.xlsx")
m3_se_alz <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_m3_alz_urb.xlsx")
m4_se_alz <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_m4_alz_urb.xlsx")

#read se PAR
#park ndvi blue space
m1_se_par <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_m1_par_urb.xlsx")
m2_se_par <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_m2_par_urb.xlsx")
m3_se_par <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_m3_par_urb.xlsx")
m4_se_par <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_m4_par_urb.xlsx")

#bind full population
se<-rbind(m1_se_cvd,m2_se_cvd,m3_se_cvd,m4_se_cvd,
          m1_se_res,m2_se_res,m3_se_res,m4_se_res,
          m1_se_alz,m2_se_alz,m3_se_alz,m4_se_alz,
          m1_se_par,m2_se_par,m3_se_par,m4_se_par)

rm(list=setdiff(ls(), c("models", "se")))

#join models and iqr
models<-left_join(models,se,by=c("model","out","exposure"))

#import iqr
descr_exposures_strata_cvd <- read_excel("shared_space/ci3_analysis/nature_medicare/Modeloutput/descriptives/descr_exposures_strata_res.xlsx")
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

write.csv(models, file="/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/tables/HR_confounder_urb_models.csv")
