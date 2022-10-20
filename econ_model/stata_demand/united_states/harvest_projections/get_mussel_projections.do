* get mussel projections
clear
cd "C:\Users\CMoore5\OneDrive - Environmental Protection Agency (EPA)\Ocean Acidification\SCOA Damage Functions\stata\harvest_projections"

********************************************************************************
* Mussel

*********************************
* Get Mussel initial quantities (mean of 2010-2020 harvest)
use "C:\Users\CMoore5\OneDrive - Environmental Protection Agency (EPA)\Ocean Acidification\SCOA Damage Functions\stata\mussel_total.dta"
destring mussel_pounds, ignore(",") replace
keep if year > 2010
egen musselQ0 = mean(mussel_pounds)
keep year musselQ0 
sort year
save musselQ0.dta, replace
clear

*********************************
* Blue (Sea) Mussel projections (Mytilus edulis	Blue mussel)

* RCP 2.6
use mussel_projections
destring tonnes, replace
keep if speciesnum == 690053
keep if oa == "OA"
keep if rcp == "RCP26"

sort year
merge 1:m year using musselQ0.dta 
drop _merge
drop if year < 2020
gen delta = (tonnes-tonnes[1])/tonnes[1]
gen musselQt26 = musselQ0[1]*(1+delta)
keep year musselQt26
save musselQt26.dta, replace
clear

* RCP 8.5
use mussel_projections
destring tonnes, replace
keep if speciesnum == 690053
keep if oa == "OA"
keep if rcp == "RCP85"

sort year
merge 1:m year using musselQ0.dta 
drop _merge
drop if year < 2020
gen delta = (tonnes-tonnes[1])/tonnes[1]
gen musselQt85 = musselQ0[1]*(1+delta)
keep year musselQt85
save musselQt85.dta, replace
clear

use musselQt26
merge 1:m year using musselQt85
drop _merge

save mussel_harvest_projections.dta, replace
export excel using "C:\Users\CMoore5\OneDrive - Environmental Protection Agency (EPA)\Ocean Acidification\SCOA Damage Functions\stata\harvest_projections\mussel_harvest_projections.xlsx", sheetmodify firstrow(variables)

