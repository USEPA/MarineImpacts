* first_stage_data_manage uses the species2s data to create the model data for second stage estimation
* dollars are converted to 2020 dollars using cpi
* Variables created are: expenditure shares for each type, natural logs of quantities, year (1950 = 1) 

clear
cd "C:\Users\CMoore5\OneDrive - Environmental Protection Agency (EPA)\Ocean Acidification\SCOA Damage Functions\stata\united_states\second_stage\data"

**********************
* clam
use clam2s
sort year 
merge 1:m year using cpi_adj_factors
drop _merge
gen quahog_v 		= quahog_dollars*adj_factor
gen pac_gaperln_v 	= pac_gaperln_dollars*adj_factor
gen atl_razor_v 	= atl_razor_dollars*adj_factor
gen pac_razor_v 	= pac_razor_dollars*adj_factor
gen soft_clam_v 	= soft_clam_dollars*adj_factor
gen geoduck_v 		= geoduck_dollars*adj_factor
gen surf_clam_v 	= surf_dollars*adj_factor

********************************************************
* temporary fix: replace missing geoduck obs with means
********************************************************
 sum geoduck_v
 replace geoduck_v = r(mean) if missing(geoduck_v)
 sum geoduck_pounds
 replace geoduck_pounds = r(mean) if missing(geoduck_pounds)
 *******************************************************

* Drop pacific gaper, pacific razor, and atlantic razor: low expenditure shares are screwing up flexibilities 
egen Y = rowtotal(quahog_v soft_clam_v geoduck_v surf_clam_v) /*pac_gaperln_v atl_razor_v pac_razor_v */

* create expenditure share variables 
gen w1 = quahog_v/Y
gen w2 = soft_clam_v/Y
gen w3 = geoduck_v/Y
gen w4 = surf_clam_v/Y

*gen w5 = pac_gaperln_v/Y
*gen w6 = atl_razor_v/Y
*gen w7 = pac_razor_v/Y

* log quantities
gen lnX1 = log(quahog_pounds)
gen lnX2 = log(soft_clam_pounds)
gen lnX3 = log(geoduck_pounds)
gen lnX4 = log(surf_pounds)

*gen lnX5 = log(pac_gaperln_pounds)
*gen lnX6 = log(atl_razor_pounds)
*gen lnX7 = log(pac_razor_pounds)

* Year Variable 
replace year = year-1950

keep w* lnX* Y year


label var w1 "quahog expenditure shares"
label var w2 "soft clam expenditure shares"
label var w3 "geoduck expenditure shares"
label var w4 "surf clam expenditure shares"
*label var w5 "pac gaper expenditure shares"
*label var w6 "atlantic razor expenditure shares"
*label var w7 "pac razor expenditure shares"

label var lnX1 "quahog logged quantities"
label var lnX2 "soft clam logged quantities"
label var lnX3 "geoduck logged quantities"
label var lnX4 "surf clam logged quantities"
*label var lnX5 "pac gaper logged quantities"
*label var lnX6 "atlantic razor logged quantities"
*label var lnX7 "pac razor logged quantities"


save clam2s_model_data, replace
clear

**********************
* crab
use crab2s
sort year 
merge 1:m year using cpi_adj_factors
drop _merge
gen tanner_v 	= tanner_dollars*adj_factor
gen stone_v 	= stone_dollars*adj_factor
gen redrock_v 	= redrock_dollars*adj_factor
gen king_v 		= king_dollars*adj_factor
gen dungeness_v	= dungeness_dollars*adj_factor
gen blue_v 		= blue_dollars*adj_factor
gen atlrock_v 	= atlrock_dollars*adj_factor

*************************************************
* Drop atlantic stone crab, red rock crab, and rock crab: low expenditure shares are screwing up flexibilities

* total expenditures on all types 
egen Y = rowtotal(tanner_v king_v dungeness_v blue_v) /*stone_v redrock_v  atlrock_v*/

* create expenditure share variables 
gen w1 = blue_v/Y
gen w2 = king_v/Y
gen w3 = dungeness_v/Y
gen w4 = tanner_v/Y
*gen w2 = stone_v/Y
*gen w6 = redrock_v/Y
*gen w7 = atlrock_v/Y

* log quantities
gen lnX1 = log(blue_pounds)
gen lnX2 = log(king_pounds)
gen lnX3 = log(dungeness_pounds)
gen lnX4 = log(tanner_pounds)
*gen lnX2 = log(stone_pounds)
*gen lnX6 = log(redrock_pounds)
*gen lnX7 = log(atlrock_pounds)

* Year Variable 
replace year = year-1950

keep w* lnX* Y year
label var w1 "blue expenditure shares"
label var w2 "king crab expenditure shares"
label var w3 "dungeness expenditure shares"
label var w4 "tanner crab expenditure shares"
*label var w2 "stone crab expenditure shares"
*label var w6 "red rock crab expenditure shares"
*label var w7 "atlantic rock crab expenditure shares"

label var lnX1 "blue logged quantities"
label var lnX2 "king crablogged quantities"
label var lnX3 "dungeness logged quantities"
label var lnX4 "tanner crab logged quantities"
*label var lnX2 "stone crab logged quantities"
*label var lnX6 "red rock crablogged quantities"
*label var lnX7 "atlantic rock crab logged quantities"

