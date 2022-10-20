* second_stage_data_import imports raw data for each type and merges subtypes by year
clear
cd "C:\Users\CMoore5\OneDrive - Environmental Protection Agency (EPA)\Ocean Acidification\SCOA Damage Functions\Data\Raw QV Downloads\second stage"

*******************************************************************************
* clam

***************************
* import and combine quahog data

import excel clam_landings.xlsx, sheet("unspec quahog") firstrow case(lower)
rename pounds unspec_quahog_pounds
rename dollars unspec_quahog_dollars
sort year
save quahog.dta, replace
clear

import excel clam_landings.xlsx, sheet("ocean quahog") firstrow case(lower)
sort year
merge 1:m year using quahog
rename pounds ocean_quahog_pounds
rename dollars ocean_quahog_dollars
sort year
drop _merge
save quahog.dta, replace
clear

import excel clam_landings.xlsx, sheet("north quahog") firstrow case(lower)
sort year
merge 1:m year using quahog
rename pounds north_quahog_pounds
rename dollars north_quahog_dollars
sort year
drop _merge
save quahog.dta, replace
clear

import excel clam_landings.xlsx, sheet("south quahog") firstrow case(lower)
sort year
merge 1:m year using quahog
rename pounds south_quahog_pounds
rename dollars south_quahog_dollars
drop _merge
sort year
save quahog.dta, replace

* combine quahog landings and value 
replace unspec_quahog_pounds = 0 if missing(unspec_quahog_pounds)
replace ocean_quahog_pounds = 0 if missing(ocean_quahog_pounds)
replace north_quahog_pounds = 0 if missing(north_quahog_pounds)
replace south_quahog_pounds = 0 if missing(south_quahog_pounds)
replace unspec_quahog_dollars = 0 if missing(unspec_quahog_dollars)
replace ocean_quahog_dollars = 0 if missing(ocean_quahog_dollars)
replace north_quahog_dollars = 0 if missing(north_quahog_dollars)
replace south_quahog_dollars = 0 if missing(south_quahog_dollars)

gen quahog_pounds = unspec_quahog_pounds + ocean_quahog_pounds + north_quahog_pounds + south_quahog_pounds
gen quahog_dollars = unspec_quahog_dollars + ocean_quahog_dollars + north_quahog_dollars + south_quahog_dollars
drop *_quahog_pounds *_quahog_dollars metrictons scientificname nmfsname confidentiality collection tsn
save quahog.dta, replace
clear

*********************************
* import and combine pacific littleneck, gaper, and butterclam data 

import excel clam_landings.xlsx, sheet("pac littleneck") firstrow case(lower)
rename pounds pac_littleneck_pounds
rename dollars pac_littleneck_dollars
sort year
save gaperln.dta, replace
clear

import excel clam_landings.xlsx, sheet("pac gaper") firstrow case(lower)
sort year
merge 1:m year using gaperln
rename pounds pac_gaper_pounds
rename dollars pac_gaper_dollars
sort year
drop _merge
save gaperln.dta, replace
clear

import excel clam_landings.xlsx, sheet("butter") firstrow case(lower)
sort year
merge 1:m year using gaperln
rename pounds butter_pounds
rename dollars butter_dollars
sort year
drop _merge

replace pac_littleneck_pounds = 0 if missing(pac_littleneck_pounds)
replace pac_gaper_pounds = 0 if missing(pac_gaper_pounds)
replace butter_pounds = 0 if missing(butter_pounds)
replace pac_littleneck_dollars = 0 if missing(pac_littleneck_dollars)
replace pac_gaper_dollars = 0 if missing(pac_gaper_dollars)
replace butter_dollars = 0 if missing(butter_dollars)

gen pac_gaperln_pounds = pac_littleneck_pounds + pac_gaper_pounds + butter_pounds
gen pac_gaperln_dollars = pac_littleneck_dollars+pac_gaper_dollars + butter_dollars
drop pac_gaper_* pac_littleneck_* butter* metrictons scientificname nmfsname confidentiality collection tsn

save gaperln.dta, replace
clear

**********************************
* import atlantic razor 
import excel clam_landings.xlsx, sheet("atl razor") firstrow case(lower)
rename pounds atl_razor_pounds
rename dollars atl_razor_dollars
sort year
drop metrictons scientificname nmfsname confidentiality collection tsn
save atl_razor.dta, replace
clear

**********************************
* import pacific razor 
import excel clam_landings.xlsx, sheet("pac razor") firstrow case(lower)
rename pounds pac_razor_pounds
rename dollars pac_razor_dollars
sort year
drop metrictons scientificname nmfsname confidentiality collection tsn
save pac_razor.dta, replace
clear

**********************************
* import soft clam 
import excel clam_landings.xlsx, sheet("soft") firstrow case(lower)
rename pounds soft_clam_pounds
rename dollars soft_clam_dollars
sort year
drop metrictons scientificname nmfsname confidentiality collection tsn
save soft_clam.dta, replace
clear

