* get clam projections
clear
cd "C:\Users\CMoore5\OneDrive - Environmental Protection Agency (EPA)\Ocean Acidification\SCOA Damage Functions\stata\harvest_projections"

********************************************************************************
* Clam 

*********************************
* Get Clam initial quantities (mean of 2010-2020 harvest)
use "C:\Users\CMoore5\OneDrive - Environmental Protection Agency (EPA)\Ocean Acidification\SCOA Damage Functions\stata\second_stage\clam2s.dta"
keep if year > 2010
egen quahogQ0 	= mean(quahog_pounds)
egen softclamQ0 = mean(soft_clam_pounds)
egen geoduckQ0 	= mean(geoduck_pounds)
egen surfclamQ0 = mean(surf_pounds)
keep year quahogQ0 softclamQ0 geoduckQ0 surfclamQ0
sort year
save "C:\Users\CMoore5\OneDrive - Environmental Protection Agency (EPA)\Ocean Acidification\SCOA Damage Functions\stata\harvest_projections\clamQ0.dta", replace
clear

*********************************
* Quahog projections (Mercenaria mercenaria	Northern quahog)

* RCP 2.6
use clam_projections
destring tonnes, replace
keep if speciesnum == 690270 
keep if oa == "OA"
keep if rcp == "RCP26"

sort year
merge 1:m year using clamQ0.dta 
drop _merge
drop if year < 2020
gen delta = (tonnes-tonnes[1])/tonnes[1]
gen quahogQt26 = quahogQ0[1]*(1+delta)
keep year quahogQt26
save "C:\Users\CMoore5\OneDrive - Environmental Protection Agency (EPA)\Ocean Acidification\SCOA Damage Functions\stata\harvest_projections\quahogQt26.dta", replace
clear

* RCP 8.5
use clam_projections
destring tonnes, replace
keep if speciesnum == 690270 
keep if oa == "OA"
keep if rcp == "RCP85"

sort year
merge 1:m year using clamQ0.dta 
drop _merge
drop if year < 2020
gen delta = (tonnes-tonnes[1])/tonnes[1]
gen quahogQt85 = quahogQ0[1]*(1+delta)
keep year quahogQt85
save "C:\Users\CMoore5\OneDrive - Environmental Protection Agency (EPA)\Ocean Acidification\SCOA Damage Functions\stata\harvest_projections\quahogQt85.dta", replace
clear

*********************************
* Soft clam (Mya arenaria Sand gaper) 
* RCP 2.6
use clam_projections
destring tonnes, replace
keep if speciesnum == 690337 
keep if oa == "OA"
keep if rcp == "RCP26"

sort year
merge 1:m year using clamQ0.dta 
drop _merge
drop if year < 2020
gen delta = (tonnes-tonnes[1])/tonnes[1]
gen softclamQt26 = softclamQ0[1]*(1+delta)
keep year softclamQt26
save "C:\Users\CMoore5\OneDrive - Environmental Protection Agency (EPA)\Ocean Acidification\SCOA Damage Functions\stata\harvest_projections\softclamQt26.dta", replace
clear

* RCP 8.5
use clam_projections
destring tonnes, replace
keep if speciesnum == 690337 
keep if oa == "OA"
keep if rcp == "RCP85"

sort year
merge 1:m year using clamQ0.dta 
drop _merge
drop if year < 2020
gen delta = (tonnes-tonnes[1])/tonnes[1]
gen softclamQt85 = softclamQ0[1]*(1+delta)
keep year softclamQt85
save "C:\Users\CMoore5\OneDrive - Environmental Protection Agency (EPA)\Ocean Acidification\SCOA Damage Functions\stata\harvest_projections\softclamQt85.dta", replace
clear

*********************************
* Geoduck projections (Panopea abrupta	Pacific geoduck)

* RCP 2.6
use clam_projections
destring tonnes, replace
keep if speciesnum == 690284
keep if oa == "OA"
keep if rcp == "RCP26"

