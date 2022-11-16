library(stringi)
library(stringr)
library(ggplot2)
library(readxl)
library("writexl")
library(dplyr)
library(data.table)

#read CVD
#park ndvi blue space
m1_ndvi_blue_cvd <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/m1_quint_cvd.xlsx")
m2_ndvi_blue_cvd <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/m2_quint_cvd.xlsx")
m3_ndvi_blue_cvd <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/m3_quint_cvd.xlsx")
m4_ndvi_blue_cvd <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/m4_quint_cvd.xlsx")
m4_ndvi_blue_cvd$AIC<-NULL
m4_ndvi_blue_cvd$BIC<-NULL

#read RES
#park ndvi blue space
m1_ndvi_blue_res <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/m1_quint_res.xlsx")
m2_ndvi_blue_res <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/m2_quint_res.xlsx")
m3_ndvi_blue_res <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/m3_quint_res.xlsx")
m4_ndvi_blue_res <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/m4_quint_res.xlsx")
m4_ndvi_blue_res$AIC<-NULL
m4_ndvi_blue_res$BIC<-NULL

#bind full population
full<-rbind(m1_ndvi_blue_cvd,m2_ndvi_blue_cvd,m3_ndvi_blue_cvd,m4_ndvi_blue_cvd,
           m1_ndvi_blue_res,m2_ndvi_blue_res,m3_ndvi_blue_res,m4_ndvi_blue_res)

full$strata<-c("full")

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

#bind full population
urb<-rbind(m1_ndvi_blue_cvd,m2_ndvi_blue_cvd,m3_ndvi_blue_cvd,m4_ndvi_blue_cvd,
            m1_ndvi_blue_res,m2_ndvi_blue_res,m3_ndvi_blue_res,m4_ndvi_blue_res)
urb$strata<-c("urb")

models<-rbind(full,urb)

rm(list=setdiff(ls(), c("models")))

#read se CVD
#park ndvi blue space
m1_se_cvd <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_quintiles_m1_cvd.xlsx")
m2_se_cvd <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_quintiles_m2_cvd.xlsx")
m3_se_cvd <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_quintiles_m3_cvd.xlsx")
m4_se_cvd <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_quintiles_m4_cvd.xlsx")

#read se RES
#park ndvi blue space
m1_se_res <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_quintiles_m1_res.xlsx")
m2_se_res <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_quintiles_m2_res.xlsx")
m3_se_res <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_quintiles_m3_res.xlsx")
m4_se_res <- read.csv("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/SE/se_quintiles_m4_res.xlsx")

#bind full population
se_full<-rbind(m1_se_cvd,m2_se_cvd,m3_se_cvd,m4_se_cvd,
          m1_se_res,m2_se_res,m3_se_res,m4_se_res)

se_full$strata<-c("full")
se_full$X<-NULL

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

#bind full population
se_urb<-rbind(m1_se_cvd,m2_se_cvd,m3_se_cvd,m4_se_cvd,
              m1_se_res,m2_se_res,m3_se_res,m4_se_res)

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

write.csv(models, file="/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/tables/HR_quintiles_confounder_cvd_res_models.csv")

#create full and urban subsets
models$exp<-substring(models$exposure,1,6)
full<-models[models$strata=="full",]
urb<-models[models$strata=="urb",]
  
#create exposure subsets
cvd_park<-full[full$exp=="q_park" & full$out=="cvd",]
cvd_ndvi<-full[full$exp=="q_ndvi" & full$out=="cvd",]
cvd_blue<-full[full$exp=="q_occu" & full$out=="cvd",]
res_park<-full[full$exp=="q_park" & full$out=="res",]
res_ndvi<-full[full$exp=="q_ndvi" & full$out=="res",]
res_blue<-full[full$exp=="q_occu" & full$out=="res",]

cvd_park_urb<-urb[urb$exp=="q_park" & urb$out=="cvd",]
cvd_ndvi_urb<-urb[urb$exp=="q_ndvi" & urb$out=="cvd",]
cvd_blue_urb<-urb[urb$exp=="q_occu" & urb$out=="cvd",]
res_park_urb<-urb[urb$exp=="q_park" & urb$out=="res",]
res_ndvi_urb<-urb[urb$exp=="q_ndvi" & urb$out=="res",]
res_blue_urb<-urb[urb$exp=="q_occu" & urb$out=="res",]

