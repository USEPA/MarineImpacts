

cd "C:\Users\CMoore5\OneDrive - Environmental Protection Agency (EPA)\Ocean Acidification\SCOA Damage Functions\stata\harvest_projections"
clear
use clam_harvest_projections.dta
egen clamQt26 = rowtotal(quahogQt26 softclamQt26 geoduckQt26 surfclamQt26)
egen clamQt85 = rowtotal(quahogQt85 softclamQt85 geoduckQt85 surfclamQt85)

merge 1:m year using crab_harvest_projections 
drop _merge
egen crabQt26 = rowtotal(snowQt26 stoneQt26 kingQt26 dungenessQt26 blueQt26)
egen crabQt85 = rowtotal(snowQt85 stoneQt85 kingQt85 dungenessQt85 blueQt85)

merge 1:m year using lobster_harvest_projections 
drop _merge
egen lobsterQt26 = rowtotal(americanQt26 spinyQt26)
egen lobsterQt85 = rowtotal(americanQt85 spinyQt85)

merge 1:m year using mussel_harvest_projections 
drop _merge

merge 1:m year using oyster_harvest_projections 
drop _merge
egen oysterQt26 = rowtotal(easternQt26 pacificQt26)
egen oysterQt85 = rowtotal(easternQt85 pacificQt85)

merge 1:m year using scallop_harvest_projections 
drop _merge
egen scallopQt26 = rowtotal(bayQt26 seaQt26 weathervaneQt26)
egen scallopQt85 = rowtotal(bayQt85 seaQt85 weathervaneQt85)

merge 1:m year using shrimp_harvest_projections 
drop _merge
egen shrimpQt26 = rowtotal(brownQt26 pinkQt26 whiteQt26)
egen shrimpQt85 = rowtotal(brownQt85 pinkQt85 whiteQt85)

keep year clam* crab* lobster* mussel* oyster* scallop* shrimp*

export excel using "C:\Users\CMoore5\OneDrive - Environmental Protection Agency (EPA)\Ocean Acidification\SCOA Damage Functions\stata\harvest_projections\aggregate_projections_for_welfare.xls", firstrow(variables) replace

* Create stata dataset with projections to predict first stage expenditure shares
gen lnX1  = ln( clamQt26 )
gen lnX2  = ln( crabQt26 )
gen lnX3  = ln( lobsterQt26 )
gen lnX4  = ln( musselQt26 )
gen lnX5  = ln( oysterQt26 )
gen lnX6  = ln( scallopQt26 )
gen lnX7  = ln( shrimpQt26 )

save rcp26_1s_projections.dta, replace

drop lnX*
gen lnX1  = ln( clamQt85 )
gen lnX2  = ln( crabQt85 )
gen lnX3  = ln( lobsterQt85 )
gen lnX4  = ln( musselQt85 	)
gen lnX5  = ln( oysterQt85 	)
gen lnX6  = ln( scallopQt85 )
gen lnX7  = ln( shrimpQt85 	)

save rcp85_1s_projections.dta, replace

