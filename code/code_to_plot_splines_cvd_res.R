library("fst")

new_merged <- "/nfs/home/J/jok8845/shared_space/ci3_health_data/medicare/gen_admission/1999_2016/Klompmaker/merged_data/cvd2/"
exposures_cvd <- read_fst(paste0(new_merged ,"aggregate_CVD.fst"),
                          columns = c("ndvi_summer","occur_bs_1000m","park","popdensity"), as.data.table = T)
exposures_cvd_urb<-exposures_cvd[popdensity>=1000,]
new_merged <- "/nfs/home/J/jok8845/shared_space/ci3_health_data/medicare/gen_admission/1999_2016/Klompmaker/merged_data/res2/"
exposures_res <- read_fst(paste0(new_merged ,"aggregate_RES.fst"),
                          columns = c("ndvi_summer","occur_bs_1000m","park","popdensity"), as.data.table = T)
exposures_res_urb<-exposures_res[popdensity>=1000,]

#read data 1df 
ndvi_1df_curve_cvd <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/ndvi_1df_curve_cvd.xlsx")
blue_1df_curve_cvd <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/blue_1df_curve_cvd.xlsx")
park_1df_curve_cvd <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/park_1df_curve_cvd.xlsx")

ndvi_1df_curve_res <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/ndvi_1df_curve_res.xlsx")
blue_1df_curve_res <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/blue_1df_curve_res.xlsx")
park_1df_curve_res <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/park_1df_curve_res.xlsx")

#read data 1df urban
ndvi_1df_curve_cvd_urb <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/ndvi_1df_curve_cvd_urb.xlsx")
blue_1df_curve_cvd_urb <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/blue_1df_curve_cvd_urb.xlsx")
park_1df_curve_cvd_urb <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/park_1df_curve_cvd_urb.xlsx")

ndvi_1df_curve_res_urb <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/ndvi_1df_curve_res_urb.xlsx")
blue_1df_curve_res_urb <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/blue_1df_curve_res_urb.xlsx")
park_1df_curve_res_urb <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/park_1df_curve_res_urb.xlsx")

#read data 2df
ndvi_2df_curve_cvd <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/ndvi_2df_sim_curve_cvd.xlsx")
blue_2df_curve_cvd <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/blue_2df_sim_curve_cvd.xlsx")
park_2df_curve_cvd <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/park_2df_sim_curve_cvd.xlsx")

ndvi_2df_curve_res <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/ndvi_2df_sim_curve_res.xlsx")
blue_2df_curve_res <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/blue_2df_sim_curve_res.xlsx")
park_2df_curve_res <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/park_2df_sim_curve_res.xlsx")

#read data 2df urban
ndvi_2df_curve_cvd_urb <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/ndvi_2df_sim_curve_cvd_urb.xlsx")
blue_2df_curve_cvd_urb <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/blue_2df_sim_curve_cvd_urb.xlsx")
park_2df_curve_cvd_urb <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/park_2df_sim_curve_cvd_urb.xlsx")

ndvi_2df_curve_res_urb <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/ndvi_2df_sim_curve_res_urb.xlsx")
blue_2df_curve_res_urb <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/blue_2df_sim_curve_res_urb.xlsx")
park_2df_curve_res_urb <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/park_2df_sim_curve_res_urb.xlsx")

#read data 3df
ndvi_3df_curve_cvd <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/ndvi_3df_sim_curve_cvd.xlsx")
blue_3df_curve_cvd <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/blue_3df_sim_curve_cvd.xlsx")
park_3df_curve_cvd <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/park_3df_sim_curve_cvd.xlsx")

ndvi_3df_curve_res <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/ndvi_3df_sim_curve_res.xlsx")
blue_3df_curve_res <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/blue_3df_sim_curve_res.xlsx")
park_3df_curve_res <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/park_3df_sim_curve_res.xlsx")

#read data 3df urban
ndvi_3df_curve_cvd_urb <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/ndvi_3df_sim_curve_cvd_urb.xlsx")
blue_3df_curve_cvd_urb <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/blue_3df_sim_curve_cvd_urb.xlsx")
park_3df_curve_cvd_urb <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/park_3df_sim_curve_cvd_urb.xlsx")

