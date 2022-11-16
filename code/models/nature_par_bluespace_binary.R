#install.packages("coxme")
library("fst")
library("writexl")
library("splines")
library("gnm")
library("writexl")
library("data.table")
library("lmtest")

new_merged <- "/nfs/home/J/jok8845/shared_space/ci3_health_data/medicare/gen_admission/1999_2016/Klompmaker/merged_data/par2/"
dataplot <- read_fst(paste0(new_merged ,"aggregate_PAR.fst"),
                     columns = c("sex","race","age_entry","dual","followupyear",
                                 "zip","year","hosp","time_count",
                                 "poverty","popdensity",
                                 "medianhousevalue","pct_blk","medhouseholdincome","pct_owner_occ","hispanic",
                                 "education","population","region4","division",
                                 "smoke_rate","mean_bmi","summer_tmmx","summer_sph","summer_pr","pm25","no2",
                                 "ndvi_summer","occur_bs","occur_bs_1000m","park"), as.data.table = T)

dataplot$medianhousevalue<-dataplot$medianhousevalue/10000
dataplot$medhouseholdincome<-dataplot$medhouseholdincome/1000


#model with binary blue space (yes vs. no)
dataplot$occur_bs_1000m_bin<-ifelse(dataplot$occur_bs_1000m>0,1,0)

print("model division")
Sys.time()
model<-gnm(hosp~park+ndvi_summer+as.factor(occur_bs_1000m_bin)+
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
serr$model<-c("model binary blue space")
serr$out<-c("par")
serr$exposure<-rownames(serr)
write.csv(serr,file="/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/Modeloutput/confounders/m5_binary_blue_par.xlsx")
