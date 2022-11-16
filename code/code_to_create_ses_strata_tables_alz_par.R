library(stringi)
library(stringr)
library(ggplot2)
library(readxl)
library("writexl")
library(dplyr)
library(data.table)

#read alz
inc1.alz <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/medhouseholdincome1_alz.xlsx")
inc2.alz <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/medhouseholdincome2_alz.xlsx")
inc3.alz <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/medhouseholdincome3_alz.xlsx")
val1.alz <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/medianhousevalue1_alz.xlsx")
val2.alz <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/medianhousevalue2_alz.xlsx")
val3.alz <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/medianhousevalue3_alz.xlsx")
pov1.alz <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/poverty1_alz.xlsx")
pov2.alz <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/poverty2_alz.xlsx")
pov3.alz <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/poverty3_alz.xlsx")

#read urban alz
inc1.alz.urb <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/medhouseholdincome1_alz_urb.xlsx")
inc2.alz.urb <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/medhouseholdincome2_alz_urb.xlsx")
inc3.alz.urb <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/medhouseholdincome3_alz_urb.xlsx")
val1.alz.urb <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/medianhousevalue1_alz_urb.xlsx")
val2.alz.urb <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/medianhousevalue2_alz_urb.xlsx")
val3.alz.urb <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/medianhousevalue3_alz_urb.xlsx")
pov1.alz.urb <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/poverty1_alz_urb.xlsx")
pov2.alz.urb <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/poverty2_alz_urb.xlsx")
pov3.alz.urb <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/poverty3_alz_urb.xlsx")

#read par
inc1.par <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/medhouseholdincome1_par.xlsx")
inc2.par <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/medhouseholdincome2_par.xlsx")
inc3.par <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/medhouseholdincome3_par.xlsx")
val1.par <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/medianhousevalue1_par.xlsx")
val2.par <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/medianhousevalue2_par.xlsx")
val3.par <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/medianhousevalue3_par.xlsx")
pov1.par <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/poverty1_par.xlsx")
pov2.par <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/poverty2_par.xlsx")
pov3.par <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/poverty3_par.xlsx")

#read urban par
inc1.par.urb <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/medhouseholdincome1_par_urb.xlsx")
inc2.par.urb <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/medhouseholdincome2_par_urb.xlsx")
inc3.par.urb <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/medhouseholdincome3_par_urb.xlsx")
val1.par.urb <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/medianhousevalue1_par_urb.xlsx")
val2.par.urb <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/medianhousevalue2_par_urb.xlsx")
val3.par.urb <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/medianhousevalue3_par_urb.xlsx")
pov1.par.urb <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/poverty1_par_urb.xlsx")
pov2.par.urb <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/poverty2_par_urb.xlsx")
pov3.par.urb <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/poverty3_par_urb.xlsx")

#bind full population
models<-rbind(inc1.alz,inc2.alz,inc3.alz,inc1.par,inc2.par,inc3.par,
              val1.alz,val2.alz,val3.alz,val1.par,val2.par,val3.par,
              pov1.alz,pov2.alz,pov3.alz,pov1.par,pov2.par,pov3.par)
models$pop<-c("full")

#bind full population
models_urb<-rbind(inc1.alz.urb,inc2.alz.urb,inc3.alz.urb,inc1.par.urb,inc2.par.urb,inc3.par.urb,
                  val1.alz.urb,val2.alz.urb,val3.alz.urb,val1.par.urb,val2.par.urb,val3.par.urb,
                  pov1.alz.urb,pov2.alz.urb,pov3.alz.urb,pov1.par.urb,pov2.par.urb,pov3.par.urb)
models_urb$pop<-c("urban")

models<-rbind(models,models_urb)

rm(list=setdiff(ls(), c("models")))