ndvi_3df_curve_res_urb <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/ndvi_3df_sim_curve_res_urb.xlsx")
blue_3df_curve_res_urb <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/blue_3df_sim_curve_res_urb.xlsx")
park_3df_curve_res_urb <- read.csv("~/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/park_3df_sim_curve_res_urb.xlsx")

#create pdf
pdf(file="/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/figures/nature_splines23_region_cvd_res.pdf", width=8.3, height = 11.7, useDingbats = F)
par(mar = c(4.5, 3, 1, 2),oma=c(6,4,5,3), mfrow=c(4,3))

#plot Park-CVD
matplot(park_1df_curve_cvd$X1,park_1df_curve_cvd$X2,type="l",ylim=c(-0.30,0.2),col=c(1,8,8),lty=c(1,2,2),lwd=c(2,2,2),xlab=expression(paste("% Public park cover")),ylab=paste("HR",sep=""),main=paste("CVD",sep=""))
lines(park_2df_curve_cvd$exp,park_2df_curve_cvd$pred, lty=2)
lines(park_3df_curve_cvd$exp,park_3df_curve_cvd$pred, lty=3)
#lines(pm25_4df_cvd$exp,pm25_4df_cvd$pred, lty=4)
legend(0,0.2,legend=c("df=1","df=2","df=3"),lty=1:3,cex=0.7,box.lty=0)
par(new=T)
hist(exposures_cvd$park, axes=FALSE,main=NULL, xlab=NULL,ylab=NULL,ylim=c(0,9000000*8),border="grey70")

#plot NDVI-CVD
matplot(ndvi_1df_curve_cvd$X1,ndvi_1df_curve_cvd$X2,type="l",ylim=c(-0.30,0.2),col=c(1,8,8),lty=c(1,2,2),lwd=c(2,2,2),xlab=expression(paste("NDVI")),ylab=paste("HR",sep=""),main=paste("CVD",sep=""))
lines(ndvi_2df_curve_cvd$exp,ndvi_2df_curve_cvd$pred, lty=2)
lines(ndvi_3df_curve_cvd$exp,ndvi_3df_curve_cvd$pred, lty=3)
#lines(pm25_4df_cvd$exp,pm25_4df_cvd$pred, lty=4)
legend(0,0.2,legend=c("df=1","df=2","df=3"),lty=1:3,cex=0.7,box.lty=0)
par(new=T)
hist(exposures_cvd$ndvi_summer, axes=FALSE,main=NULL, xlab=NULL,ylab=NULL,ylim=c(0,9000000*4),border="grey70")

#plot Blue-CVD
matplot(blue_1df_curve_cvd$X1,blue_1df_curve_cvd$X2,type="l",ylim=c(-0.30,0.2),col=c(1,8,8),lty=c(1,2,2),lwd=c(2,2,2),xlab=expression(paste("% Blue space cover")),ylab=paste("HR",sep=""),main=paste("CVD",sep=""))
lines(blue_2df_curve_cvd$exp,blue_2df_curve_cvd$pred, lty=2)
lines(blue_3df_curve_cvd$exp,blue_3df_curve_cvd$pred, lty=3)
#lines(pm25_4df_cvd$exp,pm25_4df_cvd$pred, lty=4)
legend(0,0.2,legend=c("df=1","df=2","df=3"),lty=1:3,cex=0.7,box.lty=0)
par(new=T)
hist(exposures_cvd$occur_bs_1000m, axes=FALSE,main=NULL, xlab=NULL,ylab=NULL,ylim=c(0,9000000*18),border="grey70")

#plot Park-CVD
matplot(park_1df_curve_cvd_urb$X1,park_1df_curve_cvd_urb$X2,type="l",ylim=c(-0.30,0.2),col=c(1,8,8),lty=c(1,2,2),lwd=c(2,2,2),xlab=expression(paste("% Public park cover")),ylab=paste("HR",sep=""),main=paste("CVD",sep=""))
lines(park_2df_curve_cvd_urb$exp,park_2df_curve_cvd_urb$pred, lty=2)
lines(park_3df_curve_cvd_urb$exp,park_3df_curve_cvd_urb$pred, lty=3)
#lines(pm25_4df_cvd_urb$exp,pm25_4df_cvd_urb$pred, lty=4)
#legend(0,0.2,legend=c("df=1","df=2","df=3"),lty=1:3,cex=0.7,box.lty=0)
par(new=T)
hist(exposures_cvd_urb$park, axes=FALSE,main=NULL, xlab=NULL,ylab=NULL,ylim=c(0,9000000*4),border="grey70")

