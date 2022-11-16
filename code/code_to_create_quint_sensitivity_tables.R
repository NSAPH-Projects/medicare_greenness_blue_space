library(stringi)
library(stringr)
library(ggplot2)
library(readxl)
library("writexl")
library(dplyr)
library(data.table)

#read CVD
#park ndvi blue space
tmmx_cvd <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/m4_tmmx_quint_cvd.xlsx")
sph_cvd <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/m4_sph_quint_cvd.xlsx")
pr_cvd <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/m4_pr_quint_cvd.xlsx")
single_park_cvd <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/sensitivity/single_park_quint_cvd.xlsx")
single_ndvi_cvd <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/sensitivity/single_ndvi_quint_cvd.xlsx")
single_blue_cvd <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/sensitivity/single_blue_quint_cvd.xlsx")

#read RES
#park ndvi blue space
tmmx_res <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/m4_tmmx_quint_res.xlsx")
sph_res <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/m4_sph_quint_res.xlsx")
pr_res <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/m4_pr_quint_res.xlsx")
single_park_res <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/sensitivity/single_park_quint_res.xlsx")
single_ndvi_res <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/sensitivity/single_ndvi_quint_res.xlsx")
single_blue_res <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/sensitivity/single_blue_quint_res.xlsx")

#bind full population
full<-rbind(tmmx_cvd,sph_cvd,pr_cvd,single_park_cvd,single_ndvi_cvd,single_blue_cvd,
            tmmx_res,sph_res,pr_res,single_park_res,single_ndvi_res,single_blue_res)

full$strata<-c("full")

#read CVD
#park ndvi blue space
tmmx_cvd_urb <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/m4_tmmx_quint_cvd_urb.xlsx")
sph_cvd_urb <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/m4_sph_quint_cvd_urb.xlsx")
pr_cvd_urb <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/m4_pr_quint_cvd_urb.xlsx")
single_park_cvd_urb <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/sensitivity/single_park_quint_cvd_urb.xlsx")
single_ndvi_cvd_urb <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/sensitivity/single_ndvi_quint_cvd_urb.xlsx")
single_blue_cvd_urb <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/sensitivity/single_blue_quint_cvd_urb.xlsx")

#read RES
#park ndvi blue space
tmmx_res_urb <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/m4_tmmx_quint_res_urb.xlsx")
sph_res_urb <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/m4_sph_quint_res_urb.xlsx")
pr_res_urb <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/m4_pr_quint_res_urb.xlsx")
single_park_res_urb <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/sensitivity/single_park_quint_res_urb.xlsx")
single_ndvi_res_urb <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/sensitivity/single_ndvi_quint_res_urb.xlsx")
single_blue_res_urb <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/sensitivity/single_blue_quint_res_urb.xlsx")

#bind full population
urb<-rbind(tmmx_cvd_urb,sph_cvd_urb,pr_cvd_urb,single_park_cvd_urb,single_ndvi_cvd_urb,single_blue_cvd_urb,
           tmmx_res_urb,sph_res_urb,pr_res_urb,single_park_res_urb,single_ndvi_res_urb,single_blue_res_urb)
urb$strata<-c("urb")

models<-rbind(full,urb)

rm(list=setdiff(ls(), c("models")))

#read se CVD
#park ndvi blue space
se_tmmx_cvd <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_quintiles_tmmx_cvd.xlsx")
se_sph_cvd <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_quintiles_sph_cvd.xlsx")
se_pr_cvd <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_quintiles_pr_cvd.xlsx")
se_single_park_cvd <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/sensitivity/SE/se_single_park_quintiles_cvd.xlsx")
se_single_ndvi_cvd <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/sensitivity/SE/se_single_ndvi_quintiles_cvd.xlsx")
se_single_blue_cvd <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/sensitivity/SE/se_single_blue_quintiles_cvd.xlsx")

#read se RES
#park ndvi blue space
se_tmmx_res <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_quintiles_tmmx_res.xlsx")
se_sph_res <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_quintiles_sph_res.xlsx")
se_pr_res <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_quintiles_pr_res.xlsx")
se_single_park_res <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/sensitivity/SE/se_single_park_quintiles_res.xlsx")
se_single_ndvi_res <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/sensitivity/SE/se_single_ndvi_quintiles_res.xlsx")
se_single_blue_res <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/sensitivity/SE/se_single_blue_quintiles_res.xlsx")

#bind full population
se_full<-rbind(se_tmmx_cvd,se_sph_cvd,se_pr_cvd,se_single_park_cvd,se_single_ndvi_cvd,se_single_blue_cvd,
               se_tmmx_res,se_sph_res,se_pr_res,se_single_park_res,se_single_ndvi_res,se_single_blue_res)

se_full$strata<-c("full")
se_full$X<-NULL

#read se CVD
#park ndvi blue space
se_tmmx_cvd_urb <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_quintiles_tmmx_cvd_urb.xlsx")
se_sph_cvd_urb <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_quintiles_sph_cvd_urb.xlsx")
se_pr_cvd_urb <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_quintiles_pr_cvd_urb.xlsx")
se_single_park_cvd_urb <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/sensitivity/SE/se_single_park_quintiles_cvd_urb.xlsx")
se_single_ndvi_cvd_urb <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/sensitivity/SE/se_single_ndvi_quintiles_cvd_urb.xlsx")
se_single_blue_cvd_urb <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/sensitivity/SE/se_single_blue_quintiles_cvd_urb.xlsx")

#read se RES
#park ndvi blue space
se_tmmx_res_urb <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_quintiles_tmmx_res_urb.xlsx")
se_sph_res_urb <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_quintiles_sph_res_urb.xlsx")
se_pr_res_urb <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_quintiles_pr_res_urb.xlsx")
se_single_park_res_urb <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/sensitivity/SE/se_single_park_quintiles_res_urb.xlsx")
se_single_ndvi_res_urb <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/sensitivity/SE/se_single_ndvi_quintiles_res_urb.xlsx")
se_single_blue_res_urb <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/sensitivity/SE/se_single_blue_quintiles_res_urb.xlsx")

#bind full population
se_urb<-rbind(se_tmmx_cvd_urb,se_sph_cvd_urb,se_pr_cvd_urb,se_single_park_cvd_urb,se_single_ndvi_cvd_urb,se_single_blue_cvd_urb,
              se_tmmx_res_urb,se_sph_res_urb,se_pr_res_urb,se_single_park_res_urb,se_single_ndvi_res_urb,se_single_blue_res_urb)

se_urb$strata<-c("urb")
se_urb$X<-NULL

se<-rbind(se_full,se_urb)
rm(list=setdiff(ls(), c("models", "se")))

#join models and iqr
models<-left_join(models,se,by=c("model","out","exposure","strata"))
models$X<-NULL

#calculate effect estimates per IQR increase
models$Lower<-models$Beta-qnorm(1-0.05/2)*models$se
models$Upper<-models$Beta+qnorm(1-0.05/2)*models$se
models$beta_exp<-exp(models$Beta)
models$Lower_exp<-exp(models$Lower)
models$Upper_exp<-exp(models$Upper)

#concatenate columns
models$beta_ci<-paste0(round(models$beta_exp,2)," (",round(models$Lower_exp,2),", ",round(models$Upper_exp,2),")")

write.csv(models, file="/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/tables/HR_quintiles_sensitivity_cvd_res_models.csv")