****
* Combine geoduck harvest from EEZ 840 & 841
egen geoduck_tonnes = total(tonnes), by(year)
keep if eez == 840
drop tonnes
rename geoduck_tonnes tonnes

sort year
merge 1:m year using clamQ0.dta 
drop _merge
drop if year < 2020
gen delta = (tonnes-tonnes[1])/tonnes[1]
gen geoduckQt26 = geoduckQ0[1]*(1+delta)
keep year geoduckQt26
save "C:\Users\CMoore5\OneDrive - Environmental Protection Agency (EPA)\Ocean Acidification\SCOA Damage Functions\stata\harvest_projections\geoduckQt26.dta", replace
clear

* RCP 8.5
use clam_projections
destring tonnes, replace
keep if speciesnum == 690284 
keep if oa == "OA"
keep if rcp == "RCP85"

****
* Combine geoduck harvest from EEZ 840 & 841
egen geoduck_tonnes = total(tonnes), by(year)
keep if eez == 840
drop tonnes
rename geoduck_tonnes tonnes

sort year
merge 1:m year using clamQ0.dta 
drop _merge
drop if year < 2020
gen delta = (tonnes-tonnes[1])/tonnes[1]
gen geoduckQt85 = geoduckQ0[1]*(1+delta)
keep year geoduckQt85

*********************************
* Temporary fix for geoduck anomoly after 2091
replace geoduckQt85 = 369166.8 if year >2091

save "C:\Users\CMoore5\OneDrive - Environmental Protection Agency (EPA)\Ocean Acidification\SCOA Damage Functions\stata\harvest_projections\geoduckQt85.dta", replace
clear

*********************************
* Surf clam projections (Spisula solida	Surf clam)

* RCP 2.6
use clam_projections
destring tonnes, replace
keep if speciesnum == 690033 
keep if oa == "OA"
keep if rcp == "RCP26"

sort year
merge 1:m year using clamQ0.dta 
drop _merge
drop if year < 2020
gen delta = (tonnes-tonnes[1])/tonnes[1]
gen surfclamQt26 = surfclamQ0[1]*(1+delta)
keep year surfclamQt26
save "C:\Users\CMoore5\OneDrive - Environmental Protection Agency (EPA)\Ocean Acidification\SCOA Damage Functions\stata\harvest_projections\surfclamQt26.dta", replace
clear

* RCP 8.5
use clam_projections
destring tonnes, replace
keep if speciesnum == 690033
keep if oa == "OA"
keep if rcp == "RCP85"

sort year
merge 1:m year using clamQ0.dta 
drop _merge
drop if year < 2020
gen delta = (tonnes-tonnes[1])/tonnes[1]
gen surfclamQt85 = surfclamQ0[1]*(1+delta)
keep year surfclamQt85
save "C:\Users\CMoore5\OneDrive - Environmental Protection Agency (EPA)\Ocean Acidification\SCOA Damage Functions\stata\harvest_projections\surfclamQt85.dta", replace
clear

***************************************
* merge clam projections
use quahogQt26
merge 1:m year using quahogQt85
drop _merge
merge 1:m year using softclamQt26
drop _merge
merge 1:m year using softclamQt85
drop _merge
merge 1:m year using geoduckQt26
drop _merge
merge 1:m year using geoduckQt85
drop _merge
merge 1:m year using surfclamQt26
drop _merge
merge 1:m year using surfclamQt85
drop _merge

save "C:\Users\CMoore5\OneDrive - Environmental Protection Agency (EPA)\Ocean Acidification\SCOA Damage Functions\stata\harvest_projections\clam_harvest_projections.dta", replace
export excel using "C:\Users\CMoore5\OneDrive - Environmental Protection Agency (EPA)\Ocean Acidification\SCOA Damage Functions\stata\harvest_projections\clam_harvest_projections.xlsx", sheetmodify firstrow(variables)
