
#library(NSAPHutils)
#library(NSAPHplatform)
#set_threads()
library(fst)
library(data.table)
library(lubridate)
#library(icd)
#library(dplyr)

old_merged <- "/nfs/home/J/jok8845/shared_space/ci3_health_data/medicare/gen_admission/1999_2016/Klompmaker/cache_data/correct_follow_up_age_entry/"

## Define cardiovascular conditions
#all cardiovascular disease
#res_icd9 <- expand_range("460","519")
res_icd9 <- c("460","461","4610","4611","4612","4613","4618","4619","462","463","464","4640","46400",
"46401","4641","46410","46411","4642","46420","46421","4643","46430","46431","4644","4645","46450",
"46451","465","4650","4658","4659","466","4660","4661","46611","46619","470","471","4710",
"4711","4718","4719","472","4720","4721","4722","473","4730","4731","4732","4733","4738",
"4739","474","4740","47400","47401","47402","4741","47410","47411","47412","4742","4748","4749",
"475","476","4760","4761","477","4770","4771","4772","4778","4779","478","4780","4781",
"47811","47819","4782","47820","47821","47822","47824","47825","47826","47829","4783","47830","47831",
"47832","47833","47834","4784","4785","4786","4787","47870","47871","47874","47875","47879","4788",
"4789","480","4800","4801","4802","4803","4808","4809","481","482","4820","4821","4822",
"4823","48230","48231","48232","48239","4824","48240","48241","48242","48249","4828","48281","48282",
"48283","48284","48289","4829","483","4830","4831","4838","484","4841","4843","4845","4846",
"4847","4848","485","486","487","4870","4871","4878","488","4880","48801","48802","48809",
"4881","48811","48812","48819","4888","48881","48882","48889","490","491","4910","4911","4912",
"49120","49121","49122","4918","4919","492","4920","4928","493","4930","49300","49301","49302",
"4931","49310","49311","49312","4932","49320","49321","49322","4938","49381","49382","4939","49390",
"49391","49392","494","4940","4941","495","4950","4951","4952","4953","4954","4955","4956",
"4957","4958","4959","496","500","501","502","503","504","505","506","5060","5061",
"5062","5063","5064","5069","507","5070","5071","5078","508","5080","5081","5082","5088",
"5089","510","5100","5109","511","5110","5111","5118","51181","51189","5119","512","5120",
"5121","5122","5128","51281","51282","51283","51284","51289","513","5130","5131","514","515", 
"516","5160","5161","5162","5163","51630","51631","51632","51633","51634","51635","51636","51637",
"5164","5165","5166","51661","51662","51663","51664","51669","5168","5169","517","5171","5172",
"5173","5178","518","5180","5181","5182","5183","5184","5185","51851","51852","51853","5186",
"5187","5188","51881","51882","51883","51884","51889","519","5190","51900","51901","51902","51909",
"5191","51911","51919","5192","5193","5194","5198","5199") 

