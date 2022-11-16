
library(writexl)
library(data.table)
library(fst)

#load data
new_merged <- "/nfs/home/J/jok8845/shared_space/ci3_health_data/medicare/gen_admission/1999_2016/Klompmaker/merged_data/alz2/"
aggregate_ALZ <- read_fst(paste0(new_merged ,"aggregate_ALZ.fst"), 
                          columns = c("hosp","time_count",
                                      "ndvi_summer",
                                      "occur_bs","occur_bs_1000m",
                                      "park",
                                      "poverty","popdensity","medianhousevalue","pct_blk","medhouseholdincome","pct_owner_occ","hispanic", "education",
                                      "smoke_rate","summer_tmmx","summer_sph","summer_pr","pm25","no2"),as.data.table = T)
gc()
nrow(aggregate_ALZ) #rows=64355852
sum(aggregate_ALZ$hosp)#7094287
sum(aggregate_ALZ$time_count)#465041599

#get continuous variables
aggregate_ALZ<-aggregate_ALZ[,c("ndvi_summer",
                                "occur_bs","occur_bs_1000m",
                                "park",
                                "poverty","popdensity","medianhousevalue","pct_blk","medhouseholdincome","pct_owner_occ","hispanic", "education",
                                "smoke_rate","summer_tmmx","summer_sph","summer_pr","pm25","no2")]
#function to get descriptives
des.cont<-function(x){
  nax<-na.omit(x)
  data.frame(n=length(nax),mean=mean(nax),sd=sd(nax),min=min(nax),per5=quantile(nax,0.05),per25=quantile(nax,0.25),median=median(nax),per75=quantile(nax,0.75),per95=quantile(nax,0.95),max=max(nax),iqr=IQR(nax))
}
des.exp.all<-cbind(pol=names(aggregate_ALZ),do.call(rbind,lapply(aggregate_ALZ,des.cont)))

#save descriptives
write_xlsx(des.exp.all,path="/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/descriptives/descr_exposures_strata_alz.xlsx")

#calculate spearman correlations
scor.allexp<-cbind(pol=names(aggregate_ALZ),as.data.frame(cor(aggregate_ALZ,method="spearman",use="complete.obs")))
write_xlsx(scor.allexp,path="/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/descriptives/spm_corr_exposures_strata_alz.xlsx")

#calculate pearson correlations
pcor.allexp<-cbind(pol=names(aggregate_ALZ),as.data.frame(cor(aggregate_ALZ,method="pearson",use="complete.obs")))
write_xlsx(pcor.allexp,path="/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/descriptives/psn_corr_exposures_strata_alz.xlsx")