#read se alz
inc1_se_alz <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_medhouseholdincome_q1_alz.xlsx")
inc2_se_alz <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_medhouseholdincome_q2_alz.xlsx")
inc3_se_alz <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_medhouseholdincome_q3_alz.xlsx")
val1_se_alz <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_medianhousevalue_q1_alz.xlsx")
val2_se_alz <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_medianhousevalue_q2_alz.xlsx")
val3_se_alz <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_medianhousevalue_q3_alz.xlsx")
pov1_se_alz <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_poverty_q1_alz.xlsx")
pov2_se_alz <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_poverty_q2_alz.xlsx")
pov3_se_alz <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_poverty_q3_alz.xlsx")

#read urban se alz
inc1_se_alz.urb <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_medhouseholdincome_q1_alz_urb.xlsx")
inc2_se_alz.urb <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_medhouseholdincome_q2_alz_urb.xlsx")
inc3_se_alz.urb <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_medhouseholdincome_q3_alz_urb.xlsx")
val1_se_alz.urb <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_medianhousevalue_q1_alz_urb.xlsx")
val2_se_alz.urb <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_medianhousevalue_q2_alz_urb.xlsx")
val3_se_alz.urb <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_medianhousevalue_q3_alz_urb.xlsx")
pov1_se_alz.urb <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_poverty_q1_alz_urb.xlsx")
pov2_se_alz.urb <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_poverty_q2_alz_urb.xlsx")
pov3_se_alz.urb <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_poverty_q3_alz_urb.xlsx")

#read se par
inc1_se_par <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_medhouseholdincome_q1_par.xlsx")
inc2_se_par <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_medhouseholdincome_q2_par.xlsx")
inc3_se_par <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_medhouseholdincome_q3_par.xlsx")
val1_se_par <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_medianhousevalue_q1_par.xlsx")
val2_se_par <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_medianhousevalue_q2_par.xlsx")
val3_se_par <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_medianhousevalue_q3_par.xlsx")
pov1_se_par <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_poverty_q1_par.xlsx")
pov2_se_par <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_poverty_q2_par.xlsx")
pov3_se_par <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_poverty_q3_par.xlsx")

#read se par
inc1_se_par.urb <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_medhouseholdincome_q1_par_urb.xlsx")
inc2_se_par.urb <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_medhouseholdincome_q2_par_urb.xlsx")
inc3_se_par.urb <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_medhouseholdincome_q3_par_urb.xlsx")
val1_se_par.urb <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_medianhousevalue_q1_par_urb.xlsx")
val2_se_par.urb <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_medianhousevalue_q2_par_urb.xlsx")
val3_se_par.urb <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_medianhousevalue_q3_par_urb.xlsx")
pov1_se_par.urb <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_poverty_q1_par_urb.xlsx")
pov2_se_par.urb <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_poverty_q2_par_urb.xlsx")
pov3_se_par.urb <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_poverty_q3_par_urb.xlsx")

#bind full population
se<-rbind(inc1_se_alz,inc2_se_alz,inc3_se_alz,val1_se_alz,val2_se_alz,val3_se_alz,pov1_se_alz,pov2_se_alz,pov3_se_alz,
          inc1_se_par,inc2_se_par,inc3_se_par,val1_se_par,val2_se_par,val3_se_par,pov1_se_par,pov2_se_par,pov3_se_par)
se$pop<-c("full")

#bind full population
se_urb<-rbind(inc1_se_alz.urb,inc2_se_alz.urb,inc3_se_alz.urb,val1_se_alz.urb,val2_se_alz.urb,val3_se_alz.urb,pov1_se_alz.urb,pov2_se_alz.urb,pov3_se_alz.urb,
              inc1_se_par.urb,inc2_se_par.urb,inc3_se_par.urb,val1_se_par.urb,val2_se_par.urb,val3_se_par.urb,pov1_se_par.urb,pov2_se_par.urb,pov3_se_par.urb)
se_urb$pop<-c("urban")

se<-rbind(se,se_urb)

rm(list=setdiff(ls(), c("models", "se")))

models$X<-NULL
se$X<-NULL
setnames(se,"quintile","strata")
#join models and iqr
models<-left_join(models,se,by=c("model","out","exposure","strata","pop"))

