* get lobster projections
clear
cd "C:\Users\CMoore5\OneDrive - Environmental Protection Agency (EPA)\Ocean Acidification\SCOA Damage Functions\stata\harvest_projections"

********************************************************************************
* Lobster

*********************************
* Get Lobster initial quantities (mean of 2010-2020 harvest)
use "C:\Users\CMoore5\OneDrive - Environmental Protection Agency (EPA)\Ocean Acidification\SCOA Damage Functions\stata\second_stage\lobster2s.dta"
keep if year > 2010
egen americanQ0	= mean(american_pounds)
egen spinyQ0 	= mean(spiny_pounds)
keep year americanQ0 spinyQ0
sort year
save lobsterQ0.dta, replace
clear

*********************************
* American lobster projections (Homarus americanus	American lobster)

* RCP 2.6
use lobster_projections
destring tonnes, replace
keep if speciesnum == 690010 
keep if oa == "OA"
keep if rcp == "RCP26"

sort year
merge 1:m year using lobsterQ0.dta 
drop _merge
drop if year < 2020
gen delta = (tonnes-tonnes[1])/tonnes[1]
gen americanQt26 = americanQ0[1]*(1+delta)
keep year americanQt26
save americanQt26.dta, replace
clear

* RCP 8.5
use lobster_projections
destring tonnes, replace
keep if speciesnum == 690010 
keep if oa == "OA"
keep if rcp == "RCP85"

sort year
merge 1:m year using lobsterQ0.dta 
drop _merge
drop if year < 2020
gen delta = (tonnes-tonnes[1])/tonnes[1]
gen americanQt85 = americanQ0[1]*(1+delta)
keep year americanQt85
save americanQt85.dta, replace
clear

*********************************
* Spiny lobster projections (Panulirus argus	Caribbean spiny lobster)

* RCP 2.6
use lobster_projections
destring tonnes, replace
keep if speciesnum == 690071 
keep if oa == "OA"
keep if rcp == "RCP26"

sort year
merge 1:m year using lobsterQ0.dta 
drop _merge
drop if year < 2020
gen delta = (tonnes-tonnes[1])/tonnes[1]
gen spinyQt26 = spinyQ0[1]*(1+delta)
keep year spinyQt26
save spinyQt26.dta, replace
clear

* RCP 8.5
use lobster_projections
destring tonnes, replace
keep if speciesnum == 690071 
keep if oa == "OA"
keep if rcp == "RCP85"

sort year
merge 1:m year using lobsterQ0.dta 
drop _merge
drop if year < 2020
gen delta = (tonnes-tonnes[1])/tonnes[1]
gen spinyQt85 = spinyQ0[1]*(1+delta)
keep year spinyQt85
save spinyQt85.dta, replace
clear

use americanQt26
merge 1:m year using americanQt85
drop _merge
merge 1:m year using spinyQt26
drop _merge
merge 1:m year using spinyQt85
drop _merge

save lobster_harvest_projections.dta, replace
export excel using "C:\Users\CMoore5\OneDrive - Environmental Protection Agency (EPA)\Ocean Acidification\SCOA Damage Functions\stata\harvest_projections\lobster_harvest_projections.xlsx", sheetmodify firstrow(variables)

