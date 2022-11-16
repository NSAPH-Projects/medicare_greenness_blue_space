library(stringi)
library(stringr)
library(ggplot2)
library(readxl)
library("writexl")
library(dplyr)
library(data.table)

#read ALZ
#park ndvi blue space
m1_ndvi_blue_alz <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/m1_alz.xlsx")
m2_ndvi_blue_alz <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/m2_alz.xlsx")
m3_ndvi_blue_alz <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/m3_alz.xlsx")
m4_ndvi_blue_alz <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/m4_alz.xlsx")
m4_ndvi_blue_alz$AIC<-NULL
m4_ndvi_blue_alz$BIC<-NULL
#m5_ndvi_blue_alz <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/m5_alz.xlsx")
#m5_ndvi_blue_alz$AIC<-NULL
#m5_ndvi_blue_alz$BIC<-NULL

#read urban alz
#ndvi blue space
m1_ndvi_blue_urb_alz <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/m1_alz_urb.xlsx")
m2_ndvi_blue_urb_alz <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/m2_alz_urb.xlsx")
m3_ndvi_blue_urb_alz <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/m3_alz_urb.xlsx")
m4_ndvi_blue_urb_alz <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/m4_alz_urb.xlsx")
m4_ndvi_blue_urb_alz$AIC<-NULL
m4_ndvi_blue_urb_alz$BIC<-NULL
#m5_ndvi_blue_urb_alz <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/m5_alz_urb.xlsx")
#m5_ndvi_blue_urb_alz$AIC<-NULL
#m5_ndvi_blue_urb_alz$BIC<-NULL

#read PAR
#park ndvi blue space
m1_ndvi_blue_par <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/m1_par.xlsx")
m2_ndvi_blue_par <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/m2_par.xlsx")
m3_ndvi_blue_par <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/m3_par.xlsx")
m4_ndvi_blue_par <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/m4_par.xlsx")
m4_ndvi_blue_par$AIC<-NULL
m4_ndvi_blue_par$BIC<-NULL
#m5_ndvi_blue_par <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/m5_par.xlsx")
#m5_ndvi_blue_par$AIC<-NULL
#m5_ndvi_blue_par$BIC<-NULL

#read par
#ndvi blue space
m1_ndvi_blue_urb_par <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/m1_par_urb.xlsx")
m2_ndvi_blue_urb_par <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/m2_par_urb.xlsx")
m3_ndvi_blue_urb_par <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/m3_par_urb.xlsx")
m4_ndvi_blue_urb_par <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/m4_par_urb.xlsx")
m4_ndvi_blue_urb_par$AIC<-NULL
m4_ndvi_blue_urb_par$BIC<-NULL
#m5_ndvi_blue_urb_par <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/m5_par_urb.xlsx")
#m5_ndvi_blue_urb_par$AIC<-NULL
#m5_ndvi_blue_urb_par$BIC<-NULL

#bind full population
models<-rbind(m1_ndvi_blue_alz,m2_ndvi_blue_alz,m3_ndvi_blue_alz,m4_ndvi_blue_alz,
            m1_ndvi_blue_par,m2_ndvi_blue_par,m3_ndvi_blue_par,m4_ndvi_blue_par)
models$pop<-c("full")

#bind full population
models_urb<-rbind(m1_ndvi_blue_urb_alz,m2_ndvi_blue_urb_alz,m3_ndvi_blue_urb_alz,m4_ndvi_blue_urb_alz,
              m1_ndvi_blue_urb_par,m2_ndvi_blue_urb_par,m3_ndvi_blue_urb_par,m4_ndvi_blue_urb_par)
models_urb$pop<-c("urban")

models<-rbind(models,models_urb)

rm(list=setdiff(ls(), c("models")))

#read se ALZ
#park ndvi blue space
m1_se_alz <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_m1_alz.xlsx")
m2_se_alz <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_m2_alz.xlsx")
m3_se_alz <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_m3_alz.xlsx")
m4_se_alz <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_m4_alz.xlsx")
#m5_se_alz <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_m5_alz.xlsx")

#read se PAR
#park ndvi blue space
m1_se_par <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_m1_par.xlsx")
m2_se_par <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_m2_par.xlsx")
m3_se_par <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_m3_par.xlsx")
m4_se_par <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_m4_par.xlsx")
#m5_se_par <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_m5_par.xlsx")

#read se ALZ
#park ndvi blue space
m1_se_alz_urb <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_m1_alz_urb.xlsx")
m2_se_alz_urb <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_m2_alz_urb.xlsx")
m3_se_alz_urb <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_m3_alz_urb.xlsx")
m4_se_alz_urb <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_m4_alz_urb.xlsx")
#m5_se_alz_urb <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_m5_alz_urb.xlsx")

