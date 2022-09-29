*first_stage_data_manage uses the raw_total data to create the model data for first stage estimation
* dollars are converted to 2020 dollars using 
* Variables created are: expenditure shares for each type, natural logs of quantities, year (1950 = 1) 

clear
cd "C:\Users\CMoore5\OneDrive - Environmental Protection Agency (EPA)\Ocean Acidification\SCOA Damage Functions\stata\united_states\first_stage\data"
use raw_total
destring, replace ignore(",")
sort year

* Adjust nominal expenditures to 2020 dollars (unnecessary because the model uses expenditure shares?)
* Dropping mussels because small expenditure shares are screwing up post-estimation processing (e.g. welfare estimates and flexibilities)

merge 1:m year using cpi_adj_factors
drop _merge
gen clam_v = clam_nominal_dollars*adj_factor
gen crab_v = crab_nominal_dollars*adj_factor
gen mussel_v = mussel_nominal_dollars*adj_factor 
gen lobster_v = lobster_nominal_dollars*adj_factor
gen oyster_v = oyster_nominal_dollars*adj_factor
gen scallop_v = scallop_nominal_dollars*adj_factor
gen shrimp_v = shrimp_nominal_dollars*adj_factor

********************************************************
* temporary fix: replace missing shrimp obs with means
********************************************************
 sum shrimp_v
 replace shrimp_v = r(mean) if missing(shrimp_v)
 sum shrimp_pounds
 replace shrimp_pounds = r(mean) if missing(shrimp_pounds)
 *******************************************************

* total expenditures on all types 
gen Y = clam_v + crab_v + lobster_v + oyster_v + scallop_v + shrimp_v

* create expenditure share variables 
gen w1 = clam_v/Y
gen w2 = crab_v/Y
gen w3 = lobster_v/Y
gen w4 = oyster_v/Y
gen w5 = scallop_v/Y
gen w6 = shrimp_v/Y
*gen w7 = mussel_v/Y

label var w1 "clam expenditure share"
label var w2 "crab expenditure share"
label var w3 "lobster expenditure share"
label var w4 "oyster expenditure share"
label var w5 "scallop expenditure share"
label var w6 "shrimp expenditure share"
*label var w7 "mussel expenditure share"

* log quantities
gen lnX1 = log(clam_pounds)
gen lnX2 = log(crab_pounds)
gen lnX3 = log(lobster_pounds)
gen lnX4 = log(oyster_pounds)
gen lnX5 = log(scallop_pounds)
gen lnX6 = log(shrimp_pounds)
* gen lnX7 = log(mussel_pounds)


label var lnX1 "clam logged quantity"
label var lnX2 "crab logged quantity"
label var lnX3 "lobster logged quantity"
label var lnX4 "oyster logged quantity"
label var lnX5 "scallop logged quantity"
label var lnX6 "shrimp logged quantity"
*label var lnX7 "mussel logged quantity"

* Year Variable 
replace year = year-1950

keep w* lnX* Y year

save first_stage_model_data, replace
