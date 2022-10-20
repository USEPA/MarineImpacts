* first_stage_data_import.do imports raw csv data downloaded from NMFS for estimation of first stage model
* first stage model operates on annual type totals, e.g., all clams, all crabs, etc...

clear
cd "C:\Users\CMoore5\OneDrive - Environmental Protection Agency (EPA)\Ocean Acidification\SCOA Damage Functions\stata\united_states\Raw QV Downloads"

* clam
import delimited "C:\Users\CMoore5\OneDrive - Environmental Protection Agency (EPA)\Ocean Acidification\SCOA Damage Functions\stata\united_states\Raw QV Downloads\clam_landings_total.csv"
rename pounds clam_pounds
rename dollars clam_nominal_dollars
sort year
save "C:\Users\CMoore5\OneDrive - Environmental Protection Agency (EPA)\Ocean Acidification\SCOA Damage Functions\stata\united_states\first_stage\data\clam_total.dta", replace

clear

* crab
import delimited "C:\Users\CMoore5\OneDrive - Environmental Protection Agency (EPA)\Ocean Acidification\SCOA Damage Functions\stata\united_states\Raw QV Downloads\crab_landings_total.csv"
rename pounds crab_pounds
rename dollars crab_nominal_dollars
sort year
save "C:\Users\CMoore5\OneDrive - Environmental Protection Agency (EPA)\Ocean Acidification\SCOA Damage Functions\stata\united_states\first_stage\data\crab_total.dta", replace
clear

* mussel
import delimited "C:\Users\CMoore5\OneDrive - Environmental Protection Agency (EPA)\Ocean Acidification\SCOA Damage Functions\stata\united_states\Raw QV Downloads\mussel_landings_total.csv"
rename pounds mussel_pounds
rename dollars mussel_nominal_dollars
sort year
save "C:\Users\CMoore5\OneDrive - Environmental Protection Agency (EPA)\Ocean Acidification\SCOA Damage Functions\stata\united_states\first_stage\data\mussel_total.dta", replace
clear

* lobster
import delimited "C:\Users\CMoore5\OneDrive - Environmental Protection Agency (EPA)\Ocean Acidification\SCOA Damage Functions\stata\united_states\Raw QV Downloads\lobster_landings_total.csv"
rename pounds lobster_pounds
rename dollars lobster_nominal_dollars
sort year
save "C:\Users\CMoore5\OneDrive - Environmental Protection Agency (EPA)\Ocean Acidification\SCOA Damage Functions\stata\united_states\first_stage\data\lobster_total.dta", replace
clear

* oyster
import delimited "C:\Users\CMoore5\OneDrive - Environmental Protection Agency (EPA)\Ocean Acidification\SCOA Damage Functions\stata\united_states\Raw QV Downloads\oyster_landings_total.csv"
rename pounds oyster_pounds
rename dollars oyster_nominal_dollars
sort year
save "C:\Users\CMoore5\OneDrive - Environmental Protection Agency (EPA)\Ocean Acidification\SCOA Damage Functions\stata\united_states\first_stage\data\oyster_total.dta", replace
clear

* scallop
import delimited "C:\Users\CMoore5\OneDrive - Environmental Protection Agency (EPA)\Ocean Acidification\SCOA Damage Functions\stata\united_states\Raw QV Downloads\scallop_landings_total.csv"
rename pounds scallop_pounds
rename dollars scallop_nominal_dollars
sort year
save "C:\Users\CMoore5\OneDrive - Environmental Protection Agency (EPA)\Ocean Acidification\SCOA Damage Functions\stata\united_states\first_stage\data\scallop_total.dta", replace
clear

* shrimp
import delimited "C:\Users\CMoore5\OneDrive - Environmental Protection Agency (EPA)\Ocean Acidification\SCOA Damage Functions\stata\united_states\Raw QV Downloads\shrimp_landings_total.csv"
rename pounds shrimp_pounds
rename dollars shrimp_nominal_dollars
sort year
save "C:\Users\CMoore5\OneDrive - Environmental Protection Agency (EPA)\Ocean Acidification\SCOA Damage Functions\stata\united_states\first_stage\data\shrimp_total.dta", replace
clear

cd "C:\Users\CMoore5\OneDrive - Environmental Protection Agency (EPA)\Ocean Acidification\SCOA Damage Functions\stata\united_states\first_stage\data"
use clam_total
merge 1:m year using crab_total
drop _merge
merge 1:m year using mussel_total
drop _merge
merge 1:m year using lobster_total
drop _merge
merge 1:m year using oyster_total
drop _merge
merge 1:m year using scallop_total
drop _merge
merge 1:m year using shrimp_total
drop _merge

save "C:\Users\CMoore5\OneDrive - Environmental Protection Agency (EPA)\Ocean Acidification\SCOA Damage Functions\stata\united_states\first_stage\data\raw_total", replace