#plot NDVI-CVD
matplot(ndvi_1df_curve_cvd_urb$X1,ndvi_1df_curve_cvd_urb$X2,type="l",ylim=c(-0.30,0.2),col=c(1,8,8),lty=c(1,2,2),lwd=c(2,2,2),xlab=expression(paste("NDVI")),ylab=paste("HR",sep=""),main=paste("CVD",sep=""))
lines(ndvi_2df_curve_cvd_urb$exp,ndvi_2df_curve_cvd_urb$pred, lty=2)
lines(ndvi_3df_curve_cvd_urb$exp,ndvi_3df_curve_cvd_urb$pred, lty=3)
#lines(pm25_4df_cvd_urb$exp,pm25_4df_cvd_urb$pred, lty=4)
#legend(0,0.3,legend=c("df=1","df=2","df=3"),lty=1:3,cex=0.7,box.lty=0)
par(new=T)
hist(exposures_cvd_urb$ndvi_summer, axes=FALSE,main=NULL, xlab=NULL,ylab=NULL,ylim=c(0,9000000*2),border="grey70")

#plot Blue-CVD
matplot(blue_1df_curve_cvd_urb$X1,blue_1df_curve_cvd_urb$X2,type="l",ylim=c(-0.30,0.2),col=c(1,8,8),lty=c(1,2,2),lwd=c(2,2,2),xlab=expression(paste("% Blue space cover")),ylab=paste("HR",sep=""),main=paste("CVD",sep=""))
lines(blue_2df_curve_cvd_urb$exp,blue_2df_curve_cvd_urb$pred, lty=2)
lines(blue_3df_curve_cvd_urb$exp,blue_3df_curve_cvd_urb$pred, lty=3)
#lines(pm25_4df_cvd_urb$exp,pm25_4df_cvd_urb$pred, lty=4)
#legend(0,0.3,legend=c("df=1","df=2","df=3"),lty=1:3,cex=0.7,box.lty=0)
par(new=T)
hist(exposures_cvd_urb$occur_bs_1000m, axes=FALSE,main=NULL, xlab=NULL,ylab=NULL,ylim=c(0,9000000*9),border="grey70")

#plot Park-res
matplot(park_1df_curve_res$X1,park_1df_curve_res$X2,type="l",ylim=c(-0.30,0.2),col=c(1,8,8),lty=c(1,2,2),lwd=c(2,2,2),xlab=expression(paste("% Public park cover")),ylab=paste("HR",sep=""),main=paste("res",sep=""))
lines(park_2df_curve_res$exp,park_2df_curve_res$pred, lty=2)
lines(park_3df_curve_res$exp,park_3df_curve_res$pred, lty=3)
#lines(pm25_4df_res$exp,pm25_4df_res$pred, lty=4)
#legend(0,0.2,legend=c("df=1","df=2","df=3"),lty=1:3,cex=0.7,box.lty=0)
par(new=T)
hist(exposures_res$park, axes=FALSE,main=NULL, xlab=NULL,ylab=NULL,ylim=c(0,9000000*8),border="grey70")

#plot NDVI-res
matplot(ndvi_1df_curve_res$X1,ndvi_1df_curve_res$X2,type="l",ylim=c(-0.30,0.2),col=c(1,8,8),lty=c(1,2,2),lwd=c(2,2,2),xlab=expression(paste("NDVI")),ylab=paste("HR",sep=""),main=paste("res",sep=""))
lines(ndvi_2df_curve_res$exp,ndvi_2df_curve_res$pred, lty=2)
lines(ndvi_3df_curve_res$exp,ndvi_3df_curve_res$pred, lty=3)
#lines(pm25_4df_res$exp,pm25_4df_res$pred, lty=4)
#legend(0,0.3,legend=c("df=1","df=2","df=3"),lty=1:3,cex=0.7,box.lty=0)
par(new=T)
hist(exposures_res$ndvi_summer, axes=FALSE,main=NULL, xlab=NULL,ylab=NULL,ylim=c(0,9000000*4),border="grey70")

