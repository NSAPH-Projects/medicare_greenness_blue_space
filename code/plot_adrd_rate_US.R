library(writexl)
library(data.table)
library(fst)

#import alz data
new_merged <- "/nfs/home/J/jok8845/shared_space/ci3_analysis/jklompmaker/alz2/"
aggregate_ALZ <- read_fst(paste0(new_merged ,"aggregate_ALZ.fst"), 
                          columns = c("zip","hosp","time_count"))

aggregated_hosp <- aggregate(aggregate_ALZ$hosp,by=list(category=aggregate_ALZ$zip),FUN=sum)
aggregated_pyrs <- aggregate(aggregate_ALZ$time_count,by=list(category=aggregate_ALZ$zip),FUN=sum)

aggregated<-cbind(aggregated_hosp,aggregated_pyrs)
aggregated$rate<-aggregated[,2]/aggregated[,4]*100000
head(aggregated$rate)
mean(aggregated$rate,na.rm=T)
median(aggregated$rate,na.rm=T)
min(aggregated$rate,na.rm=T)
max(aggregated$rate,na.rm=T)

hist(aggregated$rate)

write_xlsx(aggregated,path="/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/descriptives/rate_20002016_alz.xlsx")

#import alz data
new_merged <- "/nfs/home/J/jok8845/shared_space/ci3_analysis/jklompmaker/par2/"
aggregate_ALZ <- read_fst(paste0(new_merged ,"aggregate_PAR.fst"), 
                          columns = c("zip","hosp","time_count"))

aggregated_hosp <- aggregate(aggregate_ALZ$hosp,by=list(category=aggregate_ALZ$zip),FUN=sum)
aggregated_pyrs <- aggregate(aggregate_ALZ$time_count,by=list(category=aggregate_ALZ$zip),FUN=sum)

aggregated<-cbind(aggregated_hosp,aggregated_pyrs)
aggregated$rate<-aggregated[,2]/aggregated[,4]*100000
head(aggregated$rate)
mean(aggregated$rate,na.rm=T)
median(aggregated$rate,na.rm=T)
min(aggregated$rate,na.rm=T)
max(aggregated$rate,na.rm=T)

hist(aggregated$rate)

write_xlsx(aggregated,path="/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/descriptives/rate_20002016_par.xlsx")
