
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
#cvd_icd9 <- expand_range("390","459")
cvd_icd9 <- c("390","391","3910","3911","3912","3918","3919","392","3920","3929","393","394","3940", 
              "3941","3942","3949","395","3950","3951","3952","3959","396","3960","3961","3962","3963", 
              "3968","3969","397","3970","3971","3979","398","3980","3989","39890","39891","39899","401",  
              "4010","4011","4019","402","4020","40200","40201","4021","40210","40211","4029","40290","40291",
              "403","4030","40300","40301","4031","40310","40311","4039","40390","40391","404","4040","40400",
              "40401","40402","40403","4041","40410","40411","40412","40413","4049","40490","40491","40492","40493",
              "405","4050","40501","40509","4051","40511","40519","4059","40591","40599","410","4100","41000",
              "41001","41002","4101","41010","41011","41012","4102","41020","41021","41022","4103","41030","41031",
              "41032","4104","41040","41041","41042","4105","41050","41051","41052","4106","41060","41061","41062",
              "4107","41070","41071","41072","4108","41080","41081","41082","4109","41090","41091","41092","411",
              "4110","4111","4118","41181","41189","412","413","4130","4131","4139","414","4140","41400",
              "41401","41402","41403","41404","41405","41406","41407","4141","41410","41411","41412","41419","4142", 
              "4143","4144","4148","4149","415","4150","4151","41511","41512","41513","41519","416","4160", 
              "4161","4162","4168","4169","417","4170","4171","4178","4179","420","4200","4209","42090",
              "42091","42099","421","4210","4211","4219","422","4220","4229","42290","42291","42292","42293",
              "42299","423","4230","4231","4232","4233","4238","4239","424","4240","4241","4242","4243", 
              "4249","42490","42491","42499","425","4250","4251","42511","42518","4252","4253","4254","4255", 
              "4257","4258","4259","426","4260","4261","42610","42611","42612","42613","4262","4263","4264", 
              "4265","42650","42651","42652","42653","42654","4266","4267","4268","42681","42682","42689","4269", 
              "427","4270","4271","4272","4273","42731","42732","4274","42741","42742","4275","4276","42760",
              "42761","42769","4278","42781","42789","4279","428","4280","4281","4282","42820","42821","42822",
              "42823","4283","42830","42831","42832","42833","4284","42840","42841","42842","42843","4289","429",  
              "4290","4291","4292","4293","4294","4295","4296","4297","42971","42979","4298","42981","42982",
              "42983","42989","4299","430","431","432","4320","4321","4329","433","4330","43300","43301",
              "4331","43310","43311","4332","43320","43321","4333","43330","43331","4338","43380","43381","4339", 
              "43390","43391","434","4340","43400","43401","4341","43410","43411","4349","43490","43491","435",  
              "4350","4351","4352","4353","4358","4359","436","437","4370","4371","4372","4373","4374", 
              "4375","4376","4377","4378","4379","438","4380","4381","43810","43811","43812","43813","43814",
              "43819","4382","43820","43821","43822","4383","43830","43831","43832","4384","43840","43841","43842",
              "4385","43850","43851","43852","43853","4386","4387","4388","43881","43882","43883","43884","43885",
              "43889","4389","440","4400","4401","4402","44020","44021","44022","44023","44024","44029","4403",
              "44030","44031","44032","4404","4408","4409","441","4410","44100","44101","44102","44103","4411",
              "4412","4413","4414","4415","4416","4417","4419","442","4420","4421","4422","4423","4428", 
              "44281","44282","44283","44284","44289","4429","443","4430","4431","4432","44321","44322","44323",
              "44324","44329","4438","44381","44382","44389","4439","444","4440","44401","44409","4441","4442", 
              "44421","44422","4448","44481","44489","4449","445","4450","44501","44502","4458","44581","44589",
              "446","4460","4461","4462","44620","44621","44629","4463","4464","4465","4466","4467","447",  
              "4470","4471","4472","4473","4474","4475","4476","4477","44770","44771","44772","44773","4478", 
              "4479","448","4480","4481","4489","449","451","4510","4511","45111","45119","4512","4518", 
              "45181","45182","45183","45184","45189","4519","452","453","4530","4531","4532","4533","4534", 
              "45340","45341","45342","4535","45350","45351","45352","4536","4537","45371","45372","45373","45374",
              "45375","45376","45377","45379","4538","45381","45382","45383","45384","45385","45386","45387","45389",
              "4539","454","4540","4541","4542","4548","4549","455","4550","4551","4552","4553","4554", 
              "4555","4556","4557","4558","4559","456","4560","4561","4562","45620","45621","4563","4564", 
              "4565","4566","4568","457","4570","4571","4572","4578","4579","458","4580","4581","4582", 
              "45821","45829","4588","4589","459","4590","4591","45910","45911","45912","45913","45919","4592", 
              "4593","45930","45931","45932","45933","45939","4598","45981","45989","4599") 

