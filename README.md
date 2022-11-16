# nature and CVD, RSD, ADRD and PD hospitalizations
================
This data set (4 separate data sets) contains aggregated data on first hospitalization events for cardiovascular (primary diagnosis code), respiratory (primary diagnosis code), Parkinson's (primary and secondary diagnosis code) and Alzheimer's and related dementia's (ADRD) disease outcomes (primary and seconday diagnosis code). Since this study is examining first hospitalizations, this necessitates creating separate data sets for each outcome as the at risk population is different for each. 

Within each data set, we have annual counts of first hospitalization events and the at risk population stratified by race, age at cohort entry, sex, medicaid eligibility, years present in the cohort, and zip code. This data is also joined with zip code level pm2.5, NO2, and Ozone (data produced by Joel Schwartz’s team), annual and seasonal temperature, annual and seasonal specific humidity, greenness, public park and blue space.

Zip code, race, sex, age, and dual eligibility were determined for each case based on the information in the patient summary file for that individual in the year of their admission. Follow up year is incremented by 1 for each year that an individual is on FFS Medicare for an entire year.

This data was calculated based on the enrollment information in ci3_health_data/medicare/mortality/1999_2016/wu/cache_data/merged_by_year_v2/ and on the hospital admission information in ci3_health_data/medicare/gen_admission/1999_2016/targeted_conditions/cache_data/admissions_by_year/.

Variable list
================
zip (integer): Integer representation of the 5 digit zip code

year (double): Year in which individuals are enrolled in Medicare/admitted to the hospital

race (integer): Race Code. 1 = White, 2 = Black, 3 = Other, 4 = Asian, 5 = Hispanic, 6 = Indigenous

sex (integer): Sex Code. 1 = Male, 2 = Female

dual (character): Dual Eligibility Indicator. 1 = Medicaid Eligible, 0 = Ineligible for Medicaid

followupyear (integer): Years in which an individual has been at-risk to have an event (i.e. enrolled in FFS medicare and not yet hospitalized). Follow up year of 1 indicates individuals appearing in the data for the first time.

hosp (integer): The number of individuals hospitalized for the first time for a given outcome in a given strata in a given zip code in a given year. (1 = yes, 0 = no)

time_count (double): Number of individuals at risk of first hospitalization for a given outcome in a given strata in a given zip code in a given year.

zcta (integer): Zip code tabulation area. Census data crosswalked to zip code using ZCTA

poverty (double): Poverty rate in a given zip code (calculated from census, annual value). Values for 2001-2010 interpolated.

popdensity (double): Annual Population Density in a given zip code (calculated from census). Values for 2001-2010 interpolated.

medianhousevalue (double): Annual Median House Value in a given zip code (calculated from census). Values for 2001-2010 interpolated.

pct_blk (double): Annual value of % of a zip codes popluation IDed as black (calculated from census). Values for 2001-2010 interpolated.

medhouseholdincome (double): Annual value of median household income in a given zip code (calculated from census). Values for 2001-2010 interpolated.

pct_owner_occ (double): Annual value of the % of housing in a given zip code occupied by its owner (calculated from census). Values for 2001-2010 interpolated.

hispanic (double): Annual value of % of a zip codes popluation IDed as hispanic (calculated from census). Values for 2001-2010 interpolated.

education (double): Annual value of % of zip codes pop over 65 that has graduated high school (calculated from census). Values for 2001-2010 interpolated.

population (double): Total population in a given zip code (calculated from census). Values for 2001-2010 interpolated.

pct_asian (double): Annual value of % of a zip codes popluation IDed as Asian (calculated from census). Values for 2001-2010 interpolated.

pct_native (double): Annual value of % of a zip codes popluation IDed as Indigenouos (calculated from census). Values for 2001-2010 interpolated.

pct_white (double): Annual value of % of a zip codes popluation IDed as White (calculated from census). Values for 2001-2010 interpolated.

smoke_rate (double): Percent of population defined by BRFSS as a current smoker. Calculated at the county level and linked to zipcodes

mean_bmi (double): Mean BMI in a county linked to the zipcode

pm25 (double): Annual average pm2.5 in the year of data. Note that this average includes values following hospitalization events.

no2 (double): Annual average NO2 in the year of data. Note that this average includes values following hospitalization events.

summer_tmmx (double): Summer average maximum temperature in the year of data.

summer_sph (double): Summer average specific humidity in the year of data.
 
ndvi_fall (double): Normalized Difference Vegetation Index based on Landsat 7 and Landsat 8 images (September-November) in the year of data

ndvi_winter (double): Normalized Difference Vegetation Index based on Landsat 7 and Landsat 8 images (Decemrber-February) in the year of data

ndvi_spring (double): Normalized Difference Vegetation Index based on Landsat 7 and Landsat 8 images (March-May) in the year of data

ndvi_summer (double): Normalized Difference Vegetation Index based on Landsat 7 and Landsat 8 images (June-August) in the year of data

ndvi_year (double): Normalized Difference Vegetation Index (average of winter, spring, summer, fall)

occur_bs (double): Blue space cover for each zip code based on the “Occurrence” band with a 50% threshold 

occur_bs_300m (double): Blue space cover for each zip code +300m buffer based on the “Occurrence” band with a 50% threshold

occur_bs_1000m (double):  Blue space cover for each zip code +1000m buffer based on the “Occurrence” band with a 50% threshold

trns_bs (double): Blue space cover for each zip code based on the “Transition” band with a 50% threshold

trns_bs_300m (double): Blue space cover for each zip code +300m buffer based on the “Transition” band with a 50% threshold

trns_bs_1000m (double): Blue space cover for each zip code +1000m buffer based on the “Transition” band with a 50% threshold

sc_density (double): street connectivity based on 2007

fips (integer): fips code

region (character): 4 regions of the US (Northeast, Midwest, West, South)

statecode (character): state code abbreviations

walkability (double): walkability (based on z-scores of population density, street connectivity density and business density) in 2000-2016

walkability annual (double): walkability (based on z-scores of population density, street connectivity density and business density) in the year of data

park (double): Public park cover 
