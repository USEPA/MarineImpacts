* get_tai_projections creates a dataset with only species we plan to analyze with the US model
clear
cd "C:\Users\CMoore5\OneDrive - Environmental Protection Agency (EPA)\Ocean Acidification\SCOA Damage Functions\stata\harvest_projections\canada"

import delimited "C:\Users\CMoore5\OneDrive - Environmental Protection Agency (EPA)\Ocean Acidification\SCOA Damage Functions\Data\Tai Projections\CanadaOAInvertDatabySppandEEZ_USEPA_20220420.csv"
drop if tonnes == "0"
keep if value == "Cat"
drop value
keep if esm == "MEAN"
drop esm
keep if oa == "OA"
drop oa
keep if year>2019
drop eez
destring tonnes, ignore(",") replace
rename species speciesnum
sort speciesnum
save nonzero_harvest, replace

use "C:\Users\CMoore5\OneDrive - Environmental Protection Agency (EPA)\Ocean Acidification\SCOA Damage Functions\Data\Tai Projections\taxonkey.dta", clear
sort speciesnum
merge 1:m speciesnum using nonzero_harvest
keep if _merge == 3
drop _merge
save nonzero_harvest_wnames, replace

* clam
keep if speciesnum == 690275	/*Ocean quahog*/
keep if rcp == "RCP26"
sort year
gen delta = (tonnes-tonnes[1])/tonnes[1]
save clam26_projection, replace
export excel using "C:\Users\CMoore5\OneDrive - Environmental Protection Agency (EPA)\Ocean Acidification\SCOA Damage Functions\stata\harvest_projections\canada\clam26_projection.xls", firstrow(variables) replace
use nonzero_harvest_wnames, clear
keep if speciesnum == 690275	/*Ocean quahog*/
keep if rcp == "RCP85"
sort year
gen delta = (tonnes-tonnes[1])/tonnes[1]
save clam85_projection, replace
export excel using "C:\Users\CMoore5\OneDrive - Environmental Protection Agency (EPA)\Ocean Acidification\SCOA Damage Functions\stata\harvest_projections\canada\clam85_projection.xls", firstrow(variables) replace
* oysters
use nonzero_harvest_wnames, clear
keep if speciesnum == 690009	/*American (eastern) cupped oyster*/
keep if rcp == "RCP26"
sort year
gen delta = (tonnes-tonnes[1])/tonnes[1]
save oyster26_projection, replace
export excel using "C:\Users\CMoore5\OneDrive - Environmental Protection Agency (EPA)\Ocean Acidification\SCOA Damage Functions\stata\harvest_projections\canada\oyster26_projection.xls", firstrow(variables) replace
use nonzero_harvest_wnames, clear
keep if speciesnum == 690009	/*American (eastern) cupped oyster*/
keep if rcp == "RCP85"
sort year
gen delta = (tonnes-tonnes[1])/tonnes[1]
save oyster85_projection, replace
export excel using "C:\Users\CMoore5\OneDrive - Environmental Protection Agency (EPA)\Ocean Acidification\SCOA Damage Functions\stata\harvest_projections\canada\oyster85_projection.xls", firstrow(variables) replace
* scallop
use nonzero_harvest_wnames, clear
keep if speciesnum == 690011	/*American sea scallop*/
keep if rcp == "RCP26"
sort year
gen delta = (tonnes-tonnes[1])/tonnes[1]
save scallop26_projection, replace
export excel using "C:\Users\CMoore5\OneDrive - Environmental Protection Agency (EPA)\Ocean Acidification\SCOA Damage Functions\stata\harvest_projections\canada\scallop26_projection.xls", firstrow(variables) replace
use nonzero_harvest_wnames, clear
keep if speciesnum == 690011	/*American sea scallop*/
keep if rcp == "RCP85"
sort year
gen delta = (tonnes-tonnes[1])/tonnes[1]
save scallop85_projection, replace
export excel using "C:\Users\CMoore5\OneDrive - Environmental Protection Agency (EPA)\Ocean Acidification\SCOA Damage Functions\stata\harvest_projections\canada\scallop85_projection.xls", firstrow(variables) replace
* lobster
use nonzero_harvest_wnames, clear
keep if speciesnum == 690010	/*American lobster*/
keep if rcp == "RCP26"
sort year
gen delta = (tonnes-tonnes[1])/tonnes[1]
save lobster26_projection, replace
export excel using "C:\Users\CMoore5\OneDrive - Environmental Protection Agency (EPA)\Ocean Acidification\SCOA Damage Functions\stata\harvest_projections\canada\lobster26_projection.xls", firstrow(variables) replace
use nonzero_harvest_wnames, clear
keep if speciesnum == 690010	/*American lobster*/
keep if rcp == "RCP85"
sort year
gen delta = (tonnes-tonnes[1])/tonnes[1]
save lobster85_projection, replace
export excel using "C:\Users\CMoore5\OneDrive - Environmental Protection Agency (EPA)\Ocean Acidification\SCOA Damage Functions\stata\harvest_projections\canada\lobster85_projection.xls", firstrow(variables) replace