#add nmmrs to plot
cvd_park$nr<-c(2:5,8:11,14:17,20:23)
cvd_ndvi$nr<-c(2:5,8:11,14:17,20:23)
cvd_blue$nr<-c(2:5,8:11,14:17,20:23)
res_park$nr<-c(2:5,8:11,14:17,20:23)
res_ndvi$nr<-c(2:5,8:11,14:17,20:23)
res_blue$nr<-c(2:5,8:11,14:17,20:23)

cvd_park_urb$nr<-c(2:5,8:11,14:17,20:23)
cvd_ndvi_urb$nr<-c(2:5,8:11,14:17,20:23)
cvd_blue_urb$nr<-c(2:5,8:11,14:17,20:23)
res_park_urb$nr<-c(2:5,8:11,14:17,20:23)
res_ndvi_urb$nr<-c(2:5,8:11,14:17,20:23)
res_blue_urb$nr<-c(2:5,8:11,14:17,20:23)

#create pdf
pdf(file="/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/figures/green_cvd_res.pdf", width=8.3, height = 11.7, useDingbats = F)
par(mar = c(4.5, 2.5, 1, 1.5),oma=c(6,3,5,2), mfrow=c(4,3))

par(xpd=F)
plot(cvd_park$nr, cvd_park$beta_exp, xlim=c(0.8,23.2), ylim=c(0.85,1.20), xaxt = 'n', ylab="HR", xlab="", main="", pch =19)
axis(1, at=c(1:5,7:11,13:17,19:23), labels = c("q1","q2","q3","q4","q5","q1","q2","q3","q4","q5","q1","q2","q3","q4","q5","q1","q2","q3","q4","q5"), cex.axis=0.8, font=0.5, las=3)
points(x=c(1,7,13,19),y=c(1,1,1,1), pch =19)
arrows(cvd_park$nr, cvd_park$Lower_exp, cvd_park$nr, cvd_park$Upper_exp,angle=90, length=0)
abline(h=1, lty=2)
par(xpd=T)
abline(v=c(6,12,18,24), lty=1, lwd=10, col="white")

par(xpd=F)
plot(cvd_ndvi$nr, cvd_ndvi$beta_exp, xlim=c(0.8,23.2), ylim=c(0.85,1.20), xaxt = 'n', ylab="HR", xlab="", main="", pch =19)
axis(1, at=c(1:5,7:11,13:17,19:23), labels = c("q1","q2","q3","q4","q5","q1","q2","q3","q4","q5","q1","q2","q3","q4","q5","q1","q2","q3","q4","q5"), cex.axis=0.8, font=0.5, las=3)
points(x=c(1,7,13,19),y=c(1,1,1,1), pch =19)
arrows(cvd_ndvi$nr, cvd_ndvi$Lower_exp, cvd_ndvi$nr, cvd_ndvi$Upper_exp,angle=90, length=0)
abline(h=1, lty=2)
par(xpd=T)
abline(v=c(6,12,18,24), lty=1, lwd=10, col="white")

par(xpd=F)
plot(cvd_blue$nr, cvd_blue$beta_exp, xlim=c(0.8,23.2), ylim=c(0.85,1.20), xaxt = 'n', ylab="HR", xlab="", main="", pch =19)
axis(1, at=c(1:5,7:11,13:17,19:23), labels = c("q1","q2","q3","q4","q5","q1","q2","q3","q4","q5","q1","q2","q3","q4","q5","q1","q2","q3","q4","q5"), cex.axis=0.8, font=0.5, las=3)
points(x=c(1,7,13,19),y=c(1,1,1,1), pch =19)
arrows(cvd_blue$nr, cvd_blue$Lower_exp, cvd_blue$nr, cvd_blue$Upper_exp,angle=90, length=0)
abline(h=1, lty=2)
par(xpd=T)
abline(v=c(6,12,18,24), lty=1, lwd=10, col="white")