#read se PAR
#park ndvi blue space
m1_se_par_urb <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_m1_par_urb.xlsx")
m2_se_par_urb <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_m2_par_urb.xlsx")
m3_se_par_urb <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_m3_par_urb.xlsx")
m4_se_par_urb <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_m4_par_urb.xlsx")
#m5_se_par_urb <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_m5_par_urb.xlsx")

#bind full population
se<-rbind(m1_se_alz,m2_se_alz,m3_se_alz,m4_se_alz,
          m1_se_par,m2_se_par,m3_se_par,m4_se_par)
se$pop<-c("full")

#bind full population
se_urb<-rbind(m1_se_alz_urb,m2_se_alz_urb,m3_se_alz_urb,m4_se_alz_urb,
              m1_se_par_urb,m2_se_par_urb,m3_se_par_urb,m4_se_par_urb)
se_urb$pop<-c("urban")

se<-rbind(se,se_urb)

rm(list=setdiff(ls(), c("models", "se")))

#join models and iqr
models<-left_join(models,se,by=c("model","out","exposure","pop"))

#import iqr
descr_exposures_strata_alz <- read_excel("shared_space/ci3_analysis/nature_medicare/Modeloutput/descriptives/descr_exposures_strata_alz.xlsx")
iqr_exp<-descr_exposures_strata_alz[,c("pol","iqr")]
iqr_exp<-iqr_exp[iqr_exp$pol=="ndvi_summer"|iqr_exp$pol=="park",]
setnames(iqr_exp,"pol","exposure")
blue<-cbind("as.factor(occur_bs_1000m_bin)1","1")
colnames(blue)<-c("exposure","iqr")
iqr_exp<-rbind(iqr_exp,blue)

#join models and iqr
models<-left_join(models,iqr_exp,by="exposure")
models$iqr<-as.numeric(models$iqr)

#calculate effect estimates per IQR increase
models$Lower<-models$Beta-qnorm(1-0.05/2)*models$se
models$Upper<-models$Beta+qnorm(1-0.05/2)*models$se
models$beta_exp<-exp(models$iqr*models$Beta)
models$Lower_exp<-exp(models$iqr*models$Lower)
models$Upper_exp<-exp(models$iqr*models$Upper)

#concatenate columns
models$beta_ci<-paste0(round(models$beta_exp,2)," (",round(models$Lower_exp,2),", ",round(models$Upper_exp,2),")")

write.csv(models, file="/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/tables/HR_confounder_region_models_alz_par.csv")

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
alz.park.full$nr<-c(1:4)
alz.park.urban$nr<-c(1:4)
alz.ndvi.full$nr<-c(1:4)
alz.ndvi.urban$nr<-c(1:4)
alz.blue.full$nr<-c(1:4)
alz.blue.urban$nr<-c(1:4)

par.park.full$nr<-c(1:4)
par.park.urban$nr<-c(1:4)
par.ndvi.full$nr<-c(1:4)
par.ndvi.urban$nr<-c(1:4)
par.blue.full$nr<-c(1:4)
par.blue.urban$nr<-c(1:4)

pdf(file="/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/figures/green_confounders_region_alz_par.pdf", width=8.3, height = 11.7, useDingbats = F)
par(mar = c(4.5, 4, 1, 2),oma=c(6,5,5,5), mfrow=c(4,3))

plot(alz.ndvi.full$nr, alz.ndvi.full$beta_exp, ylim=c(0.90,1.06), xaxt = 'n', ylab="", xlab="", main="",pch =19)
axis(1, at=c(1:4), labels = c("M1","M2","M3","M4"), font=0.5, las=3)
arrows(alz.ndvi.full$nr, alz.ndvi.full$Lower_exp, alz.ndvi.full$nr, alz.ndvi.full$Upper_exp, angle=90, length=0)
abline(h=1, lty=2)

plot(alz.park.full$nr, alz.park.full$beta_exp, ylim=c(0.90,1.06), xaxt = 'n', ylab="HR", xlab="", main="",pch =19)
axis(1, at=c(1:4), labels = c("M1","M2","M3","M4"), font=0.5, las=3)
arrows(alz.park.full$nr, alz.park.full$Lower_exp, alz.park.full$nr, alz.park.full$Upper_exp, angle=90, length=0)
abline(h=1, lty=2)

