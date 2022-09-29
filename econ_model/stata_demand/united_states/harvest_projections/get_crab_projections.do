* get crab projections
clear
cd "C:\Users\CMoore5\OneDrive - Environmental Protection Agency (EPA)\Ocean Acidification\SCOA Damage Functions\stata\harvest_projections"

********************************************************************************
* Crab

*********************************
* Get Crab initial quantities (mean of 2010-2020 harvest)
use "C:\Users\CMoore5\OneDrive - Environmental Protection Agency (EPA)\Ocean Acidification\SCOA Damage Functions\stata\second_stage\crab2s.dta"
keep if year > 2010
egen snowQ0 	= mean(tanner_pounds)
egen stoneQ0 	= mean(stone_pounds)
egen kingQ0 	= mean(king_pounds)
egen dungenessQ0= mean(dungeness_pounds)
egen blueQ0 	= mean(blue_pounds)
keep year snowQ0 stoneQ0 kingQ0 dungenessQ0 blueQ0
sort year
save crabQ0.dta, replace
clear

*********************************
* Tanner (Chionoecetes opilio	Snow crab) projections 

* RCP 2.6
use crab_projections
destring tonnes, replace
keep if speciesnum == 690313 
keep if oa == "OA"
keep if rcp == "RCP26"

****
* Combine snowcrab harvest from EEZ 840 & 841
egen snow_tonnes = total(tonnes), by(year)
keep if eez == 840
drop tonnes
rename snow_tonnes tonnes

sort year
merge 1:m year using crabQ0.dta 
drop _merge
drop if year < 2020
gen delta = (tonnes-tonnes[1])/tonnes[1]
gen snowQt26 = snowQ0[1]*(1+delta)
keep year snowQt26
save snowQt26.dta, replace
clear

* RCP 8.5
use crab_projections
destring tonnes, replace
keep if speciesnum == 690313 
keep if oa == "OA"
keep if rcp == "RCP85"

****
* Combine snowcrab harvest from EEZ 840 & 841
egen snow_tonnes = total(tonnes), by(year)
keep if eez == 840
drop tonnes
rename snow_tonnes tonnes

sort year
merge 1:m year using crabQ0.dta 
drop _merge
drop if year < 2020
gen delta = (tonnes-tonnes[1])/tonnes[1]
gen snowQt85 = snowQ0[1]*(1+delta)
keep year snowQt85
save snowQt85.dta, replace
clear

*********************************
* Stone crab projections (Menippe mercenaria	Black stone crab)

* RCP 2.6
use crab_projections
destring tonnes, replace
keep if speciesnum == 690047 
keep if oa == "OA"
keep if rcp == "RCP26"

sort year
merge 1:m year using crabQ0.dta 
drop _merge
drop if year < 2020
gen delta = (tonnes-tonnes[1])/tonnes[1]
gen stoneQt26 = stoneQ0[1]*(1+delta)
keep year stoneQt26
save stoneQt26.dta, replace
clear

* RCP 8.5
use crab_projections
destring tonnes, replace
keep if speciesnum == 690047 
keep if oa == "OA"
keep if rcp == "RCP85"

sort year
merge 1:m year using crabQ0.dta 
drop _merge
drop if year < 2020
gen delta = (tonnes-tonnes[1])/tonnes[1]
gen stoneQt85 = stoneQ0[1]*(1+delta)
keep year stoneQt85
save stoneQt85.dta, replace
clear

*********************************
* King crab projections (Paralithodes camtschaticus	Red king crab)

* RCP 2.6
use crab_projections
destring tonnes, replace
keep if speciesnum == 690621 
keep if oa == "OA"
keep if rcp == "RCP26"

****
* Combine king crab harvest from EEZ 840 & 841
egen king_tonnes = total(tonnes), by(year)
keep if eez == 840
drop tonnes
rename king_tonnes tonnes

sort year
merge 1:m year using crabQ0.dta 
drop _merge
drop if year < 2020
gen delta = (tonnes-tonnes[1])/tonnes[1]
gen kingQt26 = kingQ0[1]*(1+delta)
keep year kingQt26
save kingQt26.dta, replace
clear

