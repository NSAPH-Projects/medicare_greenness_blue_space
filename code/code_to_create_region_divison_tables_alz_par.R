library(stringi)
library(stringr)
library(ggplot2)
library(readxl)
library("writexl")
library(dplyr)
library(data.table)

#read ALZ
#park ndvi blue space
m4_ndvi_blue_alz <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/m4_alz.xlsx")
m4_ndvi_blue_alz$AIC<-NULL
m4_ndvi_blue_alz$BIC<-NULL
m4_ndvi_blue_alz_reg <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/m4_alz_reg4.xlsx")
m4_ndvi_blue_alz_reg$AIC<-NULL
m4_ndvi_blue_alz_reg$BIC<-NULL
m4_ndvi_blue_alz_div <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/m4_alz_div.xlsx")
m4_ndvi_blue_alz_div$AIC<-NULL
m4_ndvi_blue_alz_div$BIC<-NULL
m4_ndvi_blue_alz_div$model<-c("division")
m5_ndvi_blue_alz <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/m5_alz.xlsx")
m5_ndvi_blue_alz$AIC<-NULL
m5_ndvi_blue_alz$BIC<-NULL

#read urban alz
#ndvi blue space
m4_ndvi_blue_urb_alz <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/m4_alz_urb.xlsx")
m4_ndvi_blue_urb_alz$AIC<-NULL
m4_ndvi_blue_urb_alz$BIC<-NULL
m4_ndvi_blue_urb_alz_reg <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/m4_alz_urb_reg4.xlsx")
m4_ndvi_blue_urb_alz_reg$AIC<-NULL
m4_ndvi_blue_urb_alz_reg$BIC<-NULL
m4_ndvi_blue_urb_alz_div <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/m4_alz_urb_div.xlsx")
m4_ndvi_blue_urb_alz_div$AIC<-NULL
m4_ndvi_blue_urb_alz_div$BIC<-NULL
m4_ndvi_blue_urb_alz_div$model<-c("division")
m5_ndvi_blue_urb_alz <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/m5_alz_urb.xlsx")
m5_ndvi_blue_urb_alz$AIC<-NULL
m5_ndvi_blue_urb_alz$BIC<-NULL

#read PAR
#park ndvi blue space
m4_ndvi_blue_par <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/m4_par.xlsx")
m4_ndvi_blue_par$AIC<-NULL
m4_ndvi_blue_par$BIC<-NULL
m4_ndvi_blue_par_reg <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/m4_par_reg4.xlsx")
m4_ndvi_blue_par_reg$AIC<-NULL
m4_ndvi_blue_par_reg$BIC<-NULL
m4_ndvi_blue_par_div <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/m4_par_div.xlsx")
m4_ndvi_blue_par_div$AIC<-NULL
m4_ndvi_blue_par_div$BIC<-NULL
m4_ndvi_blue_par_div$model<-c("division")
m5_ndvi_blue_par <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/m5_par.xlsx")
m5_ndvi_blue_par$AIC<-NULL
m5_ndvi_blue_par$BIC<-NULL

#read par
#ndvi blue space
m4_ndvi_blue_urb_par <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/m4_par_urb.xlsx")
m4_ndvi_blue_urb_par$AIC<-NULL
m4_ndvi_blue_urb_par$BIC<-NULL
m4_ndvi_blue_urb_par_reg <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/m4_par_urb_reg4.xlsx")
m4_ndvi_blue_urb_par_reg$AIC<-NULL
m4_ndvi_blue_urb_par_reg$BIC<-NULL
m4_ndvi_blue_urb_par_div <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/m4_par_urb_div.xlsx")
m4_ndvi_blue_urb_par_div$AIC<-NULL
m4_ndvi_blue_urb_par_div$BIC<-NULL
m4_ndvi_blue_urb_par_div$model<-c("division")
m5_ndvi_blue_urb_par <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/m5_par_urb.xlsx")
m5_ndvi_blue_urb_par$AIC<-NULL
m5_ndvi_blue_urb_par$BIC<-NULL

#bind full population
models<-rbind(m4_ndvi_blue_alz,m4_ndvi_blue_alz_reg,m4_ndvi_blue_alz_div,m5_ndvi_blue_alz,
              m4_ndvi_blue_par,m4_ndvi_blue_par_reg,m4_ndvi_blue_par_div,m5_ndvi_blue_par)
models$pop<-c("full")

#bind full population
models_urb<-rbind(m4_ndvi_blue_urb_alz,m4_ndvi_blue_urb_alz_reg,m4_ndvi_blue_urb_alz_div,m5_ndvi_blue_urb_alz,
                  m4_ndvi_blue_urb_par,m4_ndvi_blue_urb_par_reg,m4_ndvi_blue_urb_par_div,m5_ndvi_blue_urb_par)
models_urb$pop<-c("urban")

models<-rbind(models,models_urb)

rm(list=setdiff(ls(), c("models")))

#import iqr
descr_exposures_strata_alz <- read_excel("shared_space/ci3_analysis/nature_medicare/Modeloutput/descriptives/descr_exposures_strata_alz.xlsx")
iqr_exp<-descr_exposures_strata_alz[,c("pol","iqr")]
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

write.csv(models, file="/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/tables/HR_models_alz_par_reg4_div.csv")
