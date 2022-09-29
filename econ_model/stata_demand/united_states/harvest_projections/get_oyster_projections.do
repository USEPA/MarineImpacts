* get lobster projections
clear
cd "C:\Users\CMoore5\OneDrive - Environmental Protection Agency (EPA)\Ocean Acidification\SCOA Damage Functions\stata\harvest_projections"

********************************************************************************
* Oyster

*********************************
* Get Oyster initial quantities (mean of 2010-2020 harvest)
use "C:\Users\CMoore5\OneDrive - Environmental Protection Agency (EPA)\Ocean Acidification\SCOA Damage Functions\stata\second_stage\oyster2s.dta"
keep if year > 2010
egen easternQ0 	= mean(eastern_pounds)
egen pacificQ0 	= mean(pacific_pounds)
egen olympiaQ0 	= mean(olympia_pounds)
keep year easternQ0 pacificQ0 olympiaQ0
sort year
save oysterQ0.dta, replace
clear

*********************************
* Eastern oyster projections (Crassostrea virginica	American cupped oyster)

* RCP 2.6
use oyster_projections
destring tonnes, replace
keep if speciesnum == 690009
keep if oa == "OA"
keep if rcp == "RCP26"

sort year
merge 1:m year using oysterQ0.dta 
drop _merge
drop if year < 2020
gen delta = (tonnes-tonnes[1])/tonnes[1]
gen easternQt26 = easternQ0[1]*(1+delta)
keep year easternQt26
save easternQt26.dta, replace
clear

* RCP 8.5
use oyster_projections
destring tonnes, replace
keep if speciesnum == 690009
keep if oa == "OA"
keep if rcp == "RCP85"

sort year
merge 1:m year using oysterQ0.dta 
drop _merge
drop if year < 2020
gen delta = (tonnes-tonnes[1])/tonnes[1]
gen easternQt85 = easternQ0[1]*(1+delta)
keep year easternQt85
save easternQt85.dta, replace
clear

*********************************
* Pacific oyster projections (Crassostrea gigas	Pacific cupped oyster)
* RCP 2.6
use oyster_projections
destring tonnes, replace
keep if speciesnum == 690283
keep if oa == "OA"
keep if rcp == "RCP26"

****
* Combine pacific oyster harvest from EEZ 840 & 841
egen pacific_tonnes = total(tonnes), by(year)
keep if eez == 840
drop tonnes
rename pacific_tonnes tonnes

sort year
merge 1:m year using oysterQ0.dta 
drop _merge
drop if year < 2020
gen delta = (tonnes-tonnes[1])/tonnes[1]
gen pacificQt26 = pacificQ0[1]*(1+delta)
keep year pacificQt26
save pacificQt26.dta, replace
clear

* RCP 8.5
use oyster_projections
destring tonnes, replace
keep if speciesnum == 690283
keep if oa == "OA"
keep if rcp == "RCP85"

****
* Combine pacific oyster harvest from EEZ 840 & 841
egen pacific_tonnes = total(tonnes), by(year)
keep if eez == 840
drop tonnes
rename pacific_tonnes tonnes

sort year
merge 1:m year using oysterQ0.dta 
drop _merge
drop if year < 2020
gen delta = (tonnes-tonnes[1])/tonnes[1]
gen pacificQt85 = pacificQ0[1]*(1+delta)
keep year pacificQt85
save pacificQt85.dta, replace
clear

*********************************
* Olympia oyster projections (Ostrea lurida	Olympia flat oyster)

* RCP 2.6
use oyster_projections
destring tonnes, replace
keep if speciesnum == 690279
keep if oa == "OA"
keep if rcp == "RCP26"

****
* Combine olympia oyster harvest from EEZ 840 & 841
egen olympia_tonnes = total(tonnes), by(year)
keep if eez == 840
drop tonnes
rename olympia_tonnes tonnes

sort year
merge 1:m year using oysterQ0.dta 
drop _merge
drop if year < 2020
gen delta = (tonnes-tonnes[1])/tonnes[1]
gen olympiaQt26 = olympiaQ0[1]*(1+delta)
keep year olympiaQt26
save olympiaQt26.dta, replace
clear

* RCP 8.5
use oyster_projections
destring tonnes, replace
keep if speciesnum == 690279
keep if oa == "OA"
keep if rcp == "RCP85"

****
* Combine olympia oyster harvest from EEZ 840 & 841
egen olympia_tonnes = total(tonnes), by(year)
keep if eez == 840
drop tonnes
rename olympia_tonnes tonnes

sort year
merge 1:m year using oysterQ0.dta 
drop _merge
drop if year < 2020
gen delta = (tonnes-tonnes[1])/tonnes[1]
gen olympiaQt85 = olympiaQ0[1]*(1+delta)
keep year olympiaQt85
save olympiaQt85.dta, replace
clear

use easternQt26
merge 1:m year using easternQt85
drop _merge
merge 1:m year using pacificQt26
drop _merge
merge 1:m year using pacificQt85
drop _merge
merge 1:m year using olympiaQt26
drop _merge
merge 1:m year using olympiaQt85
drop _merge

save oyster_harvest_projections.dta, replace
export excel using "C:\Users\CMoore5\OneDrive - Environmental Protection Agency (EPA)\Ocean Acidification\SCOA Damage Functions\stata\harvest_projections\oyster_harvest_projections.xlsx", sheetmodify firstrow(variables)

