library(stringi)
library(stringr)
library(ggplot2)
library(readxl)
library("writexl")
library(dplyr)
library(data.table)

#read CVD
#park ndvi blue space
m5_cvd <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/m5_quint_cvd.xlsx")
m5_res <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/m5_quint_res.xlsx")
m5_cvd.urb <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/m5_quint_cvd_urb.xlsx")
m5_res.urb <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/m5_quint_res_urb.xlsx")

m5_cvd$pop<-c("full")
m5_res$pop<-c("full")
m5_cvd.urb$pop<-c("urb")
m5_res.urb$pop<-c("urb")

models<-rbind(m5_cvd,m5_res,m5_cvd.urb,m5_res.urb)

#read se CVD
#park ndvi blue space
m5_se_cvd <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_quintiles_m5_cvd.xlsx")
m5_se_res <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_quintiles_m5_res.xlsx")
m5_se_cvd.urb <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_quintiles_m5_cvd_urb.xlsx")
m5_se_res.urb <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_quintiles_m5_res_urb.xlsx")

m5_se_cvd$pop<-c("full")
m5_se_res$pop<-c("full")
m5_se_cvd.urb$pop<-c("urb")
m5_se_res.urb$pop<-c("urb")

#bind full population
se<-rbind(m5_se_cvd,m5_se_res,m5_se_cvd.urb,m5_se_res.urb)

#join models and iqr
models<-left_join(models,se,by=c("model","out","exposure","pop"))

#calculate effect estimates per IQR increase
models$Lower<-models$Beta-qnorm(1-0.05/2)*models$se
models$Upper<-models$Beta+qnorm(1-0.05/2)*models$se
models$beta_exp<-exp(models$Beta)
models$Lower_exp<-exp(models$Lower)
models$Upper_exp<-exp(models$Upper)

#concatenate columns
models$beta_ci<-paste0(round(models$beta_exp,2)," (",round(models$Lower_exp,2),", ",round(models$Upper_exp,2),")")

write.csv(models, file="/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/tables/HR_quintiles_m5_cvd_res_models.csv")