***********************************
* import geoduck
import excel clam_landings.xlsx, sheet("geoduck") firstrow case(lower)
rename pounds geoduck_pounds
rename dollars geoduck_dollars
sort year
drop metrictons scientificname nmfsname confidentiality collection tsn
save geoduck.dta, replace
clear

************************************
* import atlantic surf clam data 
import excel clam_landings.xlsx, sheet("surf") firstrow case(lower)
rename pounds surf_pounds
rename dollars surf_dollars
sort year
drop metrictons scientificname nmfsname confidentiality collection tsn
save surfclam.dta, replace
clear

************************************
* merge clam data
use quahog.dta
merge 1:m year using gaperln
drop _merge
merge 1:m year using atl_razor
drop _merge
merge 1:m year using pac_razor
drop _merge
merge 1:m year using soft_clam
drop _merge
merge 1:m year using geoduck
drop _merge
merge 1:m year using surfclam
drop _merge

save "C:\Users\cmoore5\OneDrive - Environmental Protection Agency (EPA)\Ocean Acidification\SCOA Damage Functions\stata\united_states\second_stage\data\clam2s.dta", replace
clear

*******************************************************************************
* crab

******************************
*import and combine snow and tanner crab data 
import excel crab_landings.xlsx, sheet("snow") firstrow case(lower)
rename pounds snow_pounds
rename dollars snow_dollars
sort year
save snow.dta, replace
clear

import excel crab_landings.xlsx, sheet("snow tanner") firstrow case(lower)
sort year
merge 1:m year using snow
rename pounds snow_tanner_pounds
rename dollars snow_tanner_dollars
sort year
drop _merge
save snow.dta, replace
clear

import excel crab_landings.xlsx, sheet("south tanner") firstrow case(lower)
sort year
merge 1:m year using snow
rename pounds south_tanner_pounds
rename dollars south_tanner_dollars
sort year
drop _merge
save snow.dta, replace

replace snow_pounds = 0 if missing(snow_pounds)
replace snow_tanner_pounds = 0 if missing(snow_tanner_pounds)
replace south_tanner_pounds = 0 if missing(south_tanner_pounds)

replace snow_dollars = 0 if missing(snow_dollars)
replace snow_tanner_dollars = 0 if missing(snow_tanner_dollars)
replace south_tanner_dollars = 0 if missing(south_tanner_dollars)

gen tanner_pounds = snow_pounds + snow_tanner_pounds + south_tanner_pounds
gen tanner_dollars = snow_dollars + snow_tanner_dollars + south_tanner_dollars
drop snow* south* metrictons scientificname nmfsname confidentiality collection tsn

save tanner.dta, replace
clear

***********************************
* import and merge stone crab data 

import excel crab_landings.xlsx, sheet("fl stone") firstrow case(lower)
rename pounds flstone_pounds
rename dollars flstone_dollars
sort year
save stone.dta, replace
clear

import excel crab_landings.xlsx, sheet("unspec stone") firstrow case(lower)
sort year
merge 1:m year using stone
rename pounds unspec_stone_pounds
rename dollars unspec_stone_dollars
sort year
drop _merge

replace flstone_pounds = 0 if missing(flstone_pounds)
replace unspec_stone_pounds = 0 if missing(unspec_stone_pounds)
replace flstone_dollars = 0 if missing(flstone_dollars)
replace unspec_stone_dollars = 0 if missing(unspec_stone_dollars)

gen stone_pounds = flstone_pounds + unspec_stone_pounds
gen stone_dollars = flstone_dollars + unspec_stone_dollars
drop flstone* unspec* metrictons scientificname nmfsname confidentiality collection tsn
save stone.dta, replace
clear

************************************
* import red rock crab data  
import excel crab_landings.xlsx, sheet("red rock") firstrow case(lower)
rename pounds redrock_pounds
rename dollars redrock_dollars
sort year
drop metrictons scientificname nmfsname confidentiality collection tsn
save redrock.dta, replace
clear

************************************
* import king crab data  
import excel crab_landings.xlsx, sheet("king") firstrow case(lower)
rename pounds king_pounds
rename dollars king_dollars
sort year
drop metrictons scientificname nmfsname confidentiality collection tsn
save king.dta, replace
clear

************************************
* import dungesness crab data  
import excel crab_landings.xlsx, sheet("dungeness") firstrow case(lower)
rename pounds dungeness_pounds
rename dollars dungeness_dollars
sort year
drop metrictons scientificname nmfsname confidentiality collection tsn
save dungeness.dta, replace
clear

************************************
* import blue crab data  
import excel crab_landings.xlsx, sheet("blue") firstrow case(lower)
rename pounds blue_pounds
rename dollars blue_dollars
sort year
drop metrictons scientificname nmfsname confidentiality collection tsn
save bluecrab.dta, replace
clear

************************************
* import atlantic rock crab data  
import excel crab_landings.xlsx, sheet("atl rock") firstrow case(lower)
rename pounds atlrock_pounds
rename dollars atlrock_dollars
sort year
drop metrictons scientificname nmfsname confidentiality collection tsn
save atlrock.dta, replace
clear


