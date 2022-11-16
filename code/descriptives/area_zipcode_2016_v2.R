#install.packages("coxme")
library("fst")
library("writexl")
library("splines")
library("gnm")
library("writexl")
library("data.table")
library("lmtest")
library("gtools")

new_merged <- "/nfs/home/J/jok8845/shared_space/ci3_analysis/jklompmaker/res2/"
dir_out <- "/nfs/home/J/jok8845/shared_space/ci3_analysis/medicare_temperature_humidity/Modeloutput/"
#dataplot <- read_fst(paste0(new_merged ,"sample.fst"),
dataplot <- read_fst(paste0(new_merged ,"aggregate_RES.fst"),
                     columns = c("zip","year","population","popdensity"), as.data.table = T)

#get year 2016
dataplot<-dataplot[year==2016,]
dataplot$area<-dataplot$population/dataplot$popdensity
nrow(dataplot)
dataplot<-dataplot[!duplicated(dataplot), ]
nrow(dataplot)

min(dataplot$population,na.rm=T)
quantile(dataplot$population,0.25,na.rm=T)
median(dataplot$population,na.rm=T) #41.49
quantile(dataplot$population,0.75,na.rm=T)
max(dataplot$population,na.rm=T)

min(dataplot$area,na.rm=T)
quantile(dataplot$area,0.25,na.rm=T)
median(dataplot$area,na.rm=T) #41.49
quantile(dataplot$area,0.75,na.rm=T)
max(dataplot$area,na.rm=T)

write_fst(dataplot, "/nfs/home/J/jok8845/shared_space/ci3_analysis/jklompmaker/res2/zipcodes2016.fst")

dataplot<-dataplot[dataplot$popdensity>=1000,]
min(dataplot$population,na.rm=T)
quantile(dataplot$population,0.25,na.rm=T)
median(dataplot$population,na.rm=T) #41.49
quantile(dataplot$population,0.75,na.rm=T)
max(dataplot$population,na.rm=T)

min(dataplot$area,na.rm=T)
quantile(dataplot$area,0.25,na.rm=T)
median(dataplot$area,na.rm=T) #41.49
quantile(dataplot$area,0.75,na.rm=T)
max(dataplot$area,na.rm=T)


