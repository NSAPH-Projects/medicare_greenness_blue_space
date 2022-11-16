library(stringi)
library(stringr)
library(ggplot2)
library(readxl)
library("writexl")
library(dplyr)
library(data.table)

#read CVD
inc1.cvd <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/medhouseholdincome1_cvd.xlsx")
inc2.cvd <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/medhouseholdincome2_cvd.xlsx")
inc3.cvd <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/medhouseholdincome3_cvd.xlsx")
val1.cvd <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/medianhousevalue1_cvd.xlsx")
val2.cvd <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/medianhousevalue2_cvd.xlsx")
val3.cvd <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/medianhousevalue3_cvd.xlsx")
pov1.cvd <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/poverty1_cvd.xlsx")
pov2.cvd <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/poverty2_cvd.xlsx")
pov3.cvd <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/poverty3_cvd.xlsx")

#read urban CVD
inc1.cvd.urb <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/medhouseholdincome1_cvd_urb.xlsx")
inc2.cvd.urb <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/medhouseholdincome2_cvd_urb.xlsx")
inc3.cvd.urb <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/medhouseholdincome3_cvd_urb.xlsx")
val1.cvd.urb <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/medianhousevalue1_cvd_urb.xlsx")
val2.cvd.urb <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/medianhousevalue2_cvd_urb.xlsx")
val3.cvd.urb <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/medianhousevalue3_cvd_urb.xlsx")
pov1.cvd.urb <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/poverty1_cvd_urb.xlsx")
pov2.cvd.urb <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/poverty2_cvd_urb.xlsx")
pov3.cvd.urb <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/poverty3_cvd_urb.xlsx")

#read RES
inc1.res <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/medhouseholdincome1_res.xlsx")
inc2.res <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/medhouseholdincome2_res.xlsx")
inc3.res <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/medhouseholdincome3_res.xlsx")
val1.res <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/medianhousevalue1_res.xlsx")
val2.res <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/medianhousevalue2_res.xlsx")
val3.res <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/medianhousevalue3_res.xlsx")
pov1.res <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/poverty1_res.xlsx")
pov2.res <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/poverty2_res.xlsx")
pov3.res <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/poverty3_res.xlsx")

#read urban RES
inc1.res.urb <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/medhouseholdincome1_res_urb.xlsx")
inc2.res.urb <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/medhouseholdincome2_res_urb.xlsx")
inc3.res.urb <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/medhouseholdincome3_res_urb.xlsx")
val1.res.urb <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/medianhousevalue1_res_urb.xlsx")
val2.res.urb <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/medianhousevalue2_res_urb.xlsx")
val3.res.urb <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/medianhousevalue3_res_urb.xlsx")
pov1.res.urb <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/poverty1_res_urb.xlsx")
pov2.res.urb <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/poverty2_res_urb.xlsx")
pov3.res.urb <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/poverty3_res_urb.xlsx")

#bind full population
models<-rbind(inc1.cvd,inc2.cvd,inc3.cvd,inc1.res,inc2.res,inc3.res,
              val1.cvd,val2.cvd,val3.cvd,val1.res,val2.res,val3.res,
              pov1.cvd,pov2.cvd,pov3.cvd,pov1.res,pov2.res,pov3.res)
models$pop<-c("full")

#bind full population
models_urb<-rbind(inc1.cvd.urb,inc2.cvd.urb,inc3.cvd.urb,inc1.res.urb,inc2.res.urb,inc3.res.urb,
                  val1.cvd.urb,val2.cvd.urb,val3.cvd.urb,val1.res.urb,val2.res.urb,val3.res.urb,
                  pov1.cvd.urb,pov2.cvd.urb,pov3.cvd.urb,pov1.res.urb,pov2.res.urb,pov3.res.urb)
models_urb$pop<-c("urban")

models<-rbind(models,models_urb)

rm(list=setdiff(ls(), c("models")))

#read se CVD
inc1_se_cvd <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_medhouseholdincome_q1_cvd.xlsx")
inc2_se_cvd <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_medhouseholdincome_q2_cvd.xlsx")
inc3_se_cvd <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_medhouseholdincome_q3_cvd.xlsx")
val1_se_cvd <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_medianhousevalue_q1_cvd.xlsx")
val2_se_cvd <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_medianhousevalue_q2_cvd.xlsx")
val3_se_cvd <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_medianhousevalue_q3_cvd.xlsx")
pov1_se_cvd <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_poverty_q1_cvd.xlsx")
pov2_se_cvd <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_poverty_q2_cvd.xlsx")
pov3_se_cvd <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_poverty_q3_cvd.xlsx")

