library(stringi)
library(stringr)
library(ggplot2)
library(readxl)
library("writexl")
library(dplyr)
library(data.table)

#read CVD
park.cvd <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/m5_park_only_cvd.xlsx")
ndvi.cvd <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/m5_ndvi_only_cvd.xlsx")
blue.cvd <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/m5_blue_only_cvd.xlsx")
nobuf.cvd <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/m5_blue_no_buffer_cvd.xlsx")
no2.cvd <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/m5_no2_cvd.xlsx")
pm25.cvd <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/m5_pm25_cvd.xlsx")
ipw.cvd <- read_xlsx("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/ipw_num1_nature_cvd.xlsx")
excl1yr.cvd <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/excl_1yr_cvd.xlsx")
ipw.cvd$AIC<-NULL
ipw.cvd$BIC<-NULL

#read urban CVD
park.cvd.urb <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/m5_park_only_cvd_urb.xlsx")
ndvi.cvd.urb <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/m5_ndvi_only_cvd_urb.xlsx")
blue.cvd.urb <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/m5_blue_only_cvd_urb.xlsx")
nobuf.cvd.urb <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/m5_blue_no_buffer_cvd_urb.xlsx")
no2.cvd.urb <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/m5_no2_cvd_urb.xlsx")
pm25.cvd.urb <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/m5_pm25_cvd_urb.xlsx")
ipw.cvd.urb <- read_xlsx("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/ipw_num1_nature_cvd_urb.xlsx")
excl1yr.cvd.urb <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/excl_1yr_cvd_urb.xlsx")
ipw.cvd.urb$AIC<-NULL
ipw.cvd.urb$BIC<-NULL

#read RES
park.res <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/m5_park_only_res.xlsx")
ndvi.res <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/m5_ndvi_only_res.xlsx")
blue.res <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/m5_blue_only_res.xlsx")
nobuf.res <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/m5_blue_no_buffer_res.xlsx")
no2.res <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/m5_no2_res.xlsx")
pm25.res <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/m5_pm25_res.xlsx")
ipw.res <- read_xlsx("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/ipw_num1_nature_res.xlsx")
excl1yr.res <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/excl_1yr_res.xlsx")
ipw.res$AIC<-NULL
ipw.res$BIC<-NULL

#read urban RES
park.res.urb <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/m5_park_only_res_urb.xlsx")
ndvi.res.urb <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/m5_ndvi_only_res_urb.xlsx")
blue.res.urb <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/m5_blue_only_res_urb.xlsx")
nobuf.res.urb <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/m5_blue_no_buffer_res_urb.xlsx")
no2.res.urb <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/m5_no2_res_urb.xlsx")
pm25.res.urb <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/m5_pm25_res_urb.xlsx")
ipw.res.urb <- read_xlsx("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/ipw_num1_nature_res_urb.xlsx")
excl1yr.res.urb <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/excl_1yr_res_urb.xlsx")
ipw.res.urb$AIC<-NULL
ipw.res.urb$BIC<-NULL

#bind full population
models<-rbind(park.cvd,ndvi.cvd,blue.cvd,nobuf.cvd,no2.cvd,pm25.cvd,excl1yr.cvd,
              park.res,ndvi.res,blue.res,nobuf.res,no2.res,pm25.res,excl1yr.res)
models$X<-NULL
models<-rbind(models,ipw.cvd,ipw.res)
models$pop<-c("full")

#bind urban population
models_urb<-rbind(park.cvd.urb,ndvi.cvd.urb,blue.cvd.urb,nobuf.cvd.urb,no2.cvd.urb,pm25.cvd.urb,excl1yr.cvd.urb,
                  park.res.urb,ndvi.res.urb,blue.res.urb,nobuf.res.urb,no2.res.urb,pm25.res.urb,excl1yr.res.urb)
models_urb$X<-NULL
models_urb<-rbind(models_urb,ipw.cvd.urb,ipw.res.urb)
models_urb$pop<-c("urban")

models<-rbind(models,models_urb)
models$model<-as.character(models$model)
models$model<-ifelse(models$model=="ipw1","ipw",models$model)
rm(list=setdiff(ls(), c("models")))

#read se CVD
park_se_cvd <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/sensitivity/SE/se_m5_only_park_cvd.xlsx")
ndvi_se_cvd <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/sensitivity/SE/se_only_ndvi_cvd.xlsx")
blue_se_cvd <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/sensitivity/SE/se_only_blue_cvd.xlsx")
nobuf_se_cvd <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/sensitivity/SE/se_blue_no_buffer_cvd.xlsx")
pm25_se_cvd <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/sensitivity/SE/se_pm25_cvd.xlsx")
no2_se_cvd <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/sensitivity/SE/se_no2_cvd.xlsx")
ipw_se_cvd <- read_xlsx("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_ipw_num1_nature_cvd.xlsx")
excl1yr_se_cvd <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_excl_1yr_cvd.xlsx")

