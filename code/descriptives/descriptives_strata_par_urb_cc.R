
library(writexl)
library(data.table)
library(fst)

#load data
new_merged <- "/nfs/home/J/jok8845/shared_space/ci3_analysis/jklompmaker/par2/"
aggregate_PAR <- read_fst(paste0(new_merged ,"aggregate_PAR.fst"), 
                          columns = c("sex","race","age_entry","dual","followupyear",
                                      "zip","year","region4",
                                      "hosp","time_count",
                                      "ndvi_summer",
                                      "occur_bs","occur_bs_1000m",
                                      "park",
                                      "poverty","popdensity","medianhousevalue","pct_blk","medhouseholdincome","pct_owner_occ","hispanic", "education",
                                      "smoke_rate","summer_tmmx","summer_sph","summer_pr","pm25","no2"),as.data.table = T)
gc()
aggregate_PAR<-aggregate_PAR[popdensity>=1000,]
nrow(aggregate_PAR) #rows=58936225
sum(aggregate_PAR$hosp)#18613970
sum(aggregate_PAR$time_count)#401295837

aggregate_PAR<-na.omit(aggregate_PAR, cols=c("sex","race","age_entry","dual","followupyear",
                                             "zip","year","hosp","time_count",
                                             "poverty","popdensity",
                                             "medianhousevalue","pct_blk","medhouseholdincome","pct_owner_occ","hispanic",
                                             "education",
                                             "smoke_rate","region4",
                                             "ndvi_summer","occur_bs_1000m","park"))

nrow(aggregate_PAR) #rows=58936225
sum(aggregate_PAR$hosp)#18613970
sum(aggregate_PAR$time_count)#401295837
aggregate_PAR$occur_bs_1000m_bin<-ifelse(aggregate_PAR$occur_bs_1000m>=0.01,1,0)
table(aggregate_PAR$occur_bs_1000m_bin)
aggregate_PAR$occur_bs_1000m_ter<-ifelse(aggregate_PAR$occur_bs_1000m>=0.05,1,0)
table(aggregate_PAR$occur_bs_1000m_ter)

#get continuous variables
aggregate_PAR<-aggregate_PAR[,c("ndvi_summer",
                                "occur_bs","occur_bs_1000m",
                                "park",
                                "poverty","popdensity","medianhousevalue","pct_blk","medhouseholdincome","pct_owner_occ","hispanic", "education",
                                "smoke_rate","summer_tmmx","summer_sph","summer_pr","pm25","no2")]
#function to get descriptives
des.cont<-function(x){
  nax<-na.omit(x)
  data.frame(n=length(nax),mean=mean(nax),sd=sd(nax),min=min(nax),per5=quantile(nax,0.05),per25=quantile(nax,0.25),median=median(nax),per75=quantile(nax,0.75),per95=quantile(nax,0.95),max=max(nax),iqr=IQR(nax))
}
des.exp.all<-cbind(pol=names(aggregate_PAR),do.call(rbind,lapply(aggregate_PAR,des.cont)))

#save descriptives
write_xlsx(des.exp.all,path="/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/descriptives/descr_exposures_strata_par_urb_cc.xlsx")

#calculate spearman correlations
scor.allexp<-cbind(pol=names(aggregate_PAR),as.data.frame(cor(aggregate_PAR,method="spearman",use="complete.obs")))
write_xlsx(scor.allexp,path="/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/descriptives/spm_corr_exposures_strata_par_urb_cc.xlsx")

#calculate pearson correlations
#pcor.allexp<-cbind(pol=names(aggregate_PAR),as.data.frame(cor(aggregate_PAR,method="pearson",use="complete.obs")))
#write_xlsx(pcor.allexp,path="/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/descriptives/psn_corr_exposures_strata_par_cc.xlsx")
