library("fst")

new_merged <- "/nfs/home/J/jok8845/shared_space/ci3_health_data/medicare/gen_admission/1999_2016/Klompmaker/merged_data/alz2/"
exposures_alz <- read_fst(paste0(new_merged ,"aggregate_ALZ.fst"),
                          columns = c("ndvi_summer","park","popdensity"), as.data.table = T)
exposures_alz_urb<-exposures_alz[popdensity>=1000,]
new_merged <- "/nfs/home/J/jok8845/shared_space/ci3_health_data/medicare/gen_admission/1999_2016/Klompmaker/merged_data/par2/"
exposures_par <- read_fst(paste0(new_merged ,"aggregate_PAR.fst"),
                          columns = c("ndvi_summer","park","popdensity"), as.data.table = T)
exposures_par_urb<-exposures_par[popdensity>=1000,]

#read data 1df 
ndvi_1df_curve_alz <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/ndvi_1df_curve_alz.xlsx")
park_1df_curve_alz <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/park_1df_curve_alz.xlsx")

ndvi_1df_curve_par <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/ndvi_1df_curve_par.xlsx")
park_1df_curve_par <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/park_1df_curve_par.xlsx")

#read data 1df urban
ndvi_1df_curve_alz_urb <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/ndvi_1df_curve_alz_urb.xlsx")
park_1df_curve_alz_urb <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/park_1df_curve_alz_urb.xlsx")

ndvi_1df_curve_par_urb <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/ndvi_1df_curve_par_urb.xlsx")
park_1df_curve_par_urb <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/park_1df_curve_par_urb.xlsx")

#read data 2df
ndvi_2df_curve_alz <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/ndvi_2df_sim_curve_alzm4_reg4.xlsx")
park_2df_curve_alz <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/park_2df_sim_curve_alzm4_reg4.xlsx")

ndvi_2df_curve_par <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/ndvi_2df_sim_curve_parm4_reg4.xlsx")
park_2df_curve_par <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/park_2df_sim_curve_parm4_reg4.xlsx")

#read data 2df urban
ndvi_2df_curve_alz_urb <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/ndvi_2df_sim_curve_alz_urb.xlsx")
park_2df_curve_alz_urb <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/park_2df_sim_curve_alz_urb.xlsx")

ndvi_2df_curve_par_urb <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/ndvi_2df_sim_curve_par_urb.xlsx")
park_2df_curve_par_urb <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/park_2df_sim_curve_par_urb.xlsx")

#read data 3df
ndvi_3df_curve_alz <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/ndvi_3df_sim_curve_alz.xlsx")
park_3df_curve_alz <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/park_3df_sim_curve_alz.xlsx")

ndvi_3df_curve_par <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/ndvi_3df_sim_curve_par.xlsx")
park_3df_curve_par <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/park_3df_sim_curve_par.xlsx")

#read data 3df urban
ndvi_3df_curve_alz_urb <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/ndvi_3df_sim_curve_alz_urb.xlsx")
park_3df_curve_alz_urb <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/park_3df_sim_curve_alz_urb.xlsx")

ndvi_3df_curve_par_urb <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/ndvi_3df_sim_curve_par_urb.xlsx")
park_3df_curve_par_urb <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/park_3df_sim_curve_par_urb.xlsx")

#create pdf
pdf(file="/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/figures/nature_splines23_alz_par.pdf", width=8.3, height = 11.7, useDingbats = F)
par(mar = c(4.5, 3, 1, 2),oma=c(6,4,5,3), mfrow=c(4,2))

#plot NDVI-ALZ
matplot(ndvi_1df_curve_alz$X1,ndvi_1df_curve_alz$X2,type="l",ylim=c(-0.30,0.2),col=c(1,8,8),lty=c(1,2,2),lwd=c(2,2,2),xlab=expression(paste("NDVI")),ylab=paste("HR",sep=""),main=paste("ALZ",sep=""))
lines(ndvi_2df_curve_alz$exp,ndvi_2df_curve_alz$pred, lty=2)
lines(ndvi_3df_curve_alz$exp,ndvi_3df_curve_alz$pred, lty=3)
#lines(pm25_4df_alz$exp,pm25_4df_alz$pred, lty=4)
#legend(0,0.3,legend=c("df=1","df=2","df=3"),lty=1:3,cex=0.7,box.lty=0)
par(new=T)
hist(exposures_alz$ndvi_summer, axes=FALSE,main=NULL, xlab=NULL,ylab=NULL,ylim=c(0,9000000*4),border="grey70")
#lines(density(exposures_alz$ndvi_summer,na.rm=T),col="blue")

#plot Park-ALZ
matplot(park_1df_curve_alz$X1,park_1df_curve_alz$X2,type="l",ylim=c(-0.30,0.2),col=c(1,8,8),lty=c(1,2,2),lwd=c(2,2,2),xlab=expression(paste("Public park")),ylab=paste("HR",sep=""),main=paste("ALZ",sep=""))
lines(park_2df_curve_alz$exp,park_2df_curve_alz$pred, lty=2)
lines(park_3df_curve_alz$exp,park_3df_curve_alz$pred, lty=3)
#lines(pm25_4df_alz$exp,pm25_4df_alz$pred, lty=4)
legend(0,0.2,legend=c("df=1","df=2","df=3"),lty=1:3,cex=0.7,box.lty=0)
par(new=T)
hist(exposures_alz$park, axes=FALSE,main=NULL, xlab=NULL,ylab=NULL,ylim=c(0,9000000*8),border="grey70")

