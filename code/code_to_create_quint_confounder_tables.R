library(stringi)
library(stringr)
library(ggplot2)
library(readxl)
library("writexl")
library(dplyr)
library(data.table)

#read CVD
#park ndvi blue space
park_cvd <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/sensitivity/single_park_quint_cvd.xlsx")
ndvi_cvd <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/sensitivity/single_ndvi_quint_cvd.xlsx")
blue_cvd <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/sensitivity/single_blue_quint_cvd.xlsx")

#read RES
#park ndvi blue space
park_res <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/sensitivity/single_park_quint_res.xlsx")
ndvi_res <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/sensitivity/single_ndvi_quint_res.xlsx")
blue_res <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/sensitivity/single_blue_quint_res.xlsx")

#read ALZ
#park ndvi blue space
park_alz <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/sensitivity/single_park_quint_alz.xlsx")
ndvi_alz <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/sensitivity/single_ndvi_quint_alz.xlsx")
blue_alz <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/sensitivity/single_blue_quint_alz.xlsx")

#read PAR
#park ndvi blue space
park_par <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/sensitivity/single_park_quint_par.xlsx")
ndvi_par <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/sensitivity/single_ndvi_quint_par.xlsx")
blue_par <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/sensitivity/single_blue_quint_par.xlsx")

#bind full population
models<-rbind(park_cvd,ndvi_cvd,blue_cvd,
            park_res,ndvi_res,blue_res,
            park_alz,ndvi_alz,blue_alz,
            park_par,ndvi_par,blue_par)

rm(list=setdiff(ls(), c("models")))

#read se CVD
#park ndvi blue space
park_se_cvd <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/sensitivity/SE/se_single_park_quintiles_cvd.xlsx")
ndvi_se_cvd <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/sensitivity/SE/se_single_ndvi_quintiles_cvd.xlsx")
blue_se_cvd <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/sensitivity/SE/se_single_blue_quintiles_cvd.xlsx")

#read se RES
#park ndvi blue space
park_se_res <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/sensitivity/SE/se_single_park_quintiles_res.xlsx")
ndvi_se_res <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/sensitivity/SE/se_single_ndvi_quintiles_res.xlsx")
blue_se_res <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/sensitivity/SE/se_single_blue_quintiles_res.xlsx")

#read se ALZ
#park ndvi blue space
park_se_alz <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/sensitivity/SE/se_single_park_quintiles_alz.xlsx")
ndvi_se_alz <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/sensitivity/SE/se_single_ndvi_quintiles_alz.xlsx")
blue_se_alz <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/sensitivity/SE/se_single_blue_quintiles_alz.xlsx")

#read se PAR
#park ndvi blue space
park_se_par <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/sensitivity/SE/se_single_park_quintiles_par.xlsx")
ndvi_se_par <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/sensitivity/SE/se_single_ndvi_quintiles_par.xlsx")
blue_se_par <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/sensitivity/SE/se_single_blue_quintiles_par.xlsx")

#bind full population
se<-rbind(park_se_cvd,ndvi_se_cvd,blue_se_cvd,
              park_se_res,ndvi_se_res,blue_se_res,
              park_se_alz,ndvi_se_alz,blue_se_alz,
              park_se_par,ndvi_se_par,blue_se_par)

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

write.csv(models, file="/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/tables/HR_quintiles_single_models.csv")