#read urban se CVD
inc1_se_cvd.urb <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_medhouseholdincome_q1_cvd_urb.xlsx")
inc2_se_cvd.urb <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_medhouseholdincome_q2_cvd_urb.xlsx")
inc3_se_cvd.urb <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_medhouseholdincome_q3_cvd_urb.xlsx")
val1_se_cvd.urb <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_medianhousevalue_q1_cvd_urb.xlsx")
val2_se_cvd.urb <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_medianhousevalue_q2_cvd_urb.xlsx")
val3_se_cvd.urb <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_medianhousevalue_q3_cvd_urb.xlsx")
pov1_se_cvd.urb <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_poverty_q1_cvd_urb.xlsx")
pov2_se_cvd.urb <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_poverty_q2_cvd_urb.xlsx")
pov3_se_cvd.urb <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_poverty_q3_cvd_urb.xlsx")

#read se RES
inc1_se_res <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_medhouseholdincome_q1_res.xlsx")
inc2_se_res <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_medhouseholdincome_q2_res.xlsx")
inc3_se_res <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_medhouseholdincome_q3_res.xlsx")
val1_se_res <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_medianhousevalue_q1_res.xlsx")
val2_se_res <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_medianhousevalue_q2_res.xlsx")
val3_se_res <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_medianhousevalue_q3_res.xlsx")
pov1_se_res <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_poverty_q1_res.xlsx")
pov2_se_res <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_poverty_q2_res.xlsx")
pov3_se_res <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_poverty_q3_res.xlsx")

#read se RES
inc1_se_res.urb <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_medhouseholdincome_q1_res_urb.xlsx")
inc2_se_res.urb <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_medhouseholdincome_q2_res_urb.xlsx")
inc3_se_res.urb <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_medhouseholdincome_q3_res_urb.xlsx")
val1_se_res.urb <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_medianhousevalue_q1_res_urb.xlsx")
val2_se_res.urb <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_medianhousevalue_q2_res_urb.xlsx")
val3_se_res.urb <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_medianhousevalue_q3_res_urb.xlsx")
pov1_se_res.urb <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_poverty_q1_res_urb.xlsx")
pov2_se_res.urb <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_poverty_q2_res_urb.xlsx")
pov3_se_res.urb <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_poverty_q3_res_urb.xlsx")

#bind full population
se<-rbind(inc1_se_cvd,inc2_se_cvd,inc3_se_cvd,val1_se_cvd,val2_se_cvd,val3_se_cvd,pov1_se_cvd,pov2_se_cvd,pov3_se_cvd,
          inc1_se_res,inc2_se_res,inc3_se_res,val1_se_res,val2_se_res,val3_se_res,pov1_se_res,pov2_se_res,pov3_se_res)
se$pop<-c("full")

#bind full population
se_urb<-rbind(inc1_se_cvd.urb,inc2_se_cvd.urb,inc3_se_cvd.urb,val1_se_cvd.urb,val2_se_cvd.urb,val3_se_cvd.urb,pov1_se_cvd.urb,pov2_se_cvd.urb,pov3_se_cvd.urb,
              inc1_se_res.urb,inc2_se_res.urb,inc3_se_res.urb,val1_se_res.urb,val2_se_res.urb,val3_se_res.urb,pov1_se_res.urb,pov2_se_res.urb,pov3_se_res.urb)
se_urb$pop<-c("urban")

se<-rbind(se,se_urb)

rm(list=setdiff(ls(), c("models", "se")))

models$X<-NULL
se$X<-NULL
setnames(se,"quintile","strata")
#join models and iqr
models<-left_join(models,se,by=c("model","out","exposure","strata","pop"))

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

main<-main[,c("Beta","model","out","strata","exposure","pop","se")]
#merge main with strata
models<-rbind(main,models)

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

write.csv(models, file="/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/tables/HR_ses_strata_region_models_cvd_res.csv")

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
cvd.park.full$nr<-c(1,3:5,7:9,13:11)
cvd.park.urban$nr<-c(1,3:5,7:9,13:11)
cvd.ndvi.full$nr<-c(1,3:5,7:9,13:11)
cvd.ndvi.urban$nr<-c(1,3:5,7:9,13:11)
cvd.blue.full$nr<-c(1,3:5,7:9,13:11)
cvd.blue.urban$nr<-c(1,3:5,7:9,13:11)

