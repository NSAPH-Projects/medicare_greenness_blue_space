library(writexl)
library(data.table)
library(fst)

#import alz data
new_merged <- "/nfs/home/J/jok8845/shared_space/ci3_analysis/jklompmaker/alz2/"
aggregate_ALZ <- read_fst(paste0(new_merged ,"aggregate_ALZ.fst"), 
                          columns = c("year","hosp","time_count","occur_bs_1000m"))
setDT(aggregate_ALZ)
aggregate_ALZ$occur_bs_1000m_bin<-ifelse(aggregate_ALZ$occur_bs_1000m<0.01,1,0)
aggregate_ALZ<-aggregate_ALZ[occur_bs_1000m_bin=="0",]
aggregated_hosp <- aggregate(aggregate_ALZ$hosp,by=list(category=aggregate_ALZ$year),FUN=sum)
aggregated_pyrs <- aggregate(aggregate_ALZ$time_count,by=list(category=aggregate_ALZ$year),FUN=sum)

mean(aggregated_hosp$x)
mean(aggregated_pyrs$x)

#import alz data
new_merged <- "/nfs/home/J/jok8845/shared_space/ci3_analysis/jklompmaker/alz2/"
aggregate_ALZ <- read_fst(paste0(new_merged ,"aggregate_ALZ.fst"), 
                          columns = c("year","hosp","time_count","popdensity","occur_bs_1000m"))
setDT(aggregate_ALZ)
aggregate_ALZ$occur_bs_1000m_bin<-ifelse(aggregate_ALZ$occur_bs_1000m<0.01,1,0)
aggregate_ALZ<-aggregate_ALZ[occur_bs_1000m_bin=="0",]
aggregate_ALZ<-aggregate_ALZ[popdensity>=1000,]
aggregated_hosp <- aggregate(aggregate_ALZ$hosp,by=list(category=aggregate_ALZ$year),FUN=sum)
aggregated_pyrs <- aggregate(aggregate_ALZ$time_count,by=list(category=aggregate_ALZ$year),FUN=sum)

mean(aggregated_hosp$x)
mean(aggregated_pyrs$x)


#import alz data
new_merged <- "/nfs/home/J/jok8845/shared_space/ci3_analysis/jklompmaker/par2/"
aggregate_PAR <- read_fst(paste0(new_merged ,"aggregate_PAR.fst"), 
                          columns = c("year","hosp","time_count","occur_bs_1000m"))
setDT(aggregate_PAR)
aggregate_PAR$occur_bs_1000m_bin<-ifelse(aggregate_PAR$occur_bs_1000m<0.01,1,0)
aggregate_PAR<-aggregate_PAR[occur_bs_1000m_bin=="0",]
aggregated_hosp <- aggregate(aggregate_PAR$hosp,by=list(category=aggregate_PAR$year),FUN=sum)
aggregated_pyrs <- aggregate(aggregate_PAR$time_count,by=list(category=aggregate_PAR$year),FUN=sum)

mean(aggregated_hosp$x)
mean(aggregated_pyrs$x)

#import alz data
new_merged <- "/nfs/home/J/jok8845/shared_space/ci3_analysis/jklompmaker/par2/"
aggregate_PAR <- read_fst(paste0(new_merged ,"aggregate_PAR.fst"), 
                          columns = c("year","hosp","time_count","popdensity","occur_bs_1000m"))
setDT(aggregate_PAR)
aggregate_PAR$occur_bs_1000m_bin<-ifelse(aggregate_PAR$occur_bs_1000m<0.01,1,0)
aggregate_PAR<-aggregate_PAR[occur_bs_1000m_bin=="0",]
aggregate_PAR<-aggregate_PAR[popdensity>=1000,]
aggregated_hosp <- aggregate(aggregate_PAR$hosp,by=list(category=aggregate_PAR$year),FUN=sum)
aggregated_pyrs <- aggregate(aggregate_PAR$time_count,by=list(category=aggregate_PAR$year),FUN=sum)

mean(aggregated_hosp$x)
mean(aggregated_pyrs$x)