use tanner.dta
merge 1:m year using stone
drop _merge
merge 1:m year using redrock
drop _merge
merge 1:m year using king
drop _merge
merge 1:m year using dungeness
drop _merge
merge 1:m year using bluecrab
drop _merge
merge 1:m year using atlrock
drop _merge
save "C:\Users\CMoore5\OneDrive - Environmental Protection Agency (EPA)\Ocean Acidification\SCOA Damage Functions\stata\united_states\second_stage\data\crab2s.dta", replace
clear

*******************************************************************************
* lobster
import excel lobster_landings.xlsx, sheet("american") firstrow case(lower)
rename pounds american_pounds
rename dollars american_dollars
sort year
drop metrictons scientificname nmfsname confidentiality collection tsn
save american_lobster.dta, replace
clear

import excel lobster_landings.xlsx, sheet("spiny") firstrow case(lower)
rename pounds spiny_pounds
rename dollars spiny_dollars
sort year
drop metrictons scientificname nmfsname confidentiality collection tsn

merge 1:m year using american_lobster
drop _merge
save "C:\Users\CMoore5\OneDrive - Environmental Protection Agency (EPA)\Ocean Acidification\SCOA Damage Functions\stata\united_states\second_stage\data\lobster2s.dta", replace
clear

********************************************************************************
* oyster
import excel oyster_landings.xlsx, sheet("eastern") firstrow case(lower)
rename pounds eastern_pounds
rename dollars eastern_dollars
sort year
drop metrictons scientificname nmfsname confidentiality collection tsn
save eastern.dta, replace
clear

import excel oyster_landings.xlsx, sheet("pacific") firstrow case(lower)
rename pounds pacific_pounds
rename dollars pacific_dollars
sort year
drop metrictons scientificname nmfsname confidentiality collection tsn
save pacific.dta, replace
clear

import excel oyster_landings.xlsx, sheet("olympia") firstrow case(lower)
rename pounds olympia_pounds
rename dollars olympia_dollars
sort year
drop metrictons scientificname nmfsname confidentiality collection tsn

merge 1:m year using eastern
drop _merge
merge 1:m year using pacific
drop _merge

save "C:\Users\CMoore5\OneDrive - Environmental Protection Agency (EPA)\Ocean Acidification\SCOA Damage Functions\stata\united_states\second_stage\data\oyster2s.dta", replace
clear

********************************************************************************
* scallop
import excel scallop_landings.xlsx, sheet("bay") firstrow case(lower)
rename pounds bay_pounds
rename dollars bay_dollars
sort year
drop metrictons scientificname nmfsname confidentiality collection tsn
save bay.dta, replace
clear

import excel scallop_landings.xlsx, sheet("sea") firstrow case(lower)
rename pounds sea_pounds
rename dollars sea_dollars
sort year
drop metrictons scientificname nmfsname confidentiality collection tsn
save sea.dta, replace
clear

import excel scallop_landings.xlsx, sheet("weathervane") firstrow case(lower)
rename pounds weathervane_pounds
rename dollars weathervane_dollars
sort year
drop metrictons scientificname nmfsname confidentiality collection tsn

merge 1:m year using bay
drop _merge
merge 1:m year using sea
drop _merge
save "C:\Users\CMoore5\OneDrive - Environmental Protection Agency (EPA)\Ocean Acidification\SCOA Damage Functions\stata\united_states\second_stage\data\scallop2s.dta", replace
clear

********************************************************************************
* shrimp
import excel shrimp_landings.xlsx, sheet("brown") firstrow case(lower)
rename pounds brown_pounds
rename dollars brown_dollars
sort year
drop metrictons scientificname nmfsname confidentiality collection tsn
save brown.dta, replace
clear

import excel shrimp_landings.xlsx, sheet("pink") firstrow case(lower)
rename pounds pink_pounds
rename dollars pink_dollars
sort year
drop metrictons scientificname nmfsname confidentiality collection tsn
save pink.dta, replace
clear

import excel shrimp_landings.xlsx, sheet("white") firstrow case(lower)
rename pounds white_pounds
rename dollars white_dollars
sort year
drop metrictons scientificname nmfsname confidentiality collection tsn
save white.dta, replace
clear

import excel shrimp_landings.xlsx, sheet("royal red") firstrow case(lower)
rename pounds royal_pounds
rename dollars royal_dollars
sort year
drop metrictons scientificname nmfsname confidentiality collection tsn
save royal.dta, replace
clear

import excel shrimp_landings.xlsx, sheet("rock") firstrow case(lower)
rename pounds rock_pounds
rename dollars rock_dollars
sort year
drop metrictons scientificname nmfsname confidentiality collection tsn

merge 1:m year using brown
drop _merge
merge 1:m year using pink
drop _merge
merge 1:m year using white
drop _merge
merge 1:m year using royal
drop _merge
save "C:\Users\CMoore5\OneDrive - Environmental Protection Agency (EPA)\Ocean Acidification\SCOA Damage Functions\stata\united_states\second_stage\data\shrimp2s.dta", replace
clear




