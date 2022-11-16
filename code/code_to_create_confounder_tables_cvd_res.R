library(stringi)
library(stringr)
library(ggplot2)
library(readxl)
library("writexl")
library(dplyr)
library(data.table)

#read CVD
#park ndvi blue space
m1_ndvi_blue_cvd <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/m1_cvd.xlsx")
m2_ndvi_blue_cvd <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/m2_cvd.xlsx")
m3_ndvi_blue_cvd <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/m3_cvd.xlsx")
m4_ndvi_blue_cvd <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/m4_cvd.xlsx")
m4_ndvi_blue_cvd$AIC<-NULL
m4_ndvi_blue_cvd$BIC<-NULL
m5_ndvi_blue_cvd <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/m5_cvd.xlsx")
m5_ndvi_blue_cvd$AIC<-NULL
m5_ndvi_blue_cvd$BIC<-NULL

#read urban CVD
#ndvi blue space
m1_ndvi_blue_urb_cvd <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/m1_cvd_urb.xlsx")
m2_ndvi_blue_urb_cvd <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/m2_cvd_urb.xlsx")
m3_ndvi_blue_urb_cvd <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/m3_cvd_urb.xlsx")
m4_ndvi_blue_urb_cvd <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/m4_cvd_urb.xlsx")
m4_ndvi_blue_urb_cvd$AIC<-NULL
m4_ndvi_blue_urb_cvd$BIC<-NULL
m5_ndvi_blue_urb_cvd <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/m5_cvd_urb.xlsx")
m5_ndvi_blue_urb_cvd$AIC<-NULL
m5_ndvi_blue_urb_cvd$BIC<-NULL

#read RES
#park ndvi blue space
m1_ndvi_blue_res <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/m1_res.xlsx")
m2_ndvi_blue_res <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/m2_res.xlsx")
m3_ndvi_blue_res <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/m3_res.xlsx")
m4_ndvi_blue_res <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/m4_res.xlsx")
m4_ndvi_blue_res$AIC<-NULL
m4_ndvi_blue_res$BIC<-NULL
m5_ndvi_blue_res <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/m5_res.xlsx")
m5_ndvi_blue_res$AIC<-NULL
m5_ndvi_blue_res$BIC<-NULL

#read RES
#ndvi blue space
m1_ndvi_blue_urb_res <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/m1_res_urb.xlsx")
m2_ndvi_blue_urb_res <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/m2_res_urb.xlsx")
m3_ndvi_blue_urb_res <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/m3_res_urb.xlsx")
m4_ndvi_blue_urb_res <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/m4_res_urb.xlsx")
m4_ndvi_blue_urb_res$AIC<-NULL
m4_ndvi_blue_urb_res$BIC<-NULL
m5_ndvi_blue_urb_res <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/m5_res_urb.xlsx")
m5_ndvi_blue_urb_res$AIC<-NULL
m5_ndvi_blue_urb_res$BIC<-NULL

#bind full population
models<-rbind(m1_ndvi_blue_cvd,m2_ndvi_blue_cvd,m3_ndvi_blue_cvd,m4_ndvi_blue_cvd,m5_ndvi_blue_cvd,
            m1_ndvi_blue_res,m2_ndvi_blue_res,m3_ndvi_blue_res,m4_ndvi_blue_res,m5_ndvi_blue_res)
models$pop<-c("full")

#bind full population
models_urb<-rbind(m1_ndvi_blue_urb_cvd,m2_ndvi_blue_urb_cvd,m3_ndvi_blue_urb_cvd,m4_ndvi_blue_urb_cvd,m5_ndvi_blue_urb_cvd,
              m1_ndvi_blue_urb_res,m2_ndvi_blue_urb_res,m3_ndvi_blue_urb_res,m4_ndvi_blue_urb_res,m5_ndvi_blue_urb_res)
models_urb$pop<-c("urban")

models<-rbind(models,models_urb)

rm(list=setdiff(ls(), c("models")))

#read se CVD
#park ndvi blue space
m1_se_cvd <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_m1_cvd.xlsx")
m2_se_cvd <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_m2_cvd.xlsx")
m3_se_cvd <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_m3_cvd.xlsx")
m4_se_cvd <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_m4_cvd.xlsx")
m5_se_cvd <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_m5_cvd.xlsx")

