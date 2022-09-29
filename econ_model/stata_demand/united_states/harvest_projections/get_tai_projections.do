* get_tai_projections creates a dataset with only species we plan to analyze with the US model
clear
cd "C:\Users\CMoore5\OneDrive - Environmental Protection Agency (EPA)\Ocean Acidification\SCOA Damage Functions\stata\harvest_projections"

import delimited "C:\Users\CMoore5\OneDrive - Environmental Protection Agency (EPA)\Ocean Acidification\SCOA Damage Functions\Data\Tai Projections\GlobalOAInvertDatabySppandEEZ_USEPA_20220420.csv"
drop if tonnes == "0"
keep if value == "Cat"
keep if esm == "MEAN"
destring tonnes, ignore(",") replace
gen name = "blank"
rename species speciesnum
save nonzero_harvest, replace

* 				geoduck,quahog,sandgaper,surfclam
keep if inlist(speciesnum,690284,690270,690337,690033)
replace name = "geoduck" 	if speciesnum == 690284
replace name = "quahog" 	if speciesnum == 690270
replace name = "sandgaper" 	if speciesnum == 690337
replace name = "surfclam" 	if speciesnum == 690033
sort speciesnum rcp oa year
export excel using "projections", sheet("clam") sheetreplace firstrow(variables)
save clam_projections, replace
clear
use nonzero_harvest
*					        blue,dungeness,stone,king,snow(tanner)
keep if inlist(speciesnum,690052,690115,690047,690621,690313)
replace name = "bluecrab" 	if speciesnum == 690052
replace name = "dungeness" 	if speciesnum == 690115
replace name = "stonecrab" 	if speciesnum == 690047
replace name = "kingcrab" 	if speciesnum == 690621
replace name = "snowcrab" 	if speciesnum == 690313
sort speciesnum rcp oa year
export excel using "projections", sheet("crab") sheetreplace firstrow(variables)
save crab_projections, replace
clear
use nonzero_harvest
*			    american lobster,caribbean spiny
keep if inlist(speciesnum,690010,690071)
replace name = "american" 	if speciesnum == 690010
replace name = "spiny" 		if speciesnum == 690071
sort speciesnum rcp oa year
export excel using "projections", sheet("lobster") sheetreplace firstrow(variables)
save lobster_projections, replace
clear
use nonzero_harvest
*					    bluemussel
keep if inlist(speciesnum,690053)
replace name = "bluemussel" if speciesnum == 690284
sort speciesnum rcp oa year
export excel using "projections", sheet("mussel") sheetreplace firstrow(variables)
save mussel_projections, replace
clear
use nonzero_harvest
*                        olympia,pacific,eastern
keep if inlist(speciesnum,690279,690283,690009)
replace name = "olympia" if speciesnum == 690279
replace name = "pacific" if speciesnum == 690283
replace name = "eastern" if speciesnum == 690009
sort speciesnum rcp oa year
export excel using "projections", sheet("oyster") sheetreplace firstrow(variables)
save oyster_projections, replace
clear
use nonzero_harvest
*						    sea,bay,weathervane
keep if inlist(speciesnum,690011,690030,690429)
replace name = "seascallop" if speciesnum == 690011
replace name = "bayscallop" if speciesnum == 690030
replace name = "weathervane" if speciesnum == 690429
sort speciesnum rcp oa year
export excel using "projections", sheet("scallop") sheetreplace firstrow(variables)
save scallop_projections, replace
clear
use nonzero_harvest
*						brown,pink,white,
keep if inlist(speciesnum,690265,690268,690272)
replace name = "brownshrimp" if speciesnum == 690265
replace name = "pinkshrimp" if speciesnum == 690268
replace name = "whiteshrimp" if speciesnum == 690272
sort speciesnum rcp oa year
export excel using "projections", sheet("shrimp") sheetreplace firstrow(variables)
save shrimp_projections, replace