#res_icd10 <- expand_range("J00","J99")
res_icd10 <- c("J00","J01","J010","J0100","J0101","J011","J0110","J0111","J012","J0120","J0121",
"J013","J0130","J0131","J014","J0140","J0141","J018","J0180","J0181","J019","J0190",
"J0191","J02","J020","J028","J029","J03","J030","J0300","J0301","J038","J0380",
"J0381","J039","J0390","J0391","J04","J040","J041","J0410","J0411","J042","J043", 
"J0430","J0431","J05","J050","J051","J0510","J0511","J06","J060","J069","J09",  
"J09X","J09X1","J09X2","J09X3","J09X9","J10","J100","J1000","J1001","J1008","J101", 
"J102","J108","J1081","J1082","J1083","J1089","J11","J110","J1100","J1108","J111", 
"J112","J118","J1181","J1182","J1183","J1189","J12","J120","J121","J122","J123", 
"J128","J1281","J1289","J129","J13","J14","J15","J150","J151","J152","J1520",
"J1521","J15211","J15212","J1529","J153","J154","J155","J156","J157","J158","J159", 
"J16","J160","J168","J17","J18","J180","J181","J182","J188","J189","J20",  
"J200","J201","J202","J203","J204","J205","J206","J207","J208","J209","J21",  
"J210","J211","J218","J219","J22","J30","J300","J301","J302","J305","J308", 
"J3081","J3089","J309","J31","J310","J311","J312","J32","J320","J321","J322", 
"J323","J324","J328","J329","J33","J330","J331","J338","J339","J34","J340", 
"J341","J342","J343","J348","J3481","J3489","J349","J35","J350","J3501","J3502",
"J3503","J351","J352","J353","J358","J359","J36","J37","J370","J371","J38",  
"J380","J3800","J3801","J3802","J381","J382","J383","J384","J385","J386","J387", 
"J39","J390","J391","J392","J393","J398","J399","J40","J41","J410","J411", 
"J418","J42","J43","J430","J431","J432","J438","J439","J44","J440","J441", 
"J449","J45","J452","J4520","J4521","J4522","J453","J4530","J4531","J4532","J454", 
"J4540","J4541","J4542","J455","J4550","J4551","J4552","J459","J4590","J45901","J45902",
"J45909","J4599","J45990","J45991","J45998","J47","J470","J471","J479","J60","J61",  
"J62","J620","J628","J63","J630","J631","J632","J633","J634","J635","J636", 
"J64","J65","J66","J660","J661","J662","J668","J67","J670","J671","J672", 
"J673","J674","J675","J676","J677","J678","J679","J68","J680","J681","J682", 
"J683","J684","J688","J689","J69","J690","J691","J698","J70","J700","J701", 
"J702","J703","J704","J705","J708","J709","J80","J81","J810","J811","J82",  
"J84","J840","J8401","J8402","J8403","J8409","J841","J8410","J8411","J84111","J84112",
"J84113","J84114","J84115","J84116","J84117","J8417","J842","J848","J8481","J8482","J8483",
"J8484","J84841","J84842","J84843","J84848","J8489","J849","J85","J850","J851","J852", 
"J853","J86","J860","J869","J90","J91","J910","J918","J92","J920","J929", 
"J93","J930","J931","J9311","J9312","J938","J9381","J9382","J9383","J939","J94",  
"J940","J941","J942","J948","J949","J95","J950","J9500","J9501","J9502","J9503",
"J9504","J9509","J951","J952","J953","J954","J955","J956","J9561","J9562","J957", 
"J9571","J9572","J958","J9581","J95811","J95812","J9582","J95821","J95822","J9583","J95830",
"J95831","J9584","J9585","J95850","J95851","J95859","J9588","J9589","J96","J960","J9600",
"J9601","J9602","J961","J9610","J9611","J9612","J962","J9620","J9621","J9622","J969", 
"J9690","J9691","J9692","J98","J980","J9801","J9809","J981","J9811","J9819","J982", 
"J983","J984","J985","J986","J988","J989","J99")