#plot Blue-res
matplot(blue_1df_curve_res$X1,blue_1df_curve_res$X2,type="l",ylim=c(-0.30,0.2),col=c(1,8,8),lty=c(1,2,2),lwd=c(2,2,2),xlab=expression(paste("% Blue space cover")),ylab=paste("HR",sep=""),main=paste("res",sep=""))
lines(blue_2df_curve_res$exp,blue_2df_curve_res$pred, lty=2)
lines(blue_3df_curve_res$exp,blue_3df_curve_res$pred, lty=3)
#legend(0,0.3,legend=c("df=1","df=2","df=3"),lty=1:3,cex=0.7,box.lty=0)
par(new=T)
hist(exposures_res$occur_bs_1000m, axes=FALSE,main=NULL, xlab=NULL,ylab=NULL,ylim=c(0,9000000*18),border="grey70")

#plot Park-res
matplot(park_1df_curve_res_urb$X1,park_1df_curve_res_urb$X2,type="l",ylim=c(-0.30,0.2),col=c(1,8,8),lty=c(1,2,2),lwd=c(2,2,2),xlab=expression(paste("% Public park cover")),ylab=paste("HR",sep=""),main=paste("res",sep=""))
lines(park_2df_curve_res_urb$exp,park_2df_curve_res_urb$pred, lty=2)
lines(park_3df_curve_res_urb$exp,park_3df_curve_res_urb$pred, lty=3)
#lines(pm25_4df_res_urb$exp,pm25_4df_res_urb$pred, lty=4)
#legend(0,0.2,legend=c("df=1","df=2","df=3"),lty=1:3,cex=0.7,box.lty=0)
par(new=T)
hist(exposures_res_urb$park, axes=FALSE,main=NULL, xlab=NULL,ylab=NULL,ylim=c(0,9000000*4),border="grey70")

#plot NDVI-res
matplot(ndvi_1df_curve_res_urb$X1,ndvi_1df_curve_res_urb$X2,type="l",ylim=c(-0.30,0.2),col=c(1,8,8),lty=c(1,2,2),lwd=c(2,2,2),xlab=expression(paste("NDVI")),ylab=paste("HR",sep=""),main=paste("res",sep=""))
lines(ndvi_2df_curve_res_urb$exp,ndvi_2df_curve_res_urb$pred, lty=2)
lines(ndvi_3df_curve_res_urb$exp,ndvi_3df_curve_res_urb$pred, lty=3)
#lines(pm25_4df_res_urb$exp,pm25_4df_res_urb$pred, lty=4)
#legend(0,0.3,legend=c("df=1","df=2","df=3"),lty=1:3,cex=0.7,box.lty=0)
par(new=T)
hist(exposures_res_urb$ndvi_summer, axes=FALSE,main=NULL, xlab=NULL,ylab=NULL,ylim=c(0,9000000*2),border="grey70")

#plot Blue-res
matplot(blue_1df_curve_res_urb$X1,blue_1df_curve_res_urb$X2,type="l",ylim=c(-0.30,0.2),col=c(1,8,8),lty=c(1,2,2),lwd=c(2,2,2),xlab=expression(paste("% Blue space cover")),ylab=paste("HR",sep=""),main=paste("res",sep=""))
lines(blue_2df_curve_res_urb$exp,blue_2df_curve_res_urb$pred, lty=2)
lines(blue_3df_curve_res_urb$exp,blue_3df_curve_res_urb$pred, lty=3)
#legend(0,0.3,legend=c("df=1","df=2","df=3"),lty=1:3,cex=0.7,box.lty=0)
par(new=T)
hist(exposures_res_urb$occur_bs_1000m, axes=FALSE,main=NULL, xlab=NULL,ylab=NULL,ylim=c(0,9000000*9),border="grey70")

dev.off()
