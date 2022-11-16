
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
                                      "smoke_rate"),as.data.table = T)

gc()
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
aggregate_PAR$occur_bs_1000m_one<-ifelse(aggregate_PAR$occur_bs_1000m>0.00,1,0)
table(aggregate_PAR$occur_bs_1000m_one)
aggregate_PAR$occur_bs_1000m_bin<-ifelse(aggregate_PAR$occur_bs_1000m>=0.01,1,0)
table(aggregate_PAR$occur_bs_1000m_bin)
aggregate_PAR$occur_bs_1000m_ter<-ifelse(aggregate_PAR$occur_bs_1000m>=0.05,1,0)
table(aggregate_PAR$occur_bs_1000m_ter)


aggregate_PAR<-aggregate_PAR[popdensity>=1000,]

nrow(aggregate_PAR) #rows=58936225
sum(aggregate_PAR$hosp)#18613970
sum(aggregate_PAR$time_count)#401295837
aggregate_PAR$occur_bs_1000m_one<-ifelse(aggregate_PAR$occur_bs_1000m>0.00,1,0)
table(aggregate_PAR$occur_bs_1000m_one)
aggregate_PAR$occur_bs_1000m_bin<-ifelse(aggregate_PAR$occur_bs_1000m>=0.01,1,0)
table(aggregate_PAR$occur_bs_1000m_bin)
aggregate_PAR$occur_bs_1000m_ter<-ifelse(aggregate_PAR$occur_bs_1000m>=0.05,1,0)
table(aggregate_PAR$occur_bs_1000m_ter)
