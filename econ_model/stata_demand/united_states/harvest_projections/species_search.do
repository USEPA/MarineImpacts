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

*crab search
*keep if inlist(speciesnum,690031,690047,690052,690055,690105,690115,690158,690203,690211,690287,690320,690325,690377,690399,690406,690625,690753,690821,690885,690901)

*oyster search
keep if inlist(speciesnum,690009,690048,690075,690094,690123,690177,690200,690229,690232,690279,690283,690363,690364,690407,690888)
sort year speciesnum
tab commonname