par(xpd=F)
plot(cvd_park_urb$nr, cvd_park_urb$beta_exp, xlim=c(0.8,23.2), ylim=c(0.85,1.20), xaxt = 'n', ylab="HR", xlab="", main="", pch =19)
axis(1, at=c(1:5,7:11,13:17,19:23), labels = c("q1","q2","q3","q4","q5","q1","q2","q3","q4","q5","q1","q2","q3","q4","q5","q1","q2","q3","q4","q5"), cex.axis=0.8, font=0.5, las=3)
points(x=c(1,7,13,19),y=c(1,1,1,1), pch =19)
arrows(cvd_park_urb$nr, cvd_park_urb$Lower_exp, cvd_park_urb$nr, cvd_park_urb$Upper_exp,angle=90, length=0)
abline(h=1, lty=2)
par(xpd=T)
abline(v=c(6,12,18,24), lty=1, lwd=10, col="white")

par(xpd=F)
plot(cvd_ndvi_urb$nr, cvd_ndvi_urb$beta_exp, xlim=c(0.8,23.2), ylim=c(0.85,1.20), xaxt = 'n', ylab="HR", xlab="", main="", pch =19)
axis(1, at=c(1:5,7:11,13:17,19:23), labels = c("q1","q2","q3","q4","q5","q1","q2","q3","q4","q5","q1","q2","q3","q4","q5","q1","q2","q3","q4","q5"), cex.axis=0.8, font=0.5, las=3)
points(x=c(1,7,13,19),y=c(1,1,1,1), pch =19)
arrows(cvd_ndvi_urb$nr, cvd_ndvi_urb$Lower_exp, cvd_ndvi_urb$nr, cvd_ndvi_urb$Upper_exp,angle=90, length=0)
abline(h=1, lty=2)
par(xpd=T)
abline(v=c(6,12,18,24), lty=1, lwd=10, col="white")

par(xpd=F)
plot(cvd_blue_urb$nr, cvd_blue_urb$beta_exp, xlim=c(0.8,23.2), ylim=c(0.85,1.20), xaxt = 'n', ylab="HR", xlab="", main="", pch =19)
axis(1, at=c(1:5,7:11,13:17,19:23), labels = c("q1","q2","q3","q4","q5","q1","q2","q3","q4","q5","q1","q2","q3","q4","q5","q1","q2","q3","q4","q5"), cex.axis=0.8, font=0.5, las=3)
points(x=c(1,7,13,19),y=c(1,1,1,1), pch =19)
arrows(cvd_blue_urb$nr, cvd_blue_urb$Lower_exp, cvd_blue_urb$nr, cvd_blue_urb$Upper_exp,angle=90, length=0)
abline(h=1, lty=2)
par(xpd=T)
abline(v=c(6,12,18,24), lty=1, lwd=10, col="white")

par(xpd=F)
plot(res_park$nr, res_park$beta_exp, xlim=c(0.8,23.2), ylim=c(0.85,1.20), xaxt = 'n', ylab="HR", xlab="", main="", pch =19)
axis(1, at=c(1:5,7:11,13:17,19:23), labels = c("q1","q2","q3","q4","q5","q1","q2","q3","q4","q5","q1","q2","q3","q4","q5","q1","q2","q3","q4","q5"), cex.axis=0.8, font=0.5, las=3)
points(x=c(1,7,13,19),y=c(1,1,1,1), pch =19)
arrows(res_park$nr, res_park$Lower_exp, res_park$nr, res_park$Upper_exp,angle=90, length=0)
abline(h=1, lty=2)
par(xpd=T)
abline(v=c(6,12,18,24), lty=1, lwd=10, col="white")