plot(alz.blue.full$nr, alz.blue.full$beta_exp, ylim=c(0.90,1.06), xaxt = 'n', ylab="", xlab="", main="",pch =19)
axis(1, at=c(1:4), labels = c("M1","M2","M3","M4"), font=0.5, las=3)
arrows(alz.blue.full$nr, alz.blue.full$Lower_exp, alz.blue.full$nr, alz.blue.full$Upper_exp, angle=90, length=0)
abline(h=1, lty=2)

plot(alz.ndvi.urban$nr, alz.ndvi.urban$beta_exp, ylim=c(0.90,1.06), xaxt = 'n', ylab="", xlab="", main="",pch =19)
axis(1, at=c(1:4), labels = c("M1","M2","M3","M4"), font=0.5, las=3)
arrows(alz.ndvi.urban$nr, alz.ndvi.urban$Lower_exp, alz.ndvi.urban$nr, alz.ndvi.urban$Upper_exp, angle=90, length=0)
abline(h=1, lty=2)

plot(alz.park.urban$nr, alz.park.urban$beta_exp, ylim=c(0.90,1.06), xaxt = 'n', ylab="HR", xlab="", main="",pch =19)
axis(1, at=c(1:4), labels = c("M1","M2","M3","M4"), font=0.5, las=3)
arrows(alz.park.urban$nr, alz.park.urban$Lower_exp, alz.park.urban$nr, alz.park.urban$Upper_exp, angle=90, length=0)
abline(h=1, lty=2)

plot(alz.blue.urban$nr, alz.blue.urban$beta_exp, ylim=c(0.90,1.06), xaxt = 'n', ylab="", xlab="", main="",pch =19)
axis(1, at=c(1:4), labels = c("M1","M2","M3","M4"), font=0.5, las=3)
arrows(alz.blue.urban$nr, alz.blue.urban$Lower_exp, alz.blue.urban$nr, alz.blue.urban$Upper_exp, angle=90, length=0)
abline(h=1, lty=2)

plot(par.ndvi.full$nr, par.ndvi.full$beta_exp, ylim=c(0.90,1.06), xaxt = 'n', ylab="", xlab="", main="",pch =19)
axis(1, at=c(1:4), labels = c("M1","M2","M3","M4"), font=0.5, las=3)
arrows(par.ndvi.full$nr, par.ndvi.full$Lower_exp, par.ndvi.full$nr, par.ndvi.full$Upper_exp, angle=90, length=0)
abline(h=1, lty=2)

plot(par.park.full$nr, par.park.full$beta_exp, ylim=c(0.90,1.06), xaxt = 'n', ylab="HR", xlab="", main="",pch =19)
axis(1, at=c(1:4), labels = c("M1","M2","M3","M4"), font=0.5, las=3)
arrows(par.park.full$nr, par.park.full$Lower_exp, par.park.full$nr, par.park.full$Upper_exp, angle=90, length=0)
abline(h=1, lty=2)

plot(par.blue.full$nr, par.blue.full$beta_exp, ylim=c(0.90,1.06), xaxt = 'n', ylab="", xlab="", main="",pch =19)
axis(1, at=c(1:4), labels = c("M1","M2","M3","M4"), font=0.5, las=3)
arrows(par.blue.full$nr, par.blue.full$Lower_exp, par.blue.full$nr, par.blue.full$Upper_exp, angle=90, length=0)
abline(h=1, lty=2)

plot(par.ndvi.urban$nr, par.ndvi.urban$beta_exp, ylim=c(0.90,1.06), xaxt = 'n', ylab="", xlab="", main="",pch =19)
axis(1, at=c(1:4), labels = c("M1","M2","M3","M4"), font=0.5, las=3)
arrows(par.ndvi.urban$nr, par.ndvi.urban$Lower_exp, par.ndvi.urban$nr, par.ndvi.urban$Upper_exp, angle=90, length=0)
abline(h=1, lty=2)

plot(par.park.urban$nr, par.park.urban$beta_exp, ylim=c(0.90,1.06), xaxt = 'n', ylab="HR", xlab="", main="",pch =19)
axis(1, at=c(1:4), labels = c("M1","M2","M3","M4"), font=0.5, las=3)
arrows(par.park.urban$nr, par.park.urban$Lower_exp, par.park.urban$nr, par.park.urban$Upper_exp, angle=90, length=0)
abline(h=1, lty=2)

plot(par.blue.urban$nr, par.blue.urban$beta_exp, ylim=c(0.90,1.06), xaxt = 'n', ylab="", xlab="", main="",pch =19)
axis(1, at=c(1:4), labels = c("M1","M2","M3","M4"), font=0.5, las=3)
arrows(par.blue.urban$nr, par.blue.urban$Lower_exp, par.blue.urban$nr, par.blue.urban$Upper_exp, angle=90, length=0)
abline(h=1, lty=2)

dev.off()
