##list all business files
library(data.table)
library(readr)

#set working directory
setwd("/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/data/confounders/precipitation")

###############################################################################
#list all ndvi files
###############################################################################
year<-c(2000)
pr_2000<-cbind(read.csv("pr_zip_2000.csv"),year)
year<-c(2001)
pr_2001<-cbind(read.csv("pr_zip_2001.csv"),year)
year<-c(2002)
pr_2002<-cbind(read.csv("pr_zip_2002.csv"),year)
year<-c(2003)
pr_2003<-cbind(read.csv("pr_zip_2003.csv"),year)
year<-c(2004)
pr_2004<-cbind(read.csv("pr_zip_2004.csv"),year)
year<-c(2005)
pr_2005<-cbind(read.csv("pr_zip_2005.csv"),year)
year<-c(2006)
pr_2006<-cbind(read.csv("pr_zip_2006.csv"),year)
year<-c(2007)
pr_2007<-cbind(read.csv("pr_zip_2007.csv"),year)
year<-c(2008)
pr_2008<-cbind(read.csv("pr_zip_2008.csv"),year)
year<-c(2009)
pr_2009<-cbind(read.csv("pr_zip_2009.csv"),year)
year<-c(2010)
pr_2010<-cbind(read.csv("pr_zip_2010.csv"),year)
year<-c(2011)
pr_2011<-cbind(read.csv("pr_zip_2011.csv"),year)
year<-c(2012)
pr_2012<-cbind(read.csv("pr_zip_2012.csv"),year)
year<-c(2013)
pr_2013<-cbind(read.csv("pr_zip_2013.csv"),year)
year<-c(2014)
pr_2014<-cbind(read.csv("pr_zip_2014.csv"),year)
year<-c(2015)
pr_2015<-cbind(read.csv("pr_zip_2015.csv"),year)
year<-c(2016)
pr_2016<-cbind(read.csv("pr_zip_2016.csv"),year)

pr<-rbind(pr_2000,pr_2001,pr_2002,pr_2003,pr_2004,pr_2005,pr_2006,pr_2007,pr_2008,pr_2009,pr_2010,pr_2011,pr_2012,pr_2013,pr_2014,pr_2015,pr_2016)

write_csv(pr, "combined_pr_zip20002016.csv")