#read se RES
#park ndvi blue space
m1_se_res <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_m1_res.xlsx")
m2_se_res <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_m2_res.xlsx")
m3_se_res <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_m3_res.xlsx")
m4_se_res <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_m4_res.xlsx")
m5_se_res <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_m5_res.xlsx")

#read se CVD
#park ndvi blue space
m1_se_cvd_urb <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_m1_cvd_urb.xlsx")
m2_se_cvd_urb <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_m2_cvd_urb.xlsx")
m3_se_cvd_urb <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_m3_cvd_urb.xlsx")
m4_se_cvd_urb <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_m4_cvd_urb.xlsx")
m5_se_cvd_urb <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_m5_cvd_urb.xlsx")

#read se RES
#park ndvi blue space
m1_se_res_urb <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_m1_res_urb.xlsx")
m2_se_res_urb <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_m2_res_urb.xlsx")
m3_se_res_urb <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_m3_res_urb.xlsx")
m4_se_res_urb <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_m4_res_urb.xlsx")
m5_se_res_urb <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_m5_res_urb.xlsx")

#bind full population
se<-rbind(m1_se_cvd,m2_se_cvd,m3_se_cvd,m4_se_cvd,m5_se_cvd,
          m1_se_res,m2_se_res,m3_se_res,m4_se_res,m5_se_res)
se$pop<-c("full")

#bind full population
se_urb<-rbind(m1_se_cvd_urb,m2_se_cvd_urb,m3_se_cvd_urb,m4_se_cvd_urb,m5_se_cvd_urb,
              m1_se_res_urb,m2_se_res_urb,m3_se_res_urb,m4_se_res_urb,m5_se_res_urb)
se_urb$pop<-c("urban")

se<-rbind(se,se_urb)

rm(list=setdiff(ls(), c("models", "se")))

#join models and iqr
models<-left_join(models,se,by=c("model","out","exposure","pop"))

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

write.csv(models, file="/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/tables/HR_confounder_region_models_cvd_res.csv")

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
cvd.park.full$nr<-c(1:5)
cvd.park.urban$nr<-c(1:5)
cvd.ndvi.full$nr<-c(1:5)
cvd.ndvi.urban$nr<-c(1:5)
cvd.blue.full$nr<-c(1:5)
cvd.blue.urban$nr<-c(1:5)

res.park.full$nr<-c(1:5)
res.park.urban$nr<-c(1:5)
res.ndvi.full$nr<-c(1:5)
res.ndvi.urban$nr<-c(1:5)
res.blue.full$nr<-c(1:5)
res.blue.urban$nr<-c(1:5)

pdf(file="/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/figures/green_confounders_region_cvd_res.pdf", width=8.3, height = 11.7, useDingbats = F)
par(mar = c(4.5, 4, 1, 2),oma=c(6,5,5,5), mfrow=c(4,3))

plot(cvd.park.full$nr, cvd.park.full$beta_exp, ylim=c(0.91,1.12), xaxt = 'n', ylab="HR", xlab="", main="",pch =19)
axis(1, at=c(1:5), labels = c("M1","M2","M3","M4","M5"), font=0.5, las=3)
arrows(cvd.park.full$nr, cvd.park.full$Lower_exp, cvd.park.full$nr, cvd.park.full$Upper_exp, angle=90, length=0)
abline(h=1, lty=2)

plot(cvd.ndvi.full$nr, cvd.ndvi.full$beta_exp, ylim=c(0.91,1.12), xaxt = 'n', ylab="", xlab="", main="",pch =19)
axis(1, at=c(1:5), labels = c("M1","M2","M3","M4","M5"), font=0.5, las=3)
arrows(cvd.ndvi.full$nr, cvd.ndvi.full$Lower_exp, cvd.ndvi.full$nr, cvd.ndvi.full$Upper_exp, angle=90, length=0)
abline(h=1, lty=2)

plot(cvd.blue.full$nr, cvd.blue.full$beta_exp, ylim=c(0.91,1.12), xaxt = 'n', ylab="", xlab="", main="",pch =19)
axis(1, at=c(1:5), labels = c("M1","M2","M3","M4","M5"), font=0.5, las=3)
arrows(cvd.blue.full$nr, cvd.blue.full$Lower_exp, cvd.blue.full$nr, cvd.blue.full$Upper_exp, angle=90, length=0)
abline(h=1, lty=2)

