##       author: Ista Zahn
##      created: April 2019
##      purpose: merge exposure and confounder
##
## requirements: about 20 GB of memory

nthreads <- 4
#cachedir <- "../data/cache_data/"
covar_dir <- "/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/data/confounders/"

## load packages and set options
options(fst_threads = nthreads)
library(data.table)
library(fst)
setDTthreads(nthreads)
threads_fst(nr_of_threads = nthreads)

## specify input data locations and variable types
input_files <- c(
  pm25 = 
    "~/shared_space/ci3_exposure/pm25/whole_us/annual/zipcode/qd_predictions_ensemble/ywei_aggregation/all_years.csv",
  no2 = 
    "~/shared_space/ci3_exposure/no2/whole_us/annual/zipcode/qd_predictions_ensemble/ywei_aggregations/all_years.csv",
  ozone =
    "~/shared_space/ci3_exposure/ozone/whole_us/annual/zipcode/requaia_predictions/ywei_aggregation/all_years.csv",
  census =
    "~/shared_space/ci3_confounders/data_for_analysis/prepped_census/old_data/census_interpolated_zips.csv",
  brfss =
    "~/shared_space/ci3_confounders/data_for_analysis/prepped_brfss/brfss_interpolated.csv",
  dartmouth =
    "~/shared_space/ci3_confounders/data_for_analysis/prepped_dartmouth/dartmouth_interpolated.csv",    
  seasonal_temperature =
    "/nfs/home/J/jok8845/shared_space/ci3_analysis/medicare_temperature_humidity/data/seasonal_exposures/temperature/temperature_rhumidity_seasonal_mean_sd_zipcode_combined.csv",
  seasonal_sp_humidity =
    "/nfs/home/J/jok8845/shared_space/ci3_analysis/medicare_temperature_humidity/data/seasonal_exposures/humidity/sp_humidity_seasonal_zipcode.csv",
  ndvi =
    "/nfs/home/J/jok8845/shared_space/ci3_confounders/data_for_analysis/earth_engine/NDVI/Landsat/combined_ndvi_seasonal_zip20002016.csv",
  occur_blue_space =
    "/nfs/home/J/jok8845/shared_space/ci3_confounders/data_for_analysis/earth_engine/blue_space/combined_water_occur_zip20002016.csv",
  trns_blue_space =
    "/nfs/home/J/jok8845/shared_space/ci3_confounders/data_for_analysis/earth_engine/blue_space/combined_water_trns_zip20002016.csv",
  parks = 
    "/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/parks/combined_park_zip20002016.csv",
  walkability =
    "/nfs/home/J/jok8845/shared_space/ci3_analysis/nature_medicare/data/walkability/walkability.csv"
)

input_types <- list(
  pm25 =
    c(year = "integer",
      ZIP = "integer",
      pm25 = "numeric"),
  no2 =
    c(year = "integer",
      ZIP = "integer",
      no2 = "numeric"),
  ozone =
    c(year = "integer",
      ZIP = "integer",
      ozone = "numeric"), 
  census =
    c(zcta = "integer",
      year = "integer",
      poverty = "numeric", 
      popdensity = "numeric",
      medianhousevalue = "numeric",
      pct_blk = "numeric", 
      medhouseholdincome = "numeric",
      pct_owner_occ = "numeric",
      hispanic = "numeric", 
      education = "numeric",
      ZIP = "integer"), 
  brfss =
    c(fips = "integer",
      smoke_rate = "numeric", 
      mean_bmi = "numeric",
      year = "integer",
      ZIP = "integer"),
  dartmouth   =
    c(fips = "integer",
      amb_visit_pct = "numeric",
      a1c_exm_pct = "numeric",
      year = "integer",
      ZIP = "integer"),
  seasonal_temperature =
    c(ZIP = "integer",
      year = "integer",
      summer_tmmx = "numeric",
      summer_sd_tmmx = "numeric",
      summer_rmax = "numeric",
      summer_sd_rmax = "numeric",
      summer_pr = "numeric",
      summer_sd_pr = "numeric",
      winter_tmmx = "numeric",
      winter_sd_tmmx = "numeric",
      winter_rmax = "numeric",
      winter_sd_rmax = "numeric",
      winter_pr = "numeric",
      winter_sd_pr = "numeric"),
  seasonal_sp_humidity =
    c(ZIP = "integer",
      year = "integer",
      summer_sph = "numeric",
      summer_sd_sph = "numeric",
      winter_sph = "numeric",
      winter_sd_sph = "numeric"),
  ndvi =
    c(NDVI_fall = "numeric",
      NDVI_summer = "numeric",
      NDVI_spring = "numeric",
      NDVI_winter = "numeric",
      NDVI_year = "numeric",
      ZIP = "integer",
      year = "numeric"),
  occur_blue_space =
    c(ZIP = "integer",
      year = "numeric",
      occur_bluespace_zip = "numeric",
      occur_bluespace_zip_300m = "numeric",
      occur_bluespace_zip_1000m = "numeric"),
  trns_blue_space =
    c(ZIP = "integer",
      year = "numeric",
      trns_bluespace_zip = "numeric",
      trns_bluespace_zip_300m = "numeric",
      trns_bluespace_zip_1000m = "numeric"),
  parks =
    c(park = "numeric",
      ZIP = "integer",
      year = "numeric"),
  walkability =
    c(walkability = "numeric",
      walkability_annual = "numeric",
      ZIP = "integer",
      year = "numeric"))

