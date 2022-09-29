* get scallop projections
clear
cd "C:\Users\CMoore5\OneDrive - Environmental Protection Agency (EPA)\Ocean Acidification\SCOA Damage Functions\stata\harvest_projections"

********************************************************************************
* scallop

*********************************
* Get Crab initial quantities (mean of 2010-2020 harvest)
use "C:\Users\CMoore5\OneDrive - Environmental Protection Agency (EPA)\Ocean Acidification\SCOA Damage Functions\stata\second_stage\scallop2s.dta"
keep if year > 2010
egen bayQ0 		 	= mean(bay_pounds)
egen seaQ0 			= mean(sea_pounds)
egen weathervaneQ0 	= mean(weathervane_pounds)
keep year bayQ0 seaQ0 weathervaneQ0 
sort year
save scallopQ0.dta, replace
clear

*********************************
* Bay scallop projections (Argopecten irradians	Atlantic bay scallop)

* RCP 2.6
use scallop_projections
destring tonnes, replace
keep if speciesnum == 690030 
keep if oa == "OA"
keep if rcp == "RCP26"

sort year
merge 1:m year using scallopQ0.dta 
drop _merge
drop if year < 2020
gen delta = (tonnes-tonnes[1])/tonnes[1]
gen bayQt26 = bayQ0[1]*(1+delta)
keep year bayQt26
save bayQt26.dta, replace
clear

* RCP 8.5
use scallop_projections
destring tonnes, replace
keep if speciesnum == 690030
keep if oa == "OA"
keep if rcp == "RCP85"

sort year
merge 1:m year using scallopQ0.dta 
drop _merge
drop if year < 2020
gen delta = (tonnes-tonnes[1])/tonnes[1]
gen bayQt85 = bayQ0[1]*(1+delta)
keep year bayQt85
save bayQt85.dta, replace
clear

**********************************
* Sea scallop projections (Placopecten magellanicus	American sea scallop)

* RCP 2.6
use scallop_projections
destring tonnes, replace
keep if speciesnum == 690011 
keep if oa == "OA"
keep if rcp == "RCP26"

sort year
merge 1:m year using scallopQ0.dta 
drop _merge
drop if year < 2020
gen delta = (tonnes-tonnes[1])/tonnes[1]
gen seaQt26 = seaQ0[1]*(1+delta)
keep year seaQt26
save seaQt26.dta, replace
clear

* RCP 8.5
use scallop_projections
destring tonnes, replace
keep if speciesnum == 690011
keep if oa == "OA"
keep if rcp == "RCP85"

sort year
merge 1:m year using scallopQ0.dta 
drop _merge
drop if year < 2020
gen delta = (tonnes-tonnes[1])/tonnes[1]
gen seaQt85 = seaQ0[1]*(1+delta)
keep year seaQt85
save seaQt85.dta, replace
clear

**********************************
* Weathervane scallop projections (Patinopecten caurinus	Weathervane scallop)

* RCP 2.6
use scallop_projections
destring tonnes, replace
keep if speciesnum == 690429 
keep if oa == "OA"
keep if rcp == "RCP26"

****
* Combine weathervane harvest from EEZ 840 & 841
egen weathervane_tonnes = total(tonnes), by(year)
keep if eez == 840
drop tonnes
rename weathervane_tonnes tonnes

sort year
merge 1:m year using scallopQ0.dta 
drop _merge
drop if year < 2020
gen delta = (tonnes-tonnes[1])/tonnes[1]
gen weathervaneQt26 = weathervaneQ0[1]*(1+delta)
keep year weathervaneQt26
save weathervaneQt26.dta, replace
clear

* RCP 8.5
use scallop_projections
destring tonnes, replace
keep if speciesnum == 690429
keep if oa == "OA"
keep if rcp == "RCP85"

****
* Combine weathervane harvest from EEZ 840 & 841
egen weathervane_tonnes = total(tonnes), by(year)
keep if eez == 840
drop tonnes
rename weathervane_tonnes tonnes

sort year
merge 1:m year using scallopQ0.dta 
drop _merge
drop if year < 2020
gen delta = (tonnes-tonnes[1])/tonnes[1]
gen weathervaneQt85 = weathervaneQ0[1]*(1+delta)
keep year weathervaneQt85
save weathervaneQt85.dta, replace
clear

***************************************
* merge clam projections
use bayQt26
merge 1:m year using bayQt85
drop _merge
merge 1:m year using seaQt26
drop _merge
merge 1:m year using seaQt85
drop _merge
merge 1:m year using weathervaneQt26
drop _merge
merge 1:m year using weathervaneQt85
drop _merge

save scallop_harvest_projections.dta, replace
export excel using "C:\Users\CMoore5\OneDrive - Environmental Protection Agency (EPA)\Ocean Acidification\SCOA Damage Functions\stata\harvest_projections\scallop_harvest_projections.xlsx", sheetmodify firstrow(variables)