plot(cvd.park.urban$nr, cvd.park.urban$beta_exp, ylim=c(0.91,1.12), xaxt = 'n', ylab="HR", xlab="", main="",pch =19)
axis(1, at=c(1:5), labels = c("M1","M2","M3","M4","M5"), font=0.5, las=3)
arrows(cvd.park.urban$nr, cvd.park.urban$Lower_exp, cvd.park.urban$nr, cvd.park.urban$Upper_exp, angle=90, length=0)
abline(h=1, lty=2)

plot(cvd.ndvi.urban$nr, cvd.ndvi.urban$beta_exp, ylim=c(0.91,1.12), xaxt = 'n', ylab="", xlab="", main="",pch =19)
axis(1, at=c(1:5), labels = c("M1","M2","M3","M4","M5"), font=0.5, las=3)
arrows(cvd.ndvi.urban$nr, cvd.ndvi.urban$Lower_exp, cvd.ndvi.urban$nr, cvd.ndvi.urban$Upper_exp, angle=90, length=0)
abline(h=1, lty=2)

plot(cvd.blue.urban$nr, cvd.blue.urban$beta_exp, ylim=c(0.91,1.12), xaxt = 'n', ylab="", xlab="", main="",pch =19)
axis(1, at=c(1:5), labels = c("M1","M2","M3","M4","M5"), font=0.5, las=3)
arrows(cvd.blue.urban$nr, cvd.blue.urban$Lower_exp, cvd.blue.urban$nr, cvd.blue.urban$Upper_exp, angle=90, length=0)
abline(h=1, lty=2)

plot(res.park.full$nr, res.park.full$beta_exp, ylim=c(0.91,1.12), xaxt = 'n', ylab="HR", xlab="", main="",pch =19)
axis(1, at=c(1:5), labels = c("M1","M2","M3","M4","M5"), font=0.5, las=3)
arrows(res.park.full$nr, res.park.full$Lower_exp, res.park.full$nr, res.park.full$Upper_exp, angle=90, length=0)
abline(h=1, lty=2)

plot(res.ndvi.full$nr, res.ndvi.full$beta_exp, ylim=c(0.91,1.12), xaxt = 'n', ylab="", xlab="", main="",pch =19)
axis(1, at=c(1:5), labels = c("M1","M2","M3","M4","M5"), font=0.5, las=3)
arrows(res.ndvi.full$nr, res.ndvi.full$Lower_exp, res.ndvi.full$nr, res.ndvi.full$Upper_exp, angle=90, length=0)
abline(h=1, lty=2)

plot(res.blue.full$nr, res.blue.full$beta_exp, ylim=c(0.91,1.12), xaxt = 'n', ylab="", xlab="", main="",pch =19)
axis(1, at=c(1:5), labels = c("M1","M2","M3","M4","M5"), font=0.5, las=3)
arrows(res.blue.full$nr, res.blue.full$Lower_exp, res.blue.full$nr, res.blue.full$Upper_exp, angle=90, length=0)
abline(h=1, lty=2)

plot(res.park.urban$nr, res.park.urban$beta_exp, ylim=c(0.91,1.12), xaxt = 'n', ylab="HR", xlab="", main="",pch =19)
axis(1, at=c(1:5), labels = c("M1","M2","M3","M4","M5"), font=0.5, las=3)
arrows(res.park.urban$nr, res.park.urban$Lower_exp, res.park.urban$nr, res.park.urban$Upper_exp, angle=90, length=0)
abline(h=1, lty=2)

plot(res.ndvi.urban$nr, res.ndvi.urban$beta_exp, ylim=c(0.91,1.12), xaxt = 'n', ylab="", xlab="", main="",pch =19)
axis(1, at=c(1:5), labels = c("M1","M2","M3","M4","M5"), font=0.5, las=3)
arrows(res.ndvi.urban$nr, res.ndvi.urban$Lower_exp, res.ndvi.urban$nr, res.ndvi.urban$Upper_exp, angle=90, length=0)
abline(h=1, lty=2)

plot(res.blue.urban$nr, res.blue.urban$beta_exp, ylim=c(0.91,1.12), xaxt = 'n', ylab="", xlab="", main="",pch =19)
axis(1, at=c(1:5), labels = c("M1","M2","M3","M4","M5"), font=0.5, las=3)
arrows(res.blue.urban$nr, res.blue.urban$Lower_exp, res.blue.urban$nr, res.blue.urban$Upper_exp, angle=90, length=0)
abline(h=1, lty=2)

dev.off()