res.park.full$nr<-c(1,3:5,7:9,13:11)
res.park.urban$nr<-c(1,3:5,7:9,13:11)
res.ndvi.full$nr<-c(1,3:5,7:9,13:11)
res.ndvi.urban$nr<-c(1,3:5,7:9,13:11)
res.blue.full$nr<-c(1,3:5,7:9,13:11)
res.blue.urban$nr<-c(1,3:5,7:9,13:11)

pdf(file="/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/figures/green_ses_strata_region_cvd_res_full.pdf", width=8.3, height = 11.7, useDingbats = F)
par(mar = c(4.5, 3.5, 1, 1),oma=c(6,5,5,5), mfrow=c(4,3))

plot(cvd.park.full$nr, cvd.park.full$beta_exp, ylim=c(0.94,1.10), xaxt = 'n', ylab="HR", xlab="", main="",pch =19)
axis(1, at=c(1:13), labels = c("main","","low","mid","high","","low","mid","high","","high","mid","low"), font=0.5, las=3)
arrows(cvd.park.full$nr, cvd.park.full$Lower_exp, cvd.park.full$nr, cvd.park.full$Upper_exp, angle=90, length=0)
abline(h=1, lty=2)
par(xpd=T)
abline(v=c(2,6,10,13.8),lty=1,lwd=14,col="white")

par(xpd=F)
plot(cvd.ndvi.full$nr, cvd.ndvi.full$beta_exp, ylim=c(0.94,1.10), xaxt = 'n', ylab="", xlab="", main="",pch =19)
axis(1, at=c(1:13), labels = c("main","","low","mid","high","","low","mid","high","","high","mid","low"), font=0.5, las=3)
arrows(cvd.ndvi.full$nr, cvd.ndvi.full$Lower_exp, cvd.ndvi.full$nr, cvd.ndvi.full$Upper_exp, angle=90, length=0)
abline(h=1, lty=2)
par(xpd=T)
abline(v=c(2,6,10,13.8),lty=1,lwd=14,col="white")

par(xpd=F)
plot(cvd.blue.full$nr, cvd.blue.full$beta_exp, ylim=c(0.94,1.10), xaxt = 'n', ylab="", xlab="", main="",pch =19)
axis(1, at=c(1:13), labels = c("main","","low","mid","high","","low","mid","high","","high","mid","low"), font=0.5, las=3)
arrows(cvd.blue.full$nr, cvd.blue.full$Lower_exp, cvd.blue.full$nr, cvd.blue.full$Upper_exp, angle=90, length=0)
abline(h=1, lty=2)
par(xpd=T)
abline(v=c(2,6,10,13.8),lty=1,lwd=14,col="white")

par(xpd=F)
plot(res.park.full$nr, res.park.full$beta_exp, ylim=c(0.94,1.10), xaxt = 'n', ylab="HR", xlab="", main="",pch =19)
axis(1, at=c(1:13), labels = c("main","","low","mid","high","","low","mid","high","","high","mid","low"), font=0.5, las=3)
arrows(res.park.full$nr, res.park.full$Lower_exp, res.park.full$nr, res.park.full$Upper_exp, angle=90, length=0)
abline(h=1, lty=2)
par(xpd=T)
abline(v=c(2,6,10,13.8),lty=1,lwd=14,col="white")

par(xpd=F)
plot(res.ndvi.full$nr, res.ndvi.full$beta_exp, ylim=c(0.94,1.10), xaxt = 'n', ylab="", xlab="", main="",pch =19)
axis(1, at=c(1:13), labels = c("main","","low","mid","high","","low","mid","high","","high","mid","low"), font=0.5, las=3)
arrows(res.ndvi.full$nr, res.ndvi.full$Lower_exp, res.ndvi.full$nr, res.ndvi.full$Upper_exp, angle=90, length=0)
abline(h=1, lty=2)
par(xpd=T)
abline(v=c(2,6,10,13.8),lty=1,lwd=14,col="white")

par(xpd=F)
plot(res.blue.full$nr, res.blue.full$beta_exp, ylim=c(0.94,1.10), xaxt = 'n', ylab="", xlab="", main="",pch =19)
axis(1, at=c(1:13), labels = c("main","","low","mid","high","","low","mid","high","","high","mid","low"), font=0.5, las=3)
arrows(res.blue.full$nr, res.blue.full$Lower_exp, res.blue.full$nr, res.blue.full$Upper_exp, angle=90, length=0)
abline(h=1, lty=2)
par(xpd=T)
abline(v=c(2,6,10,13.8),lty=1,lwd=14,col="white")

