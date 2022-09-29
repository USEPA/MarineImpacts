
clear all
cd "C:\Users\CMoore5\OneDrive - Environmental Protection Agency (EPA)\Ocean Acidification\SCOA Damage Functions\stata\harvest_projections"
use all_projections, clear
sort speciesnum
save all_projections, replace

use taxonkey, clear
sort speciesnum 
merge 1:m speciesnum using all_projections

drop if _merge==1
keep if esm == "MEAN"
keep if value == "Cat"
keep if oa == "OA"
keep if year>2019
drop _merge esm value
destring tonnes, replace ignore(",")
egen total_tonnes = total(tonnes), by(year speciesnum rcp)
drop if eez == 841	/* drops duplicate tonnes totals*/
gen mil_lbs = total_tonnes*2204.62
sort speciesnum year
save all_projections_wnames, replace

***clam***

keep if speciesnum == 690270 
line mil_lbs year, by(rcp) title("Quahog") name("a") 
tab commonname

use all_projections_wnames,clear
keep if speciesnum == 690337 
line mil_lbs year, by(rcp) title("Sand Gaper") name("b") 
tab commonname

use all_projections_wnames,clear
keep if speciesnum == 690284
line mil_lbs year, by(rcp) title("Geoduck") name("c") 
tab commonname

use all_projections_wnames,clear
keep if speciesnum == 690033 
line mil_lbs year, by(rcp) title("Surf Clam") name("d") 
tab commonname

***crab***
use all_projections_wnames,clear
keep if speciesnum == 690313 
line mil_lbs year, by(rcp) title("Snow Crab") name("e")
tab commonname 

use all_projections_wnames,clear
keep if speciesnum == 690621
line mil_lbs year, by(rcp) title("King crab") name("f") 
tab commonname

use all_projections_wnames,clear
keep if speciesnum == 690115
line mil_lbs year, by(rcp) title("Dungegness") name("g")
tab commonname

use all_projections_wnames,clear
keep if speciesnum == 690052
line mil_lbs year, by(rcp) title("Blue Crab") name("h") 
tab commonname

***lobster***
use all_projections_wnames,clear
keep if speciesnum == 690010
line mil_lbs year, by(rcp) title("American Lobster") name("i") 
tab commonname

use all_projections_wnames,clear
keep if speciesnum == 690071
line mil_lbs year, by(rcp) title("Spiny") name("j") 
tab commonname

***oyster***
use all_projections_wnames,clear
keep if speciesnum == 690009
line mil_lbs year, by(rcp) title("Eastern") name("k") 
tab commonname

use all_projections_wnames,clear
keep if speciesnum == 690283
line mil_lbs year, by(rcp) title("Pacific") name("l") 
tab commonname

***scallop***
use all_projections_wnames,clear
keep if speciesnum == 690030
line mil_lbs year, by(rcp) title("Bay Scallop") name("m") 
tab commonname

use all_projections_wnames,clear
keep if speciesnum == 690011
line mil_lbs year, by(rcp) title("Sea Scallop") name("n") 
tab commonname

use all_projections_wnames,clear
keep if speciesnum == 690429
line mil_lbs year, by(rcp) title("Weathervane") name("o") 
tab commonname

***shrimp***
use all_projections_wnames,clear
keep if speciesnum == 690265
line mil_lbs year, by(rcp) title("Brown shrimp") name("p") 
tab commonname

use all_projections_wnames,clear
keep if speciesnum == 690268
line mil_lbs year, by(rcp) title("Pink Shrimp") name("q") 
tab commonname

use all_projections_wnames,clear
keep if speciesnum == 690272
line mil_lbs year, by(rcp) title("White Shrimp") name("r") 
tab commonname