#import main models
m4_ndvi_blue_alz <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/m4_alz.xlsx")
m4_ndvi_blue_urb_alz <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/m4_alz_urb.xlsx")
m4_ndvi_blue_par <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/m4_par.xlsx")
m4_ndvi_blue_urb_par <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/m4_par_urb.xlsx")
m4_ndvi_blue_alz$pop<-c("full")
m4_ndvi_blue_par$pop<-c("full")
m4_ndvi_blue_urb_alz$pop<-c("urban")
m4_ndvi_blue_urb_par$pop<-c("urban")
main<-rbind(m4_ndvi_blue_alz,m4_ndvi_blue_par,m4_ndvi_blue_urb_alz,m4_ndvi_blue_urb_par)

m4_se_alz <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_m4_alz.xlsx")
m4_se_par <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_m4_par.xlsx")
m4_se_alz_urb <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_m4_alz_urb.xlsx")
m4_se_par_urb <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_m4_par_urb.xlsx")
m4_se_alz$pop<-c("full")
m4_se_par$pop<-c("full")
m4_se_alz_urb$pop<-c("urban")
m4_se_par_urb$pop<-c("urban")
main.se<-rbind(m4_se_alz,m4_se_par,m4_se_alz_urb,m4_se_par_urb)

#merge main with main.se
main<-left_join(main,main.se,by=c("model","out","exposure","pop"))
main$strata<-c("main")

main<-main[,c("Beta","model","out","strata","exposure","pop","se")]
#merge main with strata
models<-rbind(main,models)

#import iqr
descr_exposupar_strata_alz <- read_excel("shared_space/ci3_analysis/nature_medicare/Modeloutput/descriptives/descr_exposures_strata_alz.xlsx")
iqr_exp<-descr_exposupar_strata_alz[,c("pol","iqr")]
iqr_exp<-iqr_exp[iqr_exp$pol=="ndvi_summer"|iqr_exp$pol=="occur_bs_1000m"|iqr_exp$pol=="park",]
setnames(iqr_exp,"pol","exposure")

#join models and iqr
models<-left_join(models,iqr_exp,by="exposure")
models$iqr<-ifelse(is.na(models$iqr),1,models$iqr)

#calculate effect estimates per IQR increase
models$Lower<-models$Beta-qnorm(1-0.05/2)*models$se
models$Upper<-models$Beta+qnorm(1-0.05/2)*models$se
models$beta_exp<-exp(models$iqr*models$Beta)
models$Lower_exp<-exp(models$iqr*models$Lower)
models$Upper_exp<-exp(models$iqr*models$Upper)

#concatenate columns
models$beta_ci<-paste0(round(models$beta_exp,2)," (",round(models$Lower_exp,2),", ",round(models$Upper_exp,2),")")

write.csv(models, file="/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/tables/HR_ses_strata_region_models_alz_par.csv")

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
alz.park.full$nr<-c(1,3:5,7:9,13:11)
alz.park.urban$nr<-c(1,3:5,7:9,13:11)
alz.ndvi.full$nr<-c(1,3:5,7:9,13:11)
alz.ndvi.urban$nr<-c(1,3:5,7:9,13:11)
alz.blue.full$nr<-c(1,3:5,7:9,13:11)
alz.blue.urban$nr<-c(1,3:5,7:9,13:11)

par.park.full$nr<-c(1,3:5,7:9,13:11)
par.park.urban$nr<-c(1,3:5,7:9,13:11)
par.ndvi.full$nr<-c(1,3:5,7:9,13:11)
par.ndvi.urban$nr<-c(1,3:5,7:9,13:11)
par.blue.full$nr<-c(1,3:5,7:9,13:11)
par.blue.urban$nr<-c(1,3:5,7:9,13:11)

pdf(file="/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/figures/green_ses_strata_region_alz_par_full.pdf", width=8.3, height = 11.7, useDingbats = F)
par(mar = c(4.5, 3.5, 1, 1),oma=c(6,5,5,5), mfrow=c(4,3))