dev.off()

pdf(file="/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/figures/green_ses_strata_region_cvd_res_urban.pdf", width=8.3, height = 11.7, useDingbats = F)
par(mar = c(4.5, 3.5, 1, 1),oma=c(6,5,5,5), mfrow=c(4,3))

par(xpd=F)
plot(cvd.park.urban$nr, cvd.park.urban$beta_exp, ylim=c(0.94,1.10), xaxt = 'n', ylab="HR", xlab="", main="",pch =19)
axis(1, at=c(1:13), labels = c("main","","low","mid","high","","low","mid","high","","high","mid","low"), font=0.5, las=3)
arrows(cvd.park.urban$nr, cvd.park.urban$Lower_exp, cvd.park.urban$nr, cvd.park.urban$Upper_exp, angle=90, length=0)
abline(h=1, lty=2)
par(xpd=T)
abline(v=c(2,6,10,13.8),lty=1,lwd=14,col="white")

par(xpd=F)
plot(cvd.ndvi.urban$nr, cvd.ndvi.urban$beta_exp, ylim=c(0.94,1.10), xaxt = 'n', ylab="", xlab="", main="",pch =19)
axis(1, at=c(1:13), labels = c("main","","low","mid","high","","low","mid","high","","high","mid","low"), font=0.5, las=3)
arrows(cvd.ndvi.urban$nr, cvd.ndvi.urban$Lower_exp, cvd.ndvi.urban$nr, cvd.ndvi.urban$Upper_exp, angle=90, length=0)
abline(h=1, lty=2)
par(xpd=T)
abline(v=c(2,6,10,13.8),lty=1,lwd=14,col="white")

par(xpd=F)
plot(cvd.blue.urban$nr, cvd.blue.urban$beta_exp, ylim=c(0.94,1.10), xaxt = 'n', ylab="", xlab="", main="",pch =19)
axis(1, at=c(1:13), labels = c("main","","low","mid","high","","low","mid","high","","high","mid","low"), font=0.5, las=3)
arrows(cvd.blue.urban$nr, cvd.blue.urban$Lower_exp, cvd.blue.urban$nr, cvd.blue.urban$Upper_exp, angle=90, length=0)
abline(h=1, lty=2)
par(xpd=T)
abline(v=c(2,6,10,13.8),lty=1,lwd=14,col="white")

par(xpd=F)
plot(res.park.urban$nr, res.park.urban$beta_exp, ylim=c(0.94,1.10), xaxt = 'n', ylab="HR", xlab="", main="",pch =19)
axis(1, at=c(1:13), labels = c("main","","low","mid","high","","low","mid","high","","high","mid","low"), font=0.5, las=3)
arrows(res.park.urban$nr, res.park.urban$Lower_exp, res.park.urban$nr, res.park.urban$Upper_exp, angle=90, length=0)
abline(h=1, lty=2)
par(xpd=T)
abline(v=c(2,6,10,13.8),lty=1,lwd=14,col="white")

par(xpd=F)
plot(res.ndvi.urban$nr, res.ndvi.urban$beta_exp, ylim=c(0.94,1.10), xaxt = 'n', ylab="", xlab="", main="",pch =19)
axis(1, at=c(1:13), labels = c("main","","low","mid","high","","low","mid","high","","high","mid","low"), font=0.5, las=3)
arrows(res.ndvi.urban$nr, res.ndvi.urban$Lower_exp, res.ndvi.urban$nr, res.ndvi.urban$Upper_exp, angle=90, length=0)
abline(h=1, lty=2)
par(xpd=T)
abline(v=c(2,6,10,13.8),lty=1,lwd=14,col="white")

par(xpd=F)
plot(res.blue.urban$nr, res.blue.urban$beta_exp, ylim=c(0.94,1.10), xaxt = 'n', ylab="", xlab="", main="",pch =19)
axis(1, at=c(1:13), labels = c("main","","low","mid","high","","low","mid","high","","high","mid","low"), font=0.5, las=3)
arrows(res.blue.urban$nr, res.blue.urban$Lower_exp, res.blue.urban$nr, res.blue.urban$Upper_exp, angle=90, length=0)
abline(h=1, lty=2)
par(xpd=T)
abline(v=c(2,6,10,13.8),lty=1,lwd=14,col="white")

dev.off()
