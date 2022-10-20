clear
cd "C:\Users\CMoore5\OneDrive - Environmental Protection Agency (EPA)\Ocean Acidification\SCOA Damage Functions\stata\Canada"

import excel "C:\Users\CMoore5\OneDrive - Environmental Protection Agency (EPA)\Ocean Acidification\SCOA Damage Functions\Data\Canada\canada_qv_data.xlsx", sheet("Sheet1") firstrow case(lower) clear
destring, ignore(",") replace

gen Y = clam_dollars+ oyster_dollars + scallop_dollars  

gen w1 = clam_dollars/Y
gen w2 = oyster_dollars/Y
gen w3 = scallop_dollars/Y
label var w1 "clam w"
label var w2 "oyster w"
label var w3 "scallop w"

gen lnX1 = ln(clam_tonnes*2206.62)
gen lnX2 = ln(oyster_tonnes*2206.62)
gen lnX3 = ln(scallop_tonnes*2206.62)
label var lnX1 "clam logged pounds"
label var lnX2 "oyster logged pounds"
label var lnX3 "scallop logged pounds"

drop *tonnes *dollars

sort year 

save "C:\Users\CMoore5\OneDrive - Environmental Protection Agency (EPA)\Ocean Acidification\SCOA Damage Functions\stata\Canada\canada_mollusk_model_data.dta", replace

import excel "C:\Users\CMoore5\OneDrive - Environmental Protection Agency (EPA)\Ocean Acidification\SCOA Damage Functions\Data\Canada\canada_qv_data.xlsx", sheet("Sheet1") firstrow case(lower) clear
destring, ignore(",") replace

gen Y = snowcrab_dollars + dungeness_dollars + lobster_dollars + shrimp_dollars

gen w1 = dungeness_dollars/Y
gen w2 = snowcrab_dollars/Y
gen w3 = lobster_dollars/Y
gen w4 = shrimp_dollars/Y
label var w1 "crab_dungeness w"
label var w2 "crab_snow w"
label var w3 "lobster w"
label var w4 "shrimp w"

gen lnX1 = ln(dungeness_tonnes*2206.62)
gen lnX2 = ln(snowcrab_tonnes*2206.62)
gen lnX3 = ln(lobster_tonnes*2206.62)
gen lnX4 = ln(shrimp_tonnes*2206.62)
label var lnX1 "dungeness crab logged pounds"
label var lnX2 "snow crab logged pounds"
label var lnX3 "lobster logged pounds"
label var lnX4 "shrimp logged pounds"

drop *tonnes *dollars
sort year 

save "C:\Users\CMoore5\OneDrive - Environmental Protection Agency (EPA)\Ocean Acidification\SCOA Damage Functions\stata\Canada\canada_crustacean_model_data.dta", replace