#cvd_icd10 <- expand_range("J00","J99")
cvd_icd10 <- c("I00","I01","I010","I011","I012","I018","I019","I02","I020","I029","I05","I050",  
               "I051","I052","I058","I059","I06","I060","I061","I062","I068","I069","I07","I070",  
               "I071","I072","I078","I079","I08","I080","I081","I082","I083","I088","I089","I09",   
               "I090","I091","I092","I098","I0981","I0989","I099","I10","I11","I110","I119","I12",   
               "I120","I129","I13","I130","I131","I1310","I1311","I132","I15","I150","I151","I152",  
               "I158","I159","I20","I200","I201","I208","I209","I21","I210","I2101","I2102","I2109", 
               "I211","I2111","I2119","I212","I2121","I2129","I213","I214","I22","I220","I221","I222",  
               "I228","I229","I23","I230","I231","I232","I233","I234","I235","I236","I237","I238",  
               "I24","I240","I241","I248","I249","I25","I251","I2510","I2511","I25110","I25111","I25118",
               "I25119","I252","I253","I254","I2541","I2542","I255","I256","I257","I2570","I25700","I25701",
               "I25708","I25709","I2571","I25710","I25711","I25718","I25719","I2572","I25720","I25721","I25728","I25729",
               "I2573","I25730","I25731","I25738","I25739","I2575","I25750","I25751","I25758","I25759","I2576","I25760",
               "I25761","I25768","I25769","I2579","I25790","I25791","I25798","I25799","I258","I2581","I25810","I25811",
               "I25812","I2582","I2583","I2584","I2589","I259","I26","I260","I2601","I2602","I2609","I269",  
               "I2690","I2692","I2699","I27","I270","I271","I272","I278","I2781","I2782","I2789","I279",  
               "I28","I280","I281","I288","I289","I30","I300","I301","I308","I309","I31","I310",  
               "I311","I312","I313","I314","I318","I319","I32","I33","I330","I339","I34","I340",  
               "I341","I342","I348","I349","I35","I350","I351","I352","I358","I359","I36","I360",  
               "I361","I362","I368","I369","I37","I370","I371","I372","I378","I379","I38","I39",   
               "I40","I400","I401","I408","I409","I41","I42","I420","I421","I422","I423","I424",  
               "I425","I426","I427","I428","I429","I43","I44","I440","I441","I442","I443","I4430", 
               "I4439","I444","I445","I446","I4460","I4469","I447","I45","I450","I451","I4510","I4519", 
               "I452","I453","I454","I455","I456","I458","I4581","I4589","I459","I46","I462","I468",  
               "I469","I47","I470","I471","I472","I479","I48","I480","I481","I482","I483","I484",  
               "I489","I4891","I4892","I49","I490","I4901","I4902","I491","I492","I493","I494","I4940", 
               "I4949","I495","I498","I499","I50","I501","I502","I5020","I5021","I5022","I5023","I503",  
               "I5030","I5031","I5032","I5033","I504","I5040","I5041","I5042","I5043","I509","I51","I510",  
               "I511","I512","I513","I514","I515","I517","I518","I5181","I5189","I519","I52","I60",   
               "I600","I6000","I6001","I6002","I601","I6010","I6011","I6012","I602","I6020","I6021","I6022", 
               "I603","I6030","I6031","I6032","I604","I605","I6050","I6051","I6052","I606","I607","I608",  
               "I609","I61","I610","I611","I612","I613","I614","I615","I616","I618","I619","I62",   
               "I620","I6200","I6201","I6202","I6203","I621","I629","I63","I630","I6300","I6301","I63011",
               "I63012","I63019","I6302","I6303","I63031","I63032","I63039","I6309","I631","I6310","I6311","I63111",
               "I63112","I63119","I6312","I6313","I63131","I63132","I63139","I6319","I632","I6320","I6321","I63211",
               "I63212","I63219","I6322","I6323","I63231","I63232","I63239","I6329","I633","I6330","I6331","I63311",
               "I63312","I63319","I6332","I63321","I63322","I63329","I6333","I63331","I63332","I63339","I6334","I63341",
               "I63342","I63349","I6339","I634","I6340","I6341","I63411","I63412","I63419","I6342","I63421","I63422",
               "I63429","I6343","I63431","I63432","I63439","I6344","I63441","I63442","I63449","I6349","I635","I6350", 
               "I6351","I63511","I63512","I63519","I6352","I63521","I63522","I63529","I6353","I63531","I63532","I63539",
               "I6354","I63541","I63542","I63549","I6359","I636","I638","I639","I65","I650","I6501","I6502", 
               "I6503","I6509","I651","I652","I6521","I6522","I6523","I6529","I658","I659","I66","I660",  
               "I6601","I6602","I6603","I6609","I661","I6611","I6612","I6613","I6619","I662","I6621","I6622", 
               "I6623","I6629","I663","I668","I669","I67","I670","I671","I672","I673","I674","I675",  
               "I676","I677","I678","I6781","I6782","I6783","I6784","I67841","I67848","I6789","I679","I68",   
               "I680","I682","I688","I69","I690","I6900","I6901","I6902","I69020","I69021","I69022","I69023",
               "I69028","I6903","I69031","I69032","I69033","I69034","I69039","I6904","I69041","I69042","I69043","I69044",
               "I69049","I6905","I69051","I69052","I69053","I69054","I69059","I6906","I69061","I69062","I69063","I69064",
               "I69065","I69069","I6909","I69090","I69091","I69092","I69093","I69098","I691","I6910","I6911","I6912", 
               "I69120","I69121","I69122","I69123","I69128","I6913","I69131","I69132","I69133","I69134","I69139","I6914", 
               "I69141","I69142","I69143","I69144","I69149","I6915","I69151","I69152","I69153","I69154","I69159","I6916", 
               "I69161","I69162","I69163","I69164","I69165","I69169","I6919","I69190","I69191","I69192","I69193","I69198",
               "I692","I6920","I6921","I6922","I69220","I69221","I69222","I69223","I69228","I6923","I69231","I69232",
               "I69233","I69234","I69239","I6924","I69241","I69242","I69243","I69244","I69249","I6925","I69251","I69252",
               "I69253","I69254","I69259","I6926","I69261","I69262","I69263","I69264","I69265","I69269","I6929","I69290",
               "I69291","I69292","I69293","I69298","I693","I6930","I6931","I6932","I69320","I69321","I69322","I69323",
               "I69328","I6933","I69331","I69332","I69333","I69334","I69339","I6934","I69341","I69342","I69343","I69344",
               "I69349","I6935","I69351","I69352","I69353","I69354","I69359","I6936","I69361","I69362","I69363","I69364",
               "I69365","I69369","I6939","I69390","I69391","I69392","I69393","I69398","I698","I6980","I6981","I6982", 
               "I69820","I69821","I69822","I69823","I69828","I6983","I69831","I69832","I69833","I69834","I69839","I6984", 
               "I69841","I69842","I69843","I69844","I69849","I6985","I69851","I69852","I69853","I69854","I69859","I6986", 
               "I69861","I69862","I69863","I69864","I69865","I69869","I6989","I69890","I69891","I69892","I69893","I69898",
               "I699","I6990","I6991","I6992","I69920","I69921","I69922","I69923","I69928","I6993","I69931","I69932",
               "I69933","I69934","I69939","I6994","I69941","I69942","I69943","I69944","I69949","I6995","I69951","I69952",
               "I69953","I69954","I69959","I6996","I69961","I69962","I69963","I69964","I69965","I69969","I6999","I69990",
               "I69991","I69992","I69993","I69998","I70","I700","I701","I702","I7020","I70201","I70202","I70203",
               "I70208","I70209","I7021","I70211","I70212","I70213","I70218","I70219","I7022","I70221","I70222","I70223",
               "I70228","I70229","I7023","I70231","I70232","I70233","I70234","I70235","I70238","I70239","I7024","I70241",
               "I70242","I70243","I70244","I70245","I70248","I70249","I7025","I7026","I70261","I70262","I70263","I70268",
               "I70269","I7029","I70291","I70292","I70293","I70298","I70299","I703","I7030","I70301","I70302","I70303",
               "I70308","I70309","I7031","I70311","I70312","I70313","I70318","I70319","I7032","I70321","I70322","I70323",
               "I70328","I70329","I7033","I70331","I70332","I70333","I70334","I70335","I70338","I70339","I7034","I70341",
               "I70342","I70343","I70344","I70345","I70348","I70349","I7035","I7036","I70361","I70362","I70363","I70368",
               "I70369","I7039","I70391","I70392","I70393","I70398","I70399","I704","I7040","I70401","I70402","I70403",
               "I70408","I70409","I7041","I70411","I70412","I70413","I70418","I70419","I7042","I70421","I70422","I70423",
               "I70428","I70429","I7043","I70431","I70432","I70433","I70434","I70435","I70438","I70439","I7044","I70441",
               "I70442","I70443","I70444","I70445","I70448","I70449","I7045","I7046","I70461","I70462","I70463","I70468",
               "I70469","I7049","I70491","I70492","I70493","I70498","I70499","I705","I7050","I70501","I70502","I70503",
               "I70508","I70509","I7051","I70511","I70512","I70513","I70518","I70519","I7052","I70521","I70522","I70523",
               "I70528","I70529","I7053","I70531","I70532","I70533","I70534","I70535","I70538","I70539","I7054","I70541",
               "I70542","I70543","I70544","I70545","I70548","I70549","I7055","I7056","I70561","I70562","I70563","I70568",
               "I70569","I7059","I70591","I70592","I70593","I70598","I70599","I706","I7060","I70601","I70602","I70603",
               "I70608","I70609","I7061","I70611","I70612","I70613","I70618","I70619","I7062","I70621","I70622","I70623",
               "I70628","I70629","I7063","I70631","I70632","I70633","I70634","I70635","I70638","I70639","I7064","I70641",
               "I70642","I70643","I70644","I70645","I70648","I70649","I7065","I7066","I70661","I70662","I70663","I70668","I70669","I7069","I70691",
               "I70692","I70693","I70698","I70699","I707","I7070","I70701","I70702","I70703","I70708","I70709","I7071", 
               "I70711","I70712","I70713","I70718","I70719","I7072","I70721","I70722","I70723","I70728","I70729","I7073", 
               "I70731","I70732","I70733","I70734","I70735","I70738","I70739","I7074","I70741","I70742","I70743","I70744",
               "I70745","I70748","I70749","I7075","I7076","I70761","I70762","I70763","I70768","I70769","I7079","I70791",
               "I70792","I70793","I70798","I70799","I708","I709","I7090","I7091","I7092","I71","I710","I7100", 
               "I7101","I7102","I7103","I711","I712","I713","I714","I715","I716","I718","I719","I72",   
               "I720","I721","I722","I723","I724","I728","I729","I73","I730","I7300","I7301","I731",  
               "I738","I7381","I7389","I739","I74","I740","I7401","I7409","I741","I7410","I7411","I7419", 
               "I742","I743","I744","I745","I748","I749","I75","I750","I7501","I75011","I75012","I75013",
               "I75019","I7502","I75021","I75022","I75023","I75029","I758","I7581","I7589","I76","I77","I770",  
               "I771","I772","I773","I774","I775","I776","I777","I7771","I7772","I7773","I7774","I7779", 
               "I778","I7781","I77810","I77811","I77812","I77819","I7789","I779","I78","I780","I781","I788",  
               "I789","I79","I790","I791","I798","I80","I800","I8000","I8001","I8002","I8003","I801",  
               "I8010","I8011","I8012","I8013","I802","I8020","I80201","I80202","I80203","I80209","I8021","I80211",
               "I80212","I80213","I80219","I8022","I80221","I80222","I80223","I80229","I8023","I80231","I80232","I80233",
               "I80239","I8029","I80291","I80292","I80293","I80299","I803","I808","I809","I81","I82","I820",  
               "I821","I822","I8221","I82210","I82211","I8222","I82220","I82221","I8229","I82290","I82291","I823",  
               "I824","I8240","I82401","I82402","I82403","I82409","I8241","I82411","I82412","I82413","I82419","I8242", 
               "I82421","I82422","I82423","I82429","I8243","I82431","I82432","I82433","I82439","I8244","I82441","I82442",
               "I82443","I82449","I8249","I82491","I82492","I82493","I82499","I824Y","I824Y1","I824Y2","I824Y3","I824Y9",
               "I824Z","I824Z1","I824Z2","I824Z3","I824Z9","I825","I8250","I82501","I82502","I82503","I82509","I8251",
               "I82511","I82512","I82513","I82519","I8252","I82521","I82522","I82523","I82529","I8253","I82531","I82532",
               "I82533","I82539","I8254","I82541","I82542","I82543","I82549","I8259","I82591","I82592","I82593","I82599",
               "I825Y","I825Y1","I825Y2","I825Y3","I825Y9","I825Z","I825Z1","I825Z2","I825Z3","I825Z9","I826","I8260",
               "I82601","I82602","I82603","I82609","I8261","I82611","I82612","I82613","I82619","I8262","I82621","I82622",
               "I82623","I82629","I827","I8270","I82701","I82702","I82703","I82709","I8271","I82711","I82712","I82713",
               "I82719","I8272","I82721","I82722","I82723","I82729","I82A","I82A1","I82A11","I82A12","I82A13","I82A19",
               "I82A2","I82A21","I82A22","I82A23","I82A29","I82B","I82B1","I82B11","I82B12","I82B13","I82B19","I82B2",
               "I82B21","I82B22","I82B23","I82B29","I82C","I82C1","I82C11","I82C12","I82C13","I82C19","I82C2","I82C21",
               "I82C22","I82C23","I82C29","I828","I8281","I82811","I82812","I82813","I82819","I8289","I82890","I82891",
               "I829","I8290","I8291","I83","I830","I8300","I83001","I83002","I83003","I83004","I83005","I83008",
               "I83009","I8301","I83011","I83012","I83013","I83014","I83015","I83018","I83019","I8302","I83021","I83022",
               "I83023","I83024","I83025","I83028","I83029","I831","I8310","I8311","I8312","I832","I8320","I83201",
               "I83202","I83203","I83204","I83205","I83208","I83209","I8321","I83211","I83212","I83213","I83214","I83215",
               "I83218","I83219","I8322","I83221","I83222","I83223","I83224","I83225","I83228","I83229","I838","I8381", 
               "I83811","I83812","I83813","I83819","I8389","I83891","I83892","I83893","I83899","I839","I8390","I8391", 
               "I8392","I8393","I85","I850","I8500","I8501","I851","I8510","I8511","I86","I860","I861",  
               "I862","I863","I864","I868","I87","I870","I8700","I87001","I87002","I87003","I87009","I8701", 
               "I87011","I87012","I87013","I87019","I8702","I87021","I87022","I87023","I87029","I8703","I87031","I87032",
               "I87033","I87039","I8709","I87091","I87092","I87093","I87099","I871","I872","I873","I8730","I87301",
               "I87302","I87303","I87309","I8731","I87311","I87312","I87313","I87319","I8732","I87321","I87322","I87323",
               "I87329","I8733","I87331","I87332","I87333","I87339","I8739","I87391","I87392","I87393","I87399","I878",  
               "I879","I88","I880","I881","I888","I889","I89","I890","I891","I898","I899","I95",   
               "I950","I951","I952","I953","I958","I9581","I9589","I959","I96","I97","I970","I971",  
               "I9711","I97110","I97111","I9712","I97120","I97121","I9713","I97130","I97131","I9719","I97190","I97191",
               "I972","I973","I974","I9741","I97410","I97411","I97418","I9742","I975","I9751","I9752","I976",  
               "I9761","I97610","I97611","I97618","I9762","I977","I9771","I97710","I97711","I9779","I97790","I97791",
               "I978","I9781","I97810","I97811","I9782","I97820","I97821","I9788","I9789","I99","I998","I999")

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
admissions[DDATE < "2015-10-01", cvd := DIAG1 %in% cvd_icd9]

## process ICD 10 Codes
admissions[DDATE >= "2015-10-01", cvd := DIAG1 %in% cvd_icd10]

##keep only cvd/chd/cbv admissions
admissions <- admissions[cvd %in% TRUE]
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

write_fst(admissions, "/nfs/home/J/jok8845/shared_space/ci3_health_data/medicare/gen_admission/1999_2016/Klompmaker/admission_data/all_cvd_20002016.fst")