## Load all admissions
## Needed because admissions in year of disharge, not admission
#admissions <- read_data("/nfs/home/J/jok8845/shared_space/ci3_health_data/medicare/gen_admission/1999_2016/targeted_conditions/cache_data/admissions_by_year/", years = 2000:2016,
#                        columns = c("QID",
#                                    "ADATE",
#                                    "DDATE",
#                                    "DIAG1"))
adm2000<-read_fst("/nfs/home/J/jok8845/shared_space/ci3_health_data/medicare/gen_admission/1999_2016/targeted_conditions/cache_data/admissions_by_year/admissions_2000.fst",columns = c("QID","ADATE","DDATE","DIAG1"))
adm2001<-read_fst("/nfs/home/J/jok8845/shared_space/ci3_health_data/medicare/gen_admission/1999_2016/targeted_conditions/cache_data/admissions_by_year/admissions_2001.fst",columns = c("QID","ADATE","DDATE","DIAG1"))
adm2002<-read_fst("/nfs/home/J/jok8845/shared_space/ci3_health_data/medicare/gen_admission/1999_2016/targeted_conditions/cache_data/admissions_by_year/admissions_2002.fst",columns = c("QID","ADATE","DDATE","DIAG1"))
adm2003<-read_fst("/nfs/home/J/jok8845/shared_space/ci3_health_data/medicare/gen_admission/1999_2016/targeted_conditions/cache_data/admissions_by_year/admissions_2003.fst",columns = c("QID","ADATE","DDATE","DIAG1"))
adm2004<-read_fst("/nfs/home/J/jok8845/shared_space/ci3_health_data/medicare/gen_admission/1999_2016/targeted_conditions/cache_data/admissions_by_year/admissions_2004.fst",columns = c("QID","ADATE","DDATE","DIAG1"))
adm2005<-read_fst("/nfs/home/J/jok8845/shared_space/ci3_health_data/medicare/gen_admission/1999_2016/targeted_conditions/cache_data/admissions_by_year/admissions_2005.fst",columns = c("QID","ADATE","DDATE","DIAG1"))
adm2006<-read_fst("/nfs/home/J/jok8845/shared_space/ci3_health_data/medicare/gen_admission/1999_2016/targeted_conditions/cache_data/admissions_by_year/admissions_2006.fst",columns = c("QID","ADATE","DDATE","DIAG1"))
adm2007<-read_fst("/nfs/home/J/jok8845/shared_space/ci3_health_data/medicare/gen_admission/1999_2016/targeted_conditions/cache_data/admissions_by_year/admissions_2007.fst",columns = c("QID","ADATE","DDATE","DIAG1"))
adm2008<-read_fst("/nfs/home/J/jok8845/shared_space/ci3_health_data/medicare/gen_admission/1999_2016/targeted_conditions/cache_data/admissions_by_year/admissions_2008.fst",columns = c("QID","ADATE","DDATE","DIAG1"))
adm2009<-read_fst("/nfs/home/J/jok8845/shared_space/ci3_health_data/medicare/gen_admission/1999_2016/targeted_conditions/cache_data/admissions_by_year/admissions_2009.fst",columns = c("QID","ADATE","DDATE","DIAG1"))
adm2010<-read_fst("/nfs/home/J/jok8845/shared_space/ci3_health_data/medicare/gen_admission/1999_2016/targeted_conditions/cache_data/admissions_by_year/admissions_2010.fst",columns = c("QID","ADATE","DDATE","DIAG1"))
adm2011<-read_fst("/nfs/home/J/jok8845/shared_space/ci3_health_data/medicare/gen_admission/1999_2016/targeted_conditions/cache_data/admissions_by_year/admissions_2011.fst",columns = c("QID","ADATE","DDATE","DIAG1"))
adm2012<-read_fst("/nfs/home/J/jok8845/shared_space/ci3_health_data/medicare/gen_admission/1999_2016/targeted_conditions/cache_data/admissions_by_year/admissions_2012.fst",columns = c("QID","ADATE","DDATE","DIAG1"))
adm2013<-read_fst("/nfs/home/J/jok8845/shared_space/ci3_health_data/medicare/gen_admission/1999_2016/targeted_conditions/cache_data/admissions_by_year/admissions_2013.fst",columns = c("QID","ADATE","DDATE","DIAG1"))
adm2014<-read_fst("/nfs/home/J/jok8845/shared_space/ci3_health_data/medicare/gen_admission/1999_2016/targeted_conditions/cache_data/admissions_by_year/admissions_2014.fst",columns = c("QID","ADATE","DDATE","DIAG1"))
adm2015<-read_fst("/nfs/home/J/jok8845/shared_space/ci3_health_data/medicare/gen_admission/1999_2016/targeted_conditions/cache_data/admissions_by_year/admissions_2015.fst",columns = c("QID","ADATE","DDATE","DIAG1"))
adm2016<-read_fst("/nfs/home/J/jok8845/shared_space/ci3_health_data/medicare/gen_admission/1999_2016/targeted_conditions/cache_data/admissions_by_year/admissions_2016.fst",columns = c("QID","ADATE","DDATE","DIAG1"))

admissions<-rbind(adm2000,adm2001,adm2002,adm2003,adm2004,adm2005,adm2006,adm2007,adm2008,adm2009,adm2010,adm2011,adm2012,adm2013,adm2014,adm2015,adm2016)
rm(adm2000,adm2001,adm2002,adm2003,adm2004,adm2005,adm2006,adm2007,adm2008,adm2009,adm2010,adm2011,adm2012,adm2013,adm2014,adm2015,adm2016)
gc()
admissions<-as.data.table(admissions)
admissions[, ADATE := dmy(ADATE)]
admissions[, DDATE := dmy(DDATE)]
admissions[, year := year(ADATE)] #create year row
admissions <- admissions[year %in% 2000:2016] #only keep admissions with admission date in year (2000-2016)

## Process ICD9 codes
admissions[DDATE < "2015-10-01", res := DIAG1 %in% res_icd9]

## process ICD 10 Codes
admissions[DDATE >= "2015-10-01", res := DIAG1 %in% res_icd10]

##keep only cvd/chd/cbv admissions
admissions <- admissions[res %in% TRUE]
nrow(admissions)
length(unique(admissions$QID))
##############################################################################################
#merge with individuals from cohortto get only admissions for the years that they are included (no HMO coverage)
##############################################################################################

#mdy_data <- read_data(old_merged, years = 2000:2016, columns = c("qid","year"))
adm2000<-read_fst("/nfs/home/J/jok8845/shared_space/ci3_health_data/medicare/gen_admission/1999_2016/Klompmaker/cache_data/correct_follow_up_age_entry2/confounder_exposure_merged_nodups_health_2000.fst", columns = c("qid","year"))
adm2001<-read_fst("/nfs/home/J/jok8845/shared_space/ci3_health_data/medicare/gen_admission/1999_2016/Klompmaker/cache_data/correct_follow_up_age_entry2/confounder_exposure_merged_nodups_health_2001.fst", columns = c("qid","year"))
adm2002<-read_fst("/nfs/home/J/jok8845/shared_space/ci3_health_data/medicare/gen_admission/1999_2016/Klompmaker/cache_data/correct_follow_up_age_entry2/confounder_exposure_merged_nodups_health_2002.fst", columns = c("qid","year"))
adm2003<-read_fst("/nfs/home/J/jok8845/shared_space/ci3_health_data/medicare/gen_admission/1999_2016/Klompmaker/cache_data/correct_follow_up_age_entry2/confounder_exposure_merged_nodups_health_2003.fst", columns = c("qid","year"))
adm2004<-read_fst("/nfs/home/J/jok8845/shared_space/ci3_health_data/medicare/gen_admission/1999_2016/Klompmaker/cache_data/correct_follow_up_age_entry2/confounder_exposure_merged_nodups_health_2004.fst", columns = c("qid","year"))
adm2005<-read_fst("/nfs/home/J/jok8845/shared_space/ci3_health_data/medicare/gen_admission/1999_2016/Klompmaker/cache_data/correct_follow_up_age_entry2/confounder_exposure_merged_nodups_health_2005.fst", columns = c("qid","year"))
adm2006<-read_fst("/nfs/home/J/jok8845/shared_space/ci3_health_data/medicare/gen_admission/1999_2016/Klompmaker/cache_data/correct_follow_up_age_entry2/confounder_exposure_merged_nodups_health_2006.fst", columns = c("qid","year"))
adm2007<-read_fst("/nfs/home/J/jok8845/shared_space/ci3_health_data/medicare/gen_admission/1999_2016/Klompmaker/cache_data/correct_follow_up_age_entry2/confounder_exposure_merged_nodups_health_2007.fst", columns = c("qid","year"))
adm2008<-read_fst("/nfs/home/J/jok8845/shared_space/ci3_health_data/medicare/gen_admission/1999_2016/Klompmaker/cache_data/correct_follow_up_age_entry2/confounder_exposure_merged_nodups_health_2008.fst", columns = c("qid","year"))
adm2009<-read_fst("/nfs/home/J/jok8845/shared_space/ci3_health_data/medicare/gen_admission/1999_2016/Klompmaker/cache_data/correct_follow_up_age_entry2/confounder_exposure_merged_nodups_health_2009.fst", columns = c("qid","year"))
adm2010<-read_fst("/nfs/home/J/jok8845/shared_space/ci3_health_data/medicare/gen_admission/1999_2016/Klompmaker/cache_data/correct_follow_up_age_entry2/confounder_exposure_merged_nodups_health_2010.fst", columns = c("qid","year"))
adm2011<-read_fst("/nfs/home/J/jok8845/shared_space/ci3_health_data/medicare/gen_admission/1999_2016/Klompmaker/cache_data/correct_follow_up_age_entry2/confounder_exposure_merged_nodups_health_2011.fst", columns = c("qid","year"))
adm2012<-read_fst("/nfs/home/J/jok8845/shared_space/ci3_health_data/medicare/gen_admission/1999_2016/Klompmaker/cache_data/correct_follow_up_age_entry2/confounder_exposure_merged_nodups_health_2012.fst", columns = c("qid","year"))
adm2013<-read_fst("/nfs/home/J/jok8845/shared_space/ci3_health_data/medicare/gen_admission/1999_2016/Klompmaker/cache_data/correct_follow_up_age_entry2/confounder_exposure_merged_nodups_health_2013.fst", columns = c("qid","year"))
adm2014<-read_fst("/nfs/home/J/jok8845/shared_space/ci3_health_data/medicare/gen_admission/1999_2016/Klompmaker/cache_data/correct_follow_up_age_entry2/confounder_exposure_merged_nodups_health_2014.fst", columns = c("qid","year"))
adm2015<-read_fst("/nfs/home/J/jok8845/shared_space/ci3_health_data/medicare/gen_admission/1999_2016/Klompmaker/cache_data/correct_follow_up_age_entry2/confounder_exposure_merged_nodups_health_2015.fst", columns = c("qid","year"))
adm2016<-read_fst("/nfs/home/J/jok8845/shared_space/ci3_health_data/medicare/gen_admission/1999_2016/Klompmaker/cache_data/correct_follow_up_age_entry2/confounder_exposure_merged_nodups_health_2016.fst", columns = c("qid","year"))

mdy_data<-rbind(adm2000,adm2001,adm2002,adm2003,adm2004,adm2005,adm2006,adm2007,adm2008,adm2009,adm2010,adm2011,adm2012,adm2013,adm2014,adm2015,adm2016)
rm(adm2000,adm2001,adm2002,adm2003,adm2004,adm2005,adm2006,adm2007,adm2008,adm2009,adm2010,adm2011,adm2012,adm2013,adm2014,adm2015,adm2016)
gc()
mdy_data<-as.data.table(mdy_data)
setnames(mdy_data, "qid", "QID")
nobs<-length(unique(admissions$QID))
admissions<-merge(admissions, mdy_data, by = c("QID","year"),all.x=F,all.y=F)
ndropped_obs <- nobs - length(unique(admissions$QID))
print(paste("dropped", ndropped_obs, "individuals that are not included in the cohort"))

write_fst(admissions, "/nfs/home/J/jok8845/shared_space/ci3_health_data/medicare/gen_admission/1999_2016/Klompmaker/admission_data/all_res_20002016.fst")