## read input data
input_data <- lapply(
  names(input_files),
  function(input) {
    fread(input_files[[input]], colClasses = input_types[[input]])
  }
)
names(input_data) <- names(input_files)

## lowercase names for convenience
for(the_name in names(input_data)) {
  setnames(input_data[[the_name]],
           tolower(names(input_data[[the_name]])))
}

## cleanup
input_data[["brfss"]][, fips.brfss := fips]
input_data[["brfss"]][, fips := NULL]
input_data[["census"]][, v1 := NULL]
input_data[["dartmouth"]][, fips.dartmouth := fips]
input_data[["dartmouth"]][, fips := NULL]
input_data[["occur_blue_space"]][, occur_bs := occur_bluespace_zip]
input_data[["occur_blue_space"]][, occur_bs_300m := occur_bluespace_zip_300m]
input_data[["occur_blue_space"]][, occur_bs_1000m := occur_bluespace_zip_1000m]
input_data[["occur_blue_space"]][, occur_bluespace_zip := NULL]
input_data[["occur_blue_space"]][, occur_bluespace_zip_300m := NULL]
input_data[["occur_blue_space"]][, occur_bluespace_zip_1000m := NULL]
input_data[["trns_blue_space"]][, trns_bs := trns_bluespace_zip]
input_data[["trns_blue_space"]][, trns_bs_300m := trns_bluespace_zip_300m]
input_data[["trns_blue_space"]][, trns_bs_1000m := trns_bluespace_zip_1000m]
input_data[["trns_blue_space"]][, trns_bluespace_zip := NULL]
input_data[["trns_blue_space"]][, trns_bluespace_zip_300m := NULL]
input_data[["trns_blue_space"]][, trns_bluespace_zip_1000m := NULL]

## check for duplicates. 
dup_check <- sapply(
  input_data[c("pm25",
               "ozone",
               "no2",
               "census",
               "brfss",
               "dartmouth",
               "seasonal_temperature",
               "seasonal_sp_humidity",
               "ndvi",
               "occur_blue_space",
               "trns_blue_space",
               "parks",
               "walkability")],
  anyDuplicated, by = c("year", "zip"))

dup_check

## merge exposures and covariates
print("mergeing pm25 and ozone")
exp_covar <- merge(input_data[["pm25"]], input_data[["no2"]],
                   by = c("year", "zip"),
                   all = TRUE,
                   suffixes = c(".pm25", ".no2"))
exp_covar <- merge(exp_covar, input_data[["ozone"]],
                   by = c("year", "zip"),
                   all = TRUE,
                   suffixes = c(".pm25", ".ozone"))
exp_covar <- merge(exp_covar, input_data[["census"]],
                   by = c("year", "zip"),
                   all = TRUE,
                   suffixes = c(".pm25", ".census"))
exp_covar <- merge(exp_covar, input_data[["brfss"]],
                   by = c("year", "zip"),
                   all = TRUE,
                   suffixes = c(".pm25", ".brfss"))
exp_covar <- merge(exp_covar, input_data[["dartmouth"]],
                   by = c("year", "zip"),
                   all = TRUE,
                   suffixes = c(".xx", ".dartmouth"))
exp_covar <- merge(exp_covar, input_data[["seasonal_temperature"]],
                   by = c("year", "zip"),
                   all = TRUE,
                   suffixes = c(".xx", ".seasonal_temperature"))
exp_covar <- merge(exp_covar, input_data[["seasonal_sp_humidity"]],
                   by = c("year", "zip"),
                   all = TRUE,
                   suffixes = c(".xx", ".seasonal_sp_humidity"))
exp_covar <- merge(exp_covar, input_data[["ndvi"]],
                   by = c("year", "zip"),
                   all = TRUE,
                   suffixes = c(".xx", ".ndvi"))
exp_covar <- merge(exp_covar, input_data[["occur_blue_space"]],
                   by = c("year", "zip"),
                   all = TRUE,
                   suffixes = c(".xx", ".occur_blue_space"))
exp_covar <- merge(exp_covar, input_data[["trns_blue_space"]],
                   by = c("year", "zip"),
                   all = TRUE,
                   suffixes = c(".xx", ".trns_blue_space"))
exp_covar <- merge(exp_covar, input_data[["parks"]],
                   by = c("year", "zip"),
                   all = TRUE,
                   suffixes = c(".xx", ".parks"))
exp_covar <- merge(exp_covar, input_data[["walkability"]],
                   by = c("year", "zip"),
                   all = TRUE,
                   suffixes = c(".xx", ".walkability"))

#remove rows with only missing values
allmiss <- apply(exp_covar, 1, function(x) sum(is.na(x) | x == "")) == (ncol(exp_covar) - 2)
exp_covar <- exp_covar[!allmiss, ] #754489 - 754470  =  19 rows with only missings 

#keep years 2000-2016
exp_covar<-exp_covar[!(exp_covar$year<2000 | exp_covar$year>2016)] #754470-712989=41481 rows removed

## combine fips
exp_covar[, fips := fips.brfss]
exp_covar[is.na(fips), fips := fips.dartmouth]
exp_covar[, fips.brfss := NULL]
exp_covar[, fips.dartmouth := NULL]

## save merged covariates
print("writing out covariates files")
write_fst(exp_covar, paste0(covar_dir, "merged_covariates.fst"))
#fwrite(exp_covar, paste0(covar_dir, "merged_covariates.csv"))