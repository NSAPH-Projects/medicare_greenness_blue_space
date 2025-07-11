library(stringi)
library(stringr)
library(ggplot2)
library(readxl)
library("writexl")
library(dplyr)
library(data.table)

#read CVD
#park ndvi blue space
m1_ndvi_blue_cvd <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/m1_quint_cvd_urb.xlsx")
m2_ndvi_blue_cvd <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/m2_quint_cvd_urb.xlsx")
m3_ndvi_blue_cvd <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/m3_quint_cvd_urb.xlsx")
m4_ndvi_blue_cvd <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/m4_quint_cvd_urb.xlsx")
m4_ndvi_blue_cvd$AIC<-NULL
m4_ndvi_blue_cvd$BIC<-NULL

#read RES
#park ndvi blue space
m1_ndvi_blue_res <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/m1_quint_res_urb.xlsx")
m2_ndvi_blue_res <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/m2_quint_res_urb.xlsx")
m3_ndvi_blue_res <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/m3_quint_res_urb.xlsx")
m4_ndvi_blue_res <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/m4_quint_res_urb.xlsx")
m4_ndvi_blue_res$AIC<-NULL
m4_ndvi_blue_res$BIC<-NULL

#read ALZ
#park ndvi blue space
m1_ndvi_blue_alz <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/m1_quint_alz_urb.xlsx")
m2_ndvi_blue_alz <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/m2_quint_alz_urb.xlsx")
m3_ndvi_blue_alz <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/m3_quint_alz_urb.xlsx")
m4_ndvi_blue_alz <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/m4_quint_alz_urb.xlsx")
m4_ndvi_blue_alz$AIC<-NULL
m4_ndvi_blue_alz$BIC<-NULL

#read PAR
#park ndvi blue space
m1_ndvi_blue_par <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/m1_quint_par_urb.xlsx")
m2_ndvi_blue_par <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/m2_quint_par_urb.xlsx")
m3_ndvi_blue_par <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/m3_quint_par_urb.xlsx")
m4_ndvi_blue_par <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/m4_quint_par_urb.xlsx")
m4_ndvi_blue_par$AIC<-NULL
m4_ndvi_blue_par$BIC<-NULL

#bind full population
models<-rbind(m1_ndvi_blue_cvd,m2_ndvi_blue_cvd,m3_ndvi_blue_cvd,m4_ndvi_blue_cvd,
            m1_ndvi_blue_res,m2_ndvi_blue_res,m3_ndvi_blue_res,m4_ndvi_blue_res,
            m1_ndvi_blue_alz,m2_ndvi_blue_alz,m3_ndvi_blue_alz,m4_ndvi_blue_alz,
            m1_ndvi_blue_par,m2_ndvi_blue_par,m3_ndvi_blue_par,m4_ndvi_blue_par)

rm(list=setdiff(ls(), c("models")))

#read se CVD
#park ndvi blue space
m1_se_cvd <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_quintiles_m1_cvd_urb.xlsx")
m2_se_cvd <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_quintiles_m2_cvd_urb.xlsx")
m3_se_cvd <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_quintiles_m3_cvd_urb.xlsx")
m4_se_cvd <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_quintiles_m4_cvd_urb.xlsx")

#read se RES
#park ndvi blue space
m1_se_res <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_quintiles_m1_res_urb.xlsx")
m2_se_res <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_quintiles_m2_res_urb.xlsx")
m3_se_res <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_quintiles_m3_res_urb.xlsx")
m4_se_res <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_quintiles_m4_res_urb.xlsx")

#read se ALZ
#park ndvi blue space
m1_se_alz <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_quintiles_m1_alz_urb.xlsx")
m2_se_alz <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_quintiles_m2_alz_urb.xlsx")
m3_se_alz <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_quintiles_m3_alz_urb.xlsx")
m4_se_alz <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_quintiles_m4_alz_urb.xlsx")

#read se PAR
#park ndvi blue space
m1_se_par <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_quintiles_m1_par_urb.xlsx")
m2_se_par <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_quintiles_m2_par_urb.xlsx")
m3_se_par <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_quintiles_m3_par_urb.xlsx")
m4_se_par <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_quintiles_m4_par_urb.xlsx")

#bind full population
se<-rbind(m1_se_cvd,m2_se_cvd,m3_se_cvd,m4_se_cvd,
              m1_se_res,m2_se_res,m3_se_res,m4_se_res,
              m1_se_alz,m2_se_alz,m3_se_alz,m4_se_alz,
              m1_se_par,m2_se_par,m3_se_par,m4_se_par)

rm(list=setdiff(ls(), c("models", "se")))

#join models and iqr
models<-left_join(models,se,by=c("model","out","exposure"))
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

write.csv(models, file="/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/tables/HR_quintiles_confounder_urb_models.csv")