* RCP 8.5
use crab_projections
destring tonnes, replace
keep if speciesnum == 690621 
keep if oa == "OA"
keep if rcp == "RCP85"

****
* Combine king crab harvest from EEZ 840 & 841
egen king_tonnes = total(tonnes), by(year)
keep if eez == 840
drop tonnes
rename king_tonnes tonnes

sort year
merge 1:m year using crabQ0.dta 
drop _merge
drop if year < 2020
gen delta = (tonnes-tonnes[1])/tonnes[1]
gen kingQt85 = kingQ0[1]*(1+delta)
keep year kingQt85
save kingQt85.dta, replace
clear

*********************************
* Dungeness crab projections (Cancer magister	Dungeness crab)

* RCP 2.6
use crab_projections
destring tonnes, replace
keep if speciesnum == 690115 
keep if oa == "OA"
keep if rcp == "RCP26"

****
* Combine dungeness crab harvest from EEZ 840 & 841
egen dungeness_tonnes = total(tonnes), by(year)
keep if eez == 840
drop tonnes
rename dungeness_tonnes tonnes

sort year
merge 1:m year using crabQ0.dta 
drop _merge
drop if year < 2020
gen delta = (tonnes-tonnes[1])/tonnes[1]
gen dungenessQt26 = dungenessQ0[1]*(1+delta)
keep year dungenessQt26
save dungenessQt26.dta, replace
clear

* RCP 8.5
use crab_projections
destring tonnes, replace
keep if speciesnum == 690115 
keep if oa == "OA"
keep if rcp == "RCP85"

****
* Combine dungeness crab harvest from EEZ 840 & 841
egen dungeness_tonnes = total(tonnes), by(year)
keep if eez == 840
drop tonnes
rename dungeness_tonnes tonnes

sort year
merge 1:m year using crabQ0.dta 
drop _merge
drop if year < 2020
gen delta = (tonnes-tonnes[1])/tonnes[1]
gen dungenessQt85 = dungenessQ0[1]*(1+delta)
keep year dungenessQt85
save dungenessQt85.dta, replace
clear

*********************************
* Blue crab projections (Callinectes sapidus	Blue crab)

* RCP 2.6
use crab_projections
destring tonnes, replace
keep if speciesnum == 690052 
keep if oa == "OA"
keep if rcp == "RCP26"

sort year
merge 1:m year using crabQ0.dta 
drop _merge
drop if year < 2020
gen delta = (tonnes-tonnes[1])/tonnes[1]
gen blueQt26 = blueQ0[1]*(1+delta)
keep year blueQt26
save blueQt26.dta, replace
clear

* RCP 8.5
use crab_projections
destring tonnes, replace
keep if speciesnum == 690052 
keep if oa == "OA"
keep if rcp == "RCP85"

sort year
merge 1:m year using crabQ0.dta 
drop _merge
drop if year < 2020
gen delta = (tonnes-tonnes[1])/tonnes[1]
gen blueQt85 = blueQ0[1]*(1+delta)
keep year blueQt85
save blueQt85.dta, replace
clear

***************************************
* merge clam projections
use snowQt26
merge 1:m year using snowQt85
drop _merge
merge 1:m year using stoneQt26
drop _merge
merge 1:m year using stoneQt85
drop _merge
merge 1:m year using kingQt26
drop _merge
merge 1:m year using kingQt85
drop _merge
merge 1:m year using dungenessQt26
drop _merge
merge 1:m year using dungenessQt85
drop _merge
merge 1:m year using blueQt26
drop _merge
merge 1:m year using blueQt85
drop _merge

save crab_harvest_projections.dta, replace
export excel using "C:\Users\CMoore5\OneDrive - Environmental Protection Agency (EPA)\Ocean Acidification\SCOA Damage Functions\stata\harvest_projections\crab_harvest_projections.xlsx", sheetmodify firstrow(variables)