par(xpd=F)
plot(alz.ndvi.full$nr, alz.ndvi.full$beta_exp, ylim=c(0.89,1.05), xaxt = 'n', ylab="", xlab="", main="",pch =19)
axis(1, at=c(1:13), labels = c("main","","low","mid","high","","low","mid","high","","high","mid","low"), font=0.5, las=3)
arrows(alz.ndvi.full$nr, alz.ndvi.full$Lower_exp, alz.ndvi.full$nr, alz.ndvi.full$Upper_exp, angle=90, length=0)
abline(h=1, lty=2)
par(xpd=T)
abline(v=c(2,6,10,13.8),lty=1,lwd=14,col="white")

plot(alz.park.full$nr, alz.park.full$beta_exp, ylim=c(0.89,1.05), xaxt = 'n', ylab="HR", xlab="", main="",pch =19)
axis(1, at=c(1:13), labels = c("main","","low","mid","high","","low","mid","high","","high","mid","low"), font=0.5, las=3)
arrows(alz.park.full$nr, alz.park.full$Lower_exp, alz.park.full$nr, alz.park.full$Upper_exp, angle=90, length=0)
abline(h=1, lty=2)
par(xpd=T)
abline(v=c(2,6,10,13.8),lty=1,lwd=14,col="white")

par(xpd=F)
plot(alz.blue.full$nr, alz.blue.full$beta_exp, ylim=c(0.89,1.05), xaxt = 'n', ylab="", xlab="", main="",pch =19)
axis(1, at=c(1:13), labels = c("main","","low","mid","high","","low","mid","high","","high","mid","low"), font=0.5, las=3)
arrows(alz.blue.full$nr, alz.blue.full$Lower_exp, alz.blue.full$nr, alz.blue.full$Upper_exp, angle=90, length=0)
abline(h=1, lty=2)
par(xpd=T)
abline(v=c(2,6,10,13.8),lty=1,lwd=14,col="white")

par(xpd=F)
plot(par.ndvi.full$nr, par.ndvi.full$beta_exp, ylim=c(0.89,1.05), xaxt = 'n', ylab="", xlab="", main="",pch =19)
axis(1, at=c(1:13), labels = c("main","","low","mid","high","","low","mid","high","","high","mid","low"), font=0.5, las=3)
arrows(par.ndvi.full$nr, par.ndvi.full$Lower_exp, par.ndvi.full$nr, par.ndvi.full$Upper_exp, angle=90, length=0)
abline(h=1, lty=2)
par(xpd=T)
abline(v=c(2,6,10,13.8),lty=1,lwd=14,col="white")

par(xpd=F)
plot(par.park.full$nr, par.park.full$beta_exp, ylim=c(0.89,1.05), xaxt = 'n', ylab="HR", xlab="", main="",pch =19)
axis(1, at=c(1:13), labels = c("main","","low","mid","high","","low","mid","high","","high","mid","low"), font=0.5, las=3)
arrows(par.park.full$nr, par.park.full$Lower_exp, par.park.full$nr, par.park.full$Upper_exp, angle=90, length=0)
abline(h=1, lty=2)
par(xpd=T)
abline(v=c(2,6,10,13.8),lty=1,lwd=14,col="white")

par(xpd=F)
plot(par.blue.full$nr, par.blue.full$beta_exp, ylim=c(0.89,1.05), xaxt = 'n', ylab="", xlab="", main="",pch =19)
axis(1, at=c(1:13), labels = c("main","","low","mid","high","","low","mid","high","","high","mid","low"), font=0.5, las=3)
arrows(par.blue.full$nr, par.blue.full$Lower_exp, par.blue.full$nr, par.blue.full$Upper_exp, angle=90, length=0)
abline(h=1, lty=2)
par(xpd=T)
abline(v=c(2,6,10,13.8),lty=1,lwd=14,col="white")

dev.off()

pdf(file="/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/figures/green_ses_strata_region_alz_par_urban.pdf", width=8.3, height = 11.7, useDingbats = F)
par(mar = c(4.5, 3.5, 1, 1),oma=c(6,5,5,5), mfrow=c(4,3))