#read urban se CVD
park_se_cvd.urb <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/sensitivity/SE/se_m5_only_park_cvd_urb.xlsx")
ndvi_se_cvd.urb <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/sensitivity/SE/se_only_ndvi_cvd_urb.xlsx")
blue_se_cvd.urb <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/sensitivity/SE/se_only_blue_cvd_urb.xlsx")
nobuf_se_cvd.urb <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/sensitivity/SE/se_blue_no_buffer_cvd_urb.xlsx")
pm25_se_cvd.urb <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/sensitivity/SE/se_pm25_cvd_urb.xlsx")
no2_se_cvd.urb <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/sensitivity/SE/se_no2_cvd_urb.xlsx")
ipw_se_cvd.urb <- read_xlsx("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_ipw_num1_nature_cvd_urb.xlsx")
excl1yr_se_cvd.urb <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_excl_1yr_cvd_urb.xlsx")

#read se RES
park_se_res <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/sensitivity/SE/se_m5_only_park_res.xlsx")
ndvi_se_res <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/sensitivity/SE/se_only_ndvi_res.xlsx")
blue_se_res <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/sensitivity/SE/se_only_blue_res.xlsx")
nobuf_se_res <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/sensitivity/SE/se_blue_no_buffer_res.xlsx")
pm25_se_res <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/sensitivity/SE/se_pm25_res.xlsx")
no2_se_res <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/sensitivity/SE/se_no2_res.xlsx")
ipw_se_res <- read_xlsx("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_ipw_num1_nature_res.xlsx")
excl1yr_se_res <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_excl_1yr_res.xlsx")

#read se RES
park_se_res.urb <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/sensitivity/SE/se_m5_only_park_res_urb.xlsx")
ndvi_se_res.urb <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/sensitivity/SE/se_only_ndvi_res_urb.xlsx")
blue_se_res.urb <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/sensitivity/SE/se_only_blue_res_urb.xlsx")
nobuf_se_res.urb <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/sensitivity/SE/se_blue_no_buffer_res_urb.xlsx")
pm25_se_res.urb <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/sensitivity/SE/se_pm25_res_urb.xlsx")
no2_se_res.urb <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/sensitivity/SE/se_no2_res_urb.xlsx")
ipw_se_res.urb <- read_xlsx("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_ipw_num1_nature_res_urb.xlsx")
excl1yr_se_res.urb <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_excl_1yr_res_urb.xlsx")

#bind full population
se<-rbind(park_se_cvd,ndvi_se_cvd,blue_se_cvd,nobuf_se_cvd,pm25_se_cvd,no2_se_cvd,excl1yr_se_cvd,
          park_se_res,ndvi_se_res,blue_se_res,nobuf_se_res,pm25_se_res,no2_se_res,excl1yr_se_res)
se$X<-NULL
se<-rbind(se,ipw_se_cvd,ipw_se_res)
se$pop<-c("full")

#bind full population
se_urb<-rbind(park_se_cvd.urb,ndvi_se_cvd.urb,blue_se_cvd.urb,nobuf_se_cvd.urb,pm25_se_cvd.urb,no2_se_cvd.urb,excl1yr_se_cvd.urb,
          park_se_res.urb,ndvi_se_res.urb,blue_se_res.urb,nobuf_se_res.urb,pm25_se_res.urb,no2_se_res.urb,excl1yr_se_res.urb)
se_urb$X<-NULL
se_urb<-rbind(se_urb,ipw_se_cvd.urb,ipw_se_res.urb)
se_urb$pop<-c("urban")

se<-rbind(se,se_urb)

rm(list=setdiff(ls(), c("models", "se")))
se$model<-as.character(se$model)
se$model<-ifelse(se$model=="ipw1","ipw",se$model)

#join models and iqr
models<-left_join(models,se,by=c("model","out","exposure","pop"))

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

main<-main[,c("Beta","model","out","exposure","pop","se")]
#merge main with strata
models<-rbind(main,models)

#import iqr
descr_exposures_strata_cvd <- read_excel("shared_space/ci3_analysis/nature_medicare/Modeloutput/descriptives/descr_exposures_strata_cvd.xlsx")
iqr_exp<-descr_exposures_strata_cvd[,c("pol","iqr")]
iqr_exp<-iqr_exp[iqr_exp$pol=="ndvi_summer"|iqr_exp$pol=="occur_bs_1000m"|iqr_exp$pol=="park",]
setnames(iqr_exp,"pol","exposure")

#join models and iqr
models<-left_join(models,iqr_exp,by="exposure")
models$iqr<-ifelse(models$exposure=="occur_bs",0.03222543,models$iqr)

#calculate effect estimates per IQR increase
models$Lower<-models$Beta-qnorm(1-0.05/2)*models$se
models$Upper<-models$Beta+qnorm(1-0.05/2)*models$se
models$beta_exp<-exp(models$iqr*models$Beta)
models$Lower_exp<-exp(models$iqr*models$Lower)
models$Upper_exp<-exp(models$iqr*models$Upper)

#concatenate columns
models$beta_ci<-paste0(round(models$beta_exp,2)," (",round(models$Lower_exp,2),", ",round(models$Upper_exp,2),")")

write.csv(models, file="/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/tables/HR_sensitivity_region_models_cvd_res.csv")