#plot NDVI-ALZ
matplot(ndvi_1df_curve_alz_urb$X1,ndvi_1df_curve_alz_urb$X2,type="l",ylim=c(-0.30,0.2),col=c(1,8,8),lty=c(1,2,2),lwd=c(2,2,2),xlab=expression(paste("NDVI")),ylab=paste("HR",sep=""),main=paste("ALZ",sep=""))
lines(ndvi_2df_curve_alz_urb$exp,ndvi_2df_curve_alz_urb$pred, lty=2)
lines(ndvi_3df_curve_alz_urb$exp,ndvi_3df_curve_alz_urb$pred, lty=3)
#lines(pm25_4df_alz_urb$exp,pm25_4df_alz_urb$pred, lty=4)
#legend(0,0.3,legend=c("df=1","df=2","df=3"),lty=1:3,cex=0.7,box.lty=0)
par(new=T)
hist(exposures_alz_urb$ndvi_summer, axes=FALSE,main=NULL, xlab=NULL,ylab=NULL,ylim=c(0,9000000*2),border="grey70")

#plot Park-ALZ
matplot(park_1df_curve_alz_urb$X1,park_1df_curve_alz_urb$X2,type="l",ylim=c(-0.30,0.2),col=c(1,8,8),lty=c(1,2,2),lwd=c(2,2,2),xlab=expression(paste("Public park")),ylab=paste("HR",sep=""),main=paste("ALZ",sep=""))
lines(park_2df_curve_alz_urb$exp,park_2df_curve_alz_urb$pred, lty=2)
lines(park_3df_curve_alz_urb$exp,park_3df_curve_alz_urb$pred, lty=3)
#lines(pm25_4df_alz_urb$exp,pm25_4df_alz_urb$pred, lty=4)
#legend(0,0.2,legend=c("df=1","df=2","df=3"),lty=1:3,cex=0.7,box.lty=0)
par(new=T)
hist(exposures_alz_urb$park, axes=FALSE,main=NULL, xlab=NULL,ylab=NULL,ylim=c(0,9000000*4),border="grey70")

#plot NDVI-PAR
matplot(ndvi_1df_curve_par$X1,ndvi_1df_curve_par$X2,type="l",ylim=c(-0.30,0.2),col=c(1,8,8),lty=c(1,2,2),lwd=c(2,2,2),xlab=expression(paste("NDVI")),ylab=paste("HR",sep=""),main=paste("PAR",sep=""))
lines(ndvi_2df_curve_par$exp,ndvi_2df_curve_par$pred, lty=2)
lines(ndvi_3df_curve_par$exp,ndvi_3df_curve_par$pred, lty=3)
#lines(pm25_4df_par$exp,pm25_4df_par$pred, lty=4)
#legend(0,0.3,legend=c("df=1","df=2","df=3"),lty=1:3,cex=0.7,box.lty=0)
par(new=T)
hist(exposures_par$ndvi_summer, axes=FALSE,main=NULL, xlab=NULL,ylab=NULL,ylim=c(0,9000000*4),border="grey70")

#plot Park-PAR
matplot(park_1df_curve_par$X1,park_1df_curve_par$X2,type="l",ylim=c(-0.30,0.2),col=c(1,8,8),lty=c(1,2,2),lwd=c(2,2,2),xlab=expression(paste("Public park")),ylab=paste("HR",sep=""),main=paste("PAR",sep=""))
lines(park_2df_curve_par$exp,park_2df_curve_par$pred, lty=2)
lines(park_3df_curve_par$exp,park_3df_curve_par$pred, lty=3)
#lines(pm25_4df_par$exp,pm25_4df_par$pred, lty=4)
legend(0,0.2,legend=c("df=1","df=2","df=3"),lty=1:3,cex=0.7,box.lty=0)
par(new=T)
hist(exposures_par$park, axes=FALSE,main=NULL, xlab=NULL,ylab=NULL,ylim=c(0,9000000*8),border="grey70")

#plot NDVI-PAR
matplot(ndvi_1df_curve_par_urb$X1,ndvi_1df_curve_par_urb$X2,type="l",ylim=c(-0.30,0.2),col=c(1,8,8),lty=c(1,2,2),lwd=c(2,2,2),xlab=expression(paste("NDVI")),ylab=paste("HR",sep=""),main=paste("PAR",sep=""))
lines(ndvi_2df_curve_par_urb$exp,ndvi_2df_curve_par_urb$pred, lty=2)
lines(ndvi_3df_curve_par_urb$exp,ndvi_3df_curve_par_urb$pred, lty=3)
#lines(pm25_4df_par_urb$exp,pm25_4df_par_urb$pred, lty=4)
#legend(0,0.3,legend=c("df=1","df=2","df=3"),lty=1:3,cex=0.7,box.lty=0)
par(new=T)
hist(exposures_par_urb$ndvi_summer, axes=FALSE,main=NULL, xlab=NULL,ylab=NULL,ylim=c(0,9000000*2),border="grey70")

#plot Park-PAR
matplot(park_1df_curve_par_urb$X1,park_1df_curve_par_urb$X2,type="l",ylim=c(-0.30,0.2),col=c(1,8,8),lty=c(1,2,2),lwd=c(2,2,2),xlab=expression(paste("Public park")),ylab=paste("HR",sep=""),main=paste("PAR",sep=""))
lines(park_2df_curve_par_urb$exp,park_2df_curve_par_urb$pred, lty=2)
lines(park_3df_curve_par_urb$exp,park_3df_curve_par_urb$pred, lty=3)
#lines(pm25_4df_par_urb$exp,pm25_4df_par_urb$pred, lty=4)
#legend(0,0.2,legend=c("df=1","df=2","df=3"),lty=1:3,cex=0.7,box.lty=0)
par(new=T)
hist(exposures_par_urb$park, axes=FALSE,main=NULL, xlab=NULL,ylab=NULL,ylim=c(0,9000000*4),border="grey70")


dev.off()