par(xpd=F)
plot(alz.ndvi.urban$nr, alz.ndvi.urban$beta_exp, ylim=c(0.89,1.08), xaxt = 'n', ylab="", xlab="", main="",pch =19)
axis(1, at=c(1:13), labels = c("main","","low","mid","high","","low","mid","high","","high","mid","low"), font=0.5, las=3)
arrows(alz.ndvi.urban$nr, alz.ndvi.urban$Lower_exp, alz.ndvi.urban$nr, alz.ndvi.urban$Upper_exp, angle=90, length=0)
abline(h=1, lty=2)
par(xpd=T)
abline(v=c(2,6,10,13.8),lty=1,lwd=14,col="white")

par(xpd=F)
plot(alz.park.urban$nr, alz.park.urban$beta_exp, ylim=c(0.89,1.08), xaxt = 'n', ylab="HR", xlab="", main="",pch =19)
axis(1, at=c(1:13), labels = c("main","","low","mid","high","","low","mid","high","","high","mid","low"), font=0.5, las=3)
arrows(alz.park.urban$nr, alz.park.urban$Lower_exp, alz.park.urban$nr, alz.park.urban$Upper_exp, angle=90, length=0)
abline(h=1, lty=2)
par(xpd=T)
abline(v=c(2,6,10,13.8),lty=1,lwd=14,col="white")

par(xpd=F)
plot(alz.blue.urban$nr, alz.blue.urban$beta_exp, ylim=c(0.89,1.08), xaxt = 'n', ylab="", xlab="", main="",pch =19)
axis(1, at=c(1:13), labels = c("main","","low","mid","high","","low","mid","high","","high","mid","low"), font=0.5, las=3)
arrows(alz.blue.urban$nr, alz.blue.urban$Lower_exp, alz.blue.urban$nr, alz.blue.urban$Upper_exp, angle=90, length=0)
abline(h=1, lty=2)
par(xpd=T)
abline(v=c(2,6,10,13.8),lty=1,lwd=14,col="white")

par(xpd=F)
plot(par.ndvi.urban$nr, par.ndvi.urban$beta_exp, ylim=c(0.89,1.08), xaxt = 'n', ylab="", xlab="", main="",pch =19)
axis(1, at=c(1:13), labels = c("main","","low","mid","high","","low","mid","high","","high","mid","low"), font=0.5, las=3)
arrows(par.ndvi.urban$nr, par.ndvi.urban$Lower_exp, par.ndvi.urban$nr, par.ndvi.urban$Upper_exp, angle=90, length=0)
abline(h=1, lty=2)
par(xpd=T)
abline(v=c(2,6,10,13.8),lty=1,lwd=14,col="white")

par(xpd=F)
plot(par.park.urban$nr, par.park.urban$beta_exp, ylim=c(0.89,1.08), xaxt = 'n', ylab="HR", xlab="", main="",pch =19)
axis(1, at=c(1:13), labels = c("main","","low","mid","high","","low","mid","high","","high","mid","low"), font=0.5, las=3)
arrows(par.park.urban$nr, par.park.urban$Lower_exp, par.park.urban$nr, par.park.urban$Upper_exp, angle=90, length=0)
abline(h=1, lty=2)
par(xpd=T)
abline(v=c(2,6,10,13.8),lty=1,lwd=14,col="white")

par(xpd=F)
plot(par.blue.urban$nr, par.blue.urban$beta_exp, ylim=c(0.89,1.08), xaxt = 'n', ylab="", xlab="", main="",pch =19)
axis(1, at=c(1:13), labels = c("main","","low","mid","high","","low","mid","high","","high","mid","low"), font=0.5, las=3)
arrows(par.blue.urban$nr, par.blue.urban$Lower_exp, par.blue.urban$nr, par.blue.urban$Upper_exp, angle=90, length=0)
abline(h=1, lty=2)
par(xpd=T)
abline(v=c(2,6,10,13.8),lty=1,lwd=14,col="white")

dev.off()
