* get shrimp projections
clear
cd "C:\Users\CMoore5\OneDrive - Environmental Protection Agency (EPA)\Ocean Acidification\SCOA Damage Functions\stata\harvest_projections"

********************************************************************************
* shrimp

*********************************
* Get Crab initial quantities (mean of 2010-2020 harvest)
use "C:\Users\CMoore5\OneDrive - Environmental Protection Agency (EPA)\Ocean Acidification\SCOA Damage Functions\stata\second_stage\shrimp2s.dta"
keep if year > 2010
egen brownQ0 	= mean(brown_pounds)
egen pinkQ0 	= mean(pink_pounds)
egen whiteQ0 	= mean(white_pounds)
keep year brownQ0 pinkQ0 whiteQ0 
sort year
save shrimpQ0.dta, replace
clear

*********************************
* brown shrimp projections (Farfantepenaeus aztecus	Northern brown shrimp)

* RCP 2.6
use shrimp_projections
destring tonnes, replace
keep if speciesnum == 690265 
keep if oa == "OA"
keep if rcp == "RCP26"

sort year
merge 1:m year using shrimpQ0.dta 
drop _merge
drop if year < 2020
gen delta = (tonnes-tonnes[1])/tonnes[1]
gen brownQt26 = brownQ0[1]*(1+delta)
keep year brownQt26
save brownQt26.dta, replace
clear

* RCP 8.5
use shrimp_projections
destring tonnes, replace
keep if speciesnum == 690265
keep if oa == "OA"
keep if rcp == "RCP85"

sort year
merge 1:m year using shrimpQ0.dta 
drop _merge
drop if year < 2020
gen delta = (tonnes-tonnes[1])/tonnes[1]
gen brownQt85 = brownQ0[1]*(1+delta)
keep year brownQt85
save brownQt85.dta, replace
clear

**********************************
* Pink shrimp projections (Farfantepenaeus duorarum	Northern pink shrimp)

* RCP 2.6
use shrimp_projections
destring tonnes, replace
keep if speciesnum == 690268
keep if oa == "OA"
keep if rcp == "RCP26"

sort year
merge 1:m year using shrimpQ0.dta 
drop _merge
drop if year < 2020
gen delta = (tonnes-tonnes[1])/tonnes[1]
gen pinkQt26 = pinkQ0[1]*(1+delta)
keep year pinkQt26
save pinkQt26.dta, replace
clear

* RCP 8.5
use shrimp_projections
destring tonnes, replace
keep if speciesnum == 690268
keep if oa == "OA"
keep if rcp == "RCP85"

sort year
merge 1:m year using shrimpQ0.dta 
drop _merge
drop if year < 2020
gen delta = (tonnes-tonnes[1])/tonnes[1]
gen pinkQt85 = pinkQ0[1]*(1+delta)
keep year pinkQt85
save pinkQt85.dta, replace
clear

**********************************
* White shrimp projections (Litopenaeus setiferus	Northern white shrimp)

* RCP 2.6
use shrimp_projections
destring tonnes, replace
keep if speciesnum == 690272
keep if oa == "OA"
keep if rcp == "RCP26"

****
* Combine weathervane harvest from EEZ 840 & 841
egen white_tonnes = total(tonnes), by(year)
keep if eez == 840
drop tonnes
rename white_tonnes tonnes

sort year
merge 1:m year using shrimpQ0.dta 
drop _merge
drop if year < 2020
gen delta = (tonnes-tonnes[1])/tonnes[1]
gen whiteQt26 = whiteQ0[1]*(1+delta)
keep year whiteQt26
save whiteQt26.dta, replace
clear

* RCP 8.5
use shrimp_projections
destring tonnes, replace
keep if speciesnum == 690272
keep if oa == "OA"
keep if rcp == "RCP85"

sort year
merge 1:m year using shrimpQ0.dta 
drop _merge
drop if year < 2020
gen delta = (tonnes-tonnes[1])/tonnes[1]
gen whiteQt85 = whiteQ0[1]*(1+delta)
keep year whiteQt85
save whiteQt85.dta, replace
clear

***************************************
* merge clam projections
use brownQt26
merge 1:m year using brownQt85
drop _merge
merge 1:m year using pinkQt26
drop _merge
merge 1:m year using pinkQt85
drop _merge
merge 1:m year using whiteQt26
drop _merge
merge 1:m year using whiteQt85
drop _merge

save shrimp_harvest_projections.dta, replace
export excel using "C:\Users\CMoore5\OneDrive - Environmental Protection Agency (EPA)\Ocean Acidification\SCOA Damage Functions\stata\harvest_projections\shrimp_harvest_projections.xlsx", sheetmodify firstrow(variables)