par(xpd=F)
plot(res_ndvi$nr, res_ndvi$beta_exp, xlim=c(0.8,23.2), ylim=c(0.85,1.20), xaxt = 'n', ylab="HR", xlab="", main="", pch =19)
axis(1, at=c(1:5,7:11,13:17,19:23), labels = c("q1","q2","q3","q4","q5","q1","q2","q3","q4","q5","q1","q2","q3","q4","q5","q1","q2","q3","q4","q5"), cex.axis=0.8, font=0.5, las=3)
points(x=c(1,7,13,19),y=c(1,1,1,1), pch =19)
arrows(res_ndvi$nr, res_ndvi$Lower_exp, res_ndvi$nr, res_ndvi$Upper_exp,angle=90, length=0)
abline(h=1, lty=2)
par(xpd=T)
abline(v=c(6,12,18,24), lty=1, lwd=10, col="white")

par(xpd=F)
plot(res_blue$nr, res_blue$beta_exp, xlim=c(0.8,23.2), ylim=c(0.85,1.20), xaxt = 'n', ylab="HR", xlab="", main="", pch =19)
axis(1, at=c(1:5,7:11,13:17,19:23), labels = c("q1","q2","q3","q4","q5","q1","q2","q3","q4","q5","q1","q2","q3","q4","q5","q1","q2","q3","q4","q5"), cex.axis=0.8, font=0.5, las=3)
points(x=c(1,7,13,19),y=c(1,1,1,1), pch =19)
arrows(res_blue$nr, res_blue$Lower_exp, res_blue$nr, res_blue$Upper_exp,angle=90, length=0)
abline(h=1, lty=2)
par(xpd=T)
abline(v=c(6,12,18,24), lty=1, lwd=10, col="white")

par(xpd=F)
plot(res_park_urb$nr, res_park_urb$beta_exp, xlim=c(0.8,23.2), ylim=c(0.85,1.20), xaxt = 'n', ylab="HR", xlab="", main="", pch =19)
axis(1, at=c(1:5,7:11,13:17,19:23), labels = c("q1","q2","q3","q4","q5","q1","q2","q3","q4","q5","q1","q2","q3","q4","q5","q1","q2","q3","q4","q5"), cex.axis=0.8, font=0.5, las=3)
points(x=c(1,7,13,19),y=c(1,1,1,1), pch =19)
arrows(res_park_urb$nr, res_park_urb$Lower_exp, res_park_urb$nr, res_park_urb$Upper_exp,angle=90, length=0)
abline(h=1, lty=2)
par(xpd=T)
abline(v=c(6,12,18,24), lty=1, lwd=10, col="white")

par(xpd=F)
plot(res_ndvi_urb$nr, res_ndvi_urb$beta_exp, xlim=c(0.8,23.2), ylim=c(0.85,1.20), xaxt = 'n', ylab="HR", xlab="", main="", pch =19)
axis(1, at=c(1:5,7:11,13:17,19:23), labels = c("q1","q2","q3","q4","q5","q1","q2","q3","q4","q5","q1","q2","q3","q4","q5","q1","q2","q3","q4","q5"), cex.axis=0.8, font=0.5, las=3)
points(x=c(1,7,13,19),y=c(1,1,1,1), pch =19)
arrows(res_ndvi_urb$nr, res_ndvi_urb$Lower_exp, res_ndvi_urb$nr, res_ndvi_urb$Upper_exp,angle=90, length=0)
abline(h=1, lty=2)
par(xpd=T)
abline(v=c(6,12,18,24), lty=1, lwd=10, col="white")

par(xpd=F)
plot(res_blue_urb$nr, res_blue_urb$beta_exp, xlim=c(0.8,23.2), ylim=c(0.85,1.20), xaxt = 'n', ylab="HR", xlab="", main="", pch =19)
axis(1, at=c(1:5,7:11,13:17,19:23), labels = c("q1","q2","q3","q4","q5","q1","q2","q3","q4","q5","q1","q2","q3","q4","q5","q1","q2","q3","q4","q5"), cex.axis=0.8, font=0.5, las=3)
points(x=c(1,7,13,19),y=c(1,1,1,1), pch =19)
arrows(res_blue_urb$nr, res_blue_urb$Lower_exp, res_blue_urb$nr, res_blue_urb$Upper_exp,angle=90, length=0)
abline(h=1, lty=2)
par(xpd=T)
abline(v=c(6,12,18,24), lty=1, lwd=10, col="white")

dev.off()
