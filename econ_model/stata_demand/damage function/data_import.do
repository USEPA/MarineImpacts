* import climate and consumer welfare data 

cd "C:\Users\CMoore5\OneDrive - Environmental Protection Agency (EPA)\Ocean Acidification\SCOA Damage Functions\stata\damage function"

* RCP2.6 Temperature Data 
import delimited "C:\Users\CMoore5\OneDrive - Environmental Protection Agency (EPA)\Ocean Acidification\SCOA Damage Functions\Data\Damage function data\summary_rcp26.csv", clear

rename meanvalue temp
keep if latbox == "global"
drop variable ctag vtag units type latbox error error_min error_max value nmodels model
drop if year > 2100
drop if year < 2020
sort year
save tempdata_26, replace

* RCP8.5 Temperature Data 
import delimited "C:\Users\CMoore5\OneDrive - Environmental Protection Agency (EPA)\Ocean Acidification\SCOA Damage Functions\Data\Damage function data\summary_rcp85.csv", clear
rename meanvalue temp
keep if latbox == "global"
drop variable ctag vtag units type latbox error error_min error_max value nmodels model
drop if year > 2100
drop if year < 2020
sort year

append using tempdata_26
sort year scenario
save tempdata, replace 

* RCP26 pH Data 
import excel "C:\Users\CMoore5\OneDrive - Environmental Protection Agency (EPA)\Ocean Acidification\SCOA Damage Functions\Data\Damage function data\GlobalYearlyAveragepH.xlsx", sheet("pH") firstrow case(lower) clear
keep year mean_ph26
rename mean_ph26 ph
gen scenario = "rcp26"
save phdata_26, replace

* RCP85 pH Data 
import excel "C:\Users\CMoore5\OneDrive - Environmental Protection Agency (EPA)\Ocean Acidification\SCOA Damage Functions\Data\Damage function data\GlobalYearlyAveragepH.xlsx", sheet("pH") firstrow case(lower) clear
keep year mean_ph85
rename mean_ph85 ph
gen scenario = "rcp85"

append using phdata_26
sort year scenario
drop if year < 2020
save phdata, replace

* US Damage Data 
import excel "C:\Users\CMoore5\OneDrive - Environmental Protection Agency (EPA)\Ocean Acidification\SCOA Damage Functions\Data\Damage function data\US total annual economic impacts.xlsx", sheet("Sheet1") firstrow case(lower) clear
rename rcp26vspresent USdamages
drop rcp26vsrcp85 rcp85vspresent
gen scenario = "rcp26"
save rcp26_damages, replace

import excel "C:\Users\CMoore5\OneDrive - Environmental Protection Agency (EPA)\Ocean Acidification\SCOA Damage Functions\Data\Damage function data\US total annual economic impacts.xlsx", sheet("Sheet1") firstrow case(lower) clear
rename rcp85vspresent USdamages
drop rcp26vsrcp85 rcp26vspresent
gen scenario = "rcp85"
append using rcp26_damages
sort year scenario
save USdamages, replace

* Canada Damage Data 
import excel "C:\Users\CMoore5\OneDrive - Environmental Protection Agency (EPA)\Ocean Acidification\SCOA Damage Functions\Data\Damage function data\Canada total annual economic impacts.xlsx", sheet("Sheet1") firstrow case(lower) clear
rename rcp26vspresent CANdamages
drop rcp26vs85 rcp85vspresent
gen scenario = "rcp26"
save CANrcp26_damages, replace

import excel "C:\Users\CMoore5\OneDrive - Environmental Protection Agency (EPA)\Ocean Acidification\SCOA Damage Functions\Data\Damage function data\Canada total annual economic impacts.xlsx", sheet("Sheet1") firstrow case(lower) clear
rename rcp85vspresent CANdamages
drop rcp26vs85 rcp26vspresent
gen scenario = "rcp85"
append using CANrcp26_damages
sort year scenario

merge 1:1 year scenario using USdamages
drop _merge
merge 1:1 year scenario using tempdata
drop _merge
merge 1:1 year scenario using phdata 
drop _merge
save damage_model_data, replace