* shrimp
use nonzero_harvest_wnames, clear
keep if speciesnum == 690269	/*Northern prawn*/
keep if rcp == "RCP26"
sort year
gen delta = (tonnes-tonnes[1])/tonnes[1]
save shrimp26_projection, replace
export excel using "C:\Users\CMoore5\OneDrive - Environmental Protection Agency (EPA)\Ocean Acidification\SCOA Damage Functions\stata\harvest_projections\canada\shrimp26_projection.xls", firstrow(variables) replace
use nonzero_harvest_wnames, clear
keep if speciesnum == 690269	/*Northern brown shrimp*/
keep if rcp == "RCP85"
sort year
gen delta = (tonnes-tonnes[1])/tonnes[1]
save shrimp85_projection, replace
export excel using "C:\Users\CMoore5\OneDrive - Environmental Protection Agency (EPA)\Ocean Acidification\SCOA Damage Functions\stata\harvest_projections\canada\shrimp85_projection.xls", firstrow(variables) replace
* snow crab
use nonzero_harvest_wnames, clear
keep if speciesnum == 690313	/*Snow crab*/
keep if rcp == "RCP26"
sort year
gen delta = (tonnes-tonnes[1])/tonnes[1]
save snowcrab26_projection, replace
export excel using "C:\Users\CMoore5\OneDrive - Environmental Protection Agency (EPA)\Ocean Acidification\SCOA Damage Functions\stata\harvest_projections\canada\snowcrab26_projection.xls", firstrow(variables) replace
use nonzero_harvest_wnames, clear
keep if speciesnum == 690313	/*Snow crab*/
keep if rcp == "RCP85"
sort year
gen delta = (tonnes-tonnes[1])/tonnes[1]
save snowcrab85_projection, replace
export excel using "C:\Users\CMoore5\OneDrive - Environmental Protection Agency (EPA)\Ocean Acidification\SCOA Damage Functions\stata\harvest_projections\canada\snowcrab85_projection.xls", firstrow(variables) replace
* "other" crab
use nonzero_harvest_wnames, clear
keep if speciesnum == 690115	/*Dungeness crab*/
keep if rcp == "RCP26"
sort year
gen delta = (tonnes-tonnes[1])/tonnes[1]
save dungeness26_projection, replace
export excel using "C:\Users\CMoore5\OneDrive - Environmental Protection Agency (EPA)\Ocean Acidification\SCOA Damage Functions\stata\harvest_projections\canada\dungeness26_projection.xls", firstrow(variables) replace
use nonzero_harvest_wnames, clear
keep if speciesnum == 690115	/*Dungeness crab*/
keep if rcp == "RCP85"
sort year
gen delta = (tonnes-tonnes[1])/tonnes[1]
save dungeness85_projection, replace
export excel using "C:\Users\CMoore5\OneDrive - Environmental Protection Agency (EPA)\Ocean Acidification\SCOA Damage Functions\stata\harvest_projections\canada\dungeness85_projection.xls", firstrow(variables) replace
