#install.packages("coxme")
library("fst")
library("writexl")
library("splines")
library("gnm")
library("writexl")
library("data.table")
library("lmtest")

new_merged <- "/nfs/home/J/jok8845/shared_space/ci3_analysis/jklompmaker/par2/"
dataplot <- read_fst(paste0(new_merged ,"aggregate_PAR.fst"),
                     columns = c("sex","race","age_entry","dual","followupyear",
                                 "zip","year","hosp","time_count",
                                 "poverty","popdensity",
                                 "medianhousevalue","pct_blk","medhouseholdincome","pct_owner_occ","hispanic",
                                 "education","region4","division",
                                 "smoke_rate","summer_tmmx","summer_sph","summer_pr","pm25","no2",
                                 "ndvi_summer","occur_bs","occur_bs_1000m","park"), as.data.table = T)

dataplot$medianhousevalue<-dataplot$medianhousevalue/10000
dataplot$medhouseholdincome<-dataplot$medhouseholdincome/1000
dataplot$occur_bs_bin<-ifelse(dataplot$occur_bs>0,1,0)
#dataplot$occur_bs_1000m_bin<-ifelse(dataplot$occur_bs_1000m>0,1,0)
dataplot$occur_bs_1000m_one<-ifelse(dataplot$occur_bs_1000m>0.00,1,0)

#model with tertiary blue space 
print("model 3 blue space")
Sys.time()
model<-gnm(hosp~park+ndvi_summer+as.factor(occur_bs_1000m_one)+
             as.factor(year)+as.factor(region4)+
             medhouseholdincome+medianhousevalue+poverty+education+pct_owner_occ+hispanic+pct_blk+
             popdensity+
             smoke_rate+
             offset(log(time_count)),
           eliminate=(as.factor(sex):as.factor(race):as.factor(dual):as.factor(age_entry):as.factor(followupyear)),
           data=dataplot,family=poisson(link="log"))
Sys.time()
print("model finished")
serr<-as.data.frame(model$coefficients[1:3])
colnames(serr)<-"Beta"
serr$model<-c("model blue space 0%")
serr$out<-c("alz")
serr$exposure<-rownames(serr)
write.csv(serr,file="/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/m4_0pct_blue_par.xlsx")
