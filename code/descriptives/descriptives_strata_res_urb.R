
library(writexl)
library(data.table)
library(fst)

#load data
new_merged <- "/nfs/home/J/jok8845/shared_space/ci3_health_data/medicare/gen_admission/1999_2016/Klompmaker/merged_data/res2/"
aggregate_RES <- read_fst(paste0(new_merged ,"aggregate_RES.fst"), 
                          columns = c("sex","race","age_entry","dual","followupyear",
                                      "zip","year","hosp","time_count",
                                      "ndvi_summer","ndvi_fall","ndvi_winter","ndvi_spring","ndvi_year",
                                      "occur_bs","occur_bs_300m","occur_bs_1000m","trns_bs_300m",
                                      "park",
                                      "poverty","popdensity","medianhousevalue","pct_blk","medhouseholdincome","pct_owner_occ","hispanic", "education",
                                      "smoke_rate","mean_bmi","summer_tmmx","summer_sph","summer_pr","pm25","no2"),as.data.table = T)
gc()
aggregate_RES<-aggregate_RES[popdensity>=1000,]
nrow(aggregate_RES) #
sum(aggregate_RES$hosp)#
sum(aggregate_RES$time_count)#

#get continuous variables
aggregate_RES<-aggregate_RES[,c("ndvi_summer","ndvi_fall","ndvi_winter","ndvi_spring","ndvi_year",
                                "occur_bs","occur_bs_300m","occur_bs_1000m","trns_bs_300m",
                                "park",
                                "poverty","popdensity","medianhousevalue","pct_blk","medhouseholdincome","pct_owner_occ","hispanic", "education",
                                "smoke_rate","mean_bmi","summer_tmmx","summer_sph","summer_pr","pm25","no2")]
#function to get descriptives
des.cont<-function(x){
  nax<-na.omit(x)
  data.frame(n=length(nax),mean=mean(nax),sd=sd(nax),min=min(nax),per5=quantile(nax,0.05),per25=quantile(nax,0.25),median=median(nax),per75=quantile(nax,0.75),per95=quantile(nax,0.95),max=max(nax),iqr=IQR(nax))
}
des.exp.all<-cbind(pol=names(aggregate_RES),do.call(rbind,lapply(aggregate_RES,des.cont)))

#save descriptives
write_xlsx(des.exp.all,path="/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/descriptives/descr_exposures_strata_urb_res.xlsx")

#calculate spearman correlations
scor.allexp<-cbind(pol=names(aggregate_RES),as.data.frame(cor(aggregate_RES,method="spearman",use="complete.obs")))
write_xlsx(scor.allexp,path="/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/descriptives/spm_corr_exposures_strata_urb_res.xlsx")

#calculate pearson correlations
pcor.allexp<-cbind(pol=names(aggregate_RES),as.data.frame(cor(aggregate_RES,method="pearson",use="complete.obs")))
write_xlsx(pcor.allexp,path="/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/descriptives/psn_corr_exposures_strata_urb_res.xlsx")