save crab2s_model_data, replace
clear

*********************
* lobster
use lobster2s
sort year 
merge 1:m year using cpi_adj_factors
drop _merge
gen american_v 	= american_dollars*adj_factor
gen spiny_v 	= spiny_dollars*adj_factor

* total expenditures on all types 
egen Y = rowtotal(american_v spiny_v)

* create expenditure share variables 
gen w1 = american_v/Y 
gen w2 = spiny_v/Y

* log quantities
gen lnX1 = log(american_pounds)
gen lnX2 = log(spiny_pounds)

* Year Variable 
replace year = year-1950

keep w* lnX* Y year
label var w1 "american lobster expenditure shares"
label var w2 "spiny lobster expenditure shares"

label var lnX1 "american lobster logged quantities"
label var lnX2 "spiny lobster logged quantities"

save lobster2s_model_data, replace 
clear

*********************
* oyster
use oyster2s
sort year 
merge 1:m year using cpi_adj_factors
drop _merge
gen eastern_v 	= eastern_dollars*adj_factor
gen pacific_v 	= pacific_dollars*adj_factor
gen olympia_v 	= olympia_dollars*adj_factor

* total expenditures on all types 
egen Y = rowtotal(eastern_v pacific_v olympia_v)

* create expenditure share variables 
gen w1 = eastern_v/Y 
gen w2 = pacific_v/Y
gen w3 = olympia_v/Y

* log quantities
gen lnX1 = log(eastern_pounds)
gen lnX2 = log(pacific_pounds)
gen lnX3 = log(olympia_pounds)

* Year Variable 
replace year = year-1950

keep w* lnX* Y year

label var w1 "eastern oyster expenditure shares"
label var w2 "pacific oyster expenditure shares"
label var w3 "olympia oyster expenditure shares"

label var lnX1 "eastern oyster logged quantities"
label var lnX2 "pacific oyster logged quantities"
label var lnX3 "olympia oyster logged quantities"

save oyster2s_model_data, replace
clear

***********************
* scallop
use scallop2s
sort year 
merge 1:m year using cpi_adj_factors
drop _merge
gen bay_v = bay_dollars*adj_factor
gen sea_v = sea_dollars*adj_factor
gen weathervane_v = weathervane_dollars*adj_factor

* total expenditures on all types 
egen Y = rowtotal(bay_v sea_v weathervane_v)

* create expenditure share variables 
gen w1 = bay_v/Y
gen w2 = sea_v/Y
gen w3 = weathervane_v/Y

* log quantities
gen lnX1 = log(bay_pounds)
gen lnX2 = log(sea_pounds)
gen lnX3 = log(weathervane_pounds)

* Year Variable 
replace year = year-1950

keep w* lnX* Y year

label var w1 "bay scallops expenditure shares"
label var w2 "sea scallops expenditure shares"
label var w3 "weathervane scallops expenditure shares"

label var lnX1 "bay scallops logged quantities"
label var lnX2 "sea scallops logged quantities"
label var lnX3 "weathervane scallops logged quantities"

save scallop2s_model_data, replace
clear

***********************
* shrimp
use shrimp2s
sort year 
merge 1:m year using cpi_adj_factors
drop _merge
gen brown_v = brown_dollars*adj_factor
gen pink_v = pink_dollars*adj_factor
gen white_v = white_dollars*adj_factor
gen royal_v = royal_dollars*adj_factor
gen rock_v = rock_dollars*adj_factor

* drop royal red and rock shrimp: small expenditure shares are screwing up felxibilities

* total expenditures on all types 
egen Y = rowtotal(brown_v pink_v white_v) /* royal_v rock_v) */

* create expenditure share variables 
gen w1 = brown_v/Y
gen w2 = pink_v/Y
gen w3 = white_v/Y
*gen w4 = royal_v/Y
*gen w5 = rock_v/Y

* log quantities
gen lnX1 = log(brown_pounds)
gen lnX2 = log(pink_pounds)
gen lnX3 = log(white_pounds)
*gen lnX4 = log(royal_pounds)
*gen lnX5 = log(rock_pounds)

* Year Variable 
replace year = year-1950

keep w1 w2 w3 lnX* Y year
label var w1 "brown shrimp expenditure shares"
label var w2 "pink shrimp expenditure shares"
label var w3 "white shrimp expenditure shares"
*label var w4 "royal red shrimp expenditure shares"
*label var w5 "rock shrimp expenditure shares"


label var lnX1 "brown shrimp quantities"
label var lnX2 "pink shrimp logged quantities"
label var lnX3 "white shrimp logged quantities"
*label var lnX4 "royal red shrimp logged quantities"
*label var lnX5 "rock shrimp logged quantities"

save shrimp2s_model_data, replace
clear 
******************************************************************************
* Combine crab and lobster

use lobster2s_model_data 
rename w1 w6
rename w2 w7
rename lnX1 lnX6
rename lnX2 lnX7
sort year

merge 1:m year using crab2s_model_data

save "C:\Users\cmoore5\OneDrive - Environmental Protection Agency (EPA)\Ocean Acidification\SCOA Damage Functions\stata\united_states\second_stage\data\crablobster2s_model_data", replace

