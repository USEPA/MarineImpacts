* line plots of harvest projections 

**********************************.
* Clam
use "C:\Users\CMoore5\OneDrive - Environmental Protection Agency (EPA)\Ocean Acidification\SCOA Damage Functions\stata\harvest_projections\clam_harvest_projections.dta"

*Quahog
twoway line quahogQt26 quahogQt85 year, sort
graph export "C:\Users\CMoore5\OneDrive - Environmental Protection Agency (EPA)\Ocean Acidification\SCOA Damage Functions\stata\harvest_projections\line plots\quahog_plot.tif", as(tif) replace

*softclam
twoway line softclamQt26 softclamQt85 year, sort
graph export "C:\Users\CMoore5\OneDrive - Environmental Protection Agency (EPA)\Ocean Acidification\SCOA Damage Functions\stata\harvest_projections\line plots\softclam_plot.tif", as(tif) replace

*geoduck
twoway line geoduckQt26 geoduckQt85 year, sort
graph export "C:\Users\CMoore5\OneDrive - Environmental Protection Agency (EPA)\Ocean Acidification\SCOA Damage Functions\stata\harvest_projections\line plots\geoduck_plot.tif", as(tif) replace

*surfclam
twoway line surfclamQt26 surfclamQt85 year, sort
graph export "C:\Users\CMoore5\OneDrive - Environmental Protection Agency (EPA)\Ocean Acidification\SCOA Damage Functions\stata\harvest_projections\line plots\surfclam_plot.tif", as(tif) replace

***********************************
* Crab
clear
use "C:\Users\CMoore5\OneDrive - Environmental Protection Agency (EPA)\Ocean Acidification\SCOA Damage Functions\stata\harvest_projections\crab_harvest_projections.dta"

*snow
twoway line snowQt26 snowQt85 year, sort
graph export "C:\Users\CMoore5\OneDrive - Environmental Protection Agency (EPA)\Ocean Acidification\SCOA Damage Functions\stata\harvest_projections\line plots\snow_plot.tif", as(tif) replace

*stone
twoway line stoneQt26 stoneQt85 year, sort
graph export "C:\Users\CMoore5\OneDrive - Environmental Protection Agency (EPA)\Ocean Acidification\SCOA Damage Functions\stata\harvest_projections\line plots\stone_plot.tif", as(tif) replace

*king
twoway line kingQt26 kingQt85 year, sort
graph export "C:\Users\CMoore5\OneDrive - Environmental Protection Agency (EPA)\Ocean Acidification\SCOA Damage Functions\stata\harvest_projections\line plots\king_plot.tif", as(tif) replace

*dungeness
twoway line dungenessQt26 dungenessQt85 year, sort
graph export "C:\Users\CMoore5\OneDrive - Environmental Protection Agency (EPA)\Ocean Acidification\SCOA Damage Functions\stata\harvest_projections\line plots\dungeness_plot.tif", as(tif) replace

*blue
twoway line blueQt26 blueQt85 year, sort
graph export "C:\Users\CMoore5\OneDrive - Environmental Protection Agency (EPA)\Ocean Acidification\SCOA Damage Functions\stata\harvest_projections\line plots\blue_plot.tif", as(tif) replace

***********************************
* Lobster
clear
use "C:\Users\CMoore5\OneDrive - Environmental Protection Agency (EPA)\Ocean Acidification\SCOA Damage Functions\stata\harvest_projections\lobster_harvest_projections.dta"

*american
twoway line americanQt26 americanQt85 year, sort
graph export "C:\Users\CMoore5\OneDrive - Environmental Protection Agency (EPA)\Ocean Acidification\SCOA Damage Functions\stata\harvest_projections\line plots\american_plot.tif", as(tif) replace

*spiny
twoway line spinyQt26 spinyQt85 year, sort
graph export "C:\Users\CMoore5\OneDrive - Environmental Protection Agency (EPA)\Ocean Acidification\SCOA Damage Functions\stata\harvest_projections\line plots\spiny_plot.tif", as(tif) replace

**********************************.
* Mussel
use "C:\Users\CMoore5\OneDrive - Environmental Protection Agency (EPA)\Ocean Acidification\SCOA Damage Functions\stata\harvest_projections\mussel_harvest_projections.dta"

twoway line musselQt26 musselQt85 year, sort
graph export "C:\Users\CMoore5\OneDrive - Environmental Protection Agency (EPA)\Ocean Acidification\SCOA Damage Functions\stata\harvest_projections\line plots\mussel_plot.tif", as(tif) replace

***********************************
* Oyster
clear
use "C:\Users\CMoore5\OneDrive - Environmental Protection Agency (EPA)\Ocean Acidification\SCOA Damage Functions\stata\harvest_projections\oyster_harvest_projections.dta"

*eastern
twoway line easternQt26 easternQt85 year, sort
graph export "C:\Users\CMoore5\OneDrive - Environmental Protection Agency (EPA)\Ocean Acidification\SCOA Damage Functions\stata\harvest_projections\line plots\eastern_plot.tif", as(tif) replace

*pacific
twoway line pacificQt26 pacificQt85 year, sort
graph export "C:\Users\CMoore5\OneDrive - Environmental Protection Agency (EPA)\Ocean Acidification\SCOA Damage Functions\stata\harvest_projections\line plots\pacific_plot.tif", as(tif) replace

*olympia
twoway line olympiaQt26 olympiaQt85 year, sort
graph export "C:\Users\CMoore5\OneDrive - Environmental Protection Agency (EPA)\Ocean Acidification\SCOA Damage Functions\stata\harvest_projections\line plots\olympia_plot.tif", as(tif) replace

**********************************.
* Scallop
use "C:\Users\CMoore5\OneDrive - Environmental Protection Agency (EPA)\Ocean Acidification\SCOA Damage Functions\stata\harvest_projections\scallop_harvest_projections.dta"

*Bay
twoway line bayQt26 bayQt85 year, sort
graph export "C:\Users\CMoore5\OneDrive - Environmental Protection Agency (EPA)\Ocean Acidification\SCOA Damage Functions\stata\harvest_projections\line plots\bay_plot.tif", as(tif) replace

*sea
twoway line seaQt26 seaQt85 year, sort
graph export "C:\Users\CMoore5\OneDrive - Environmental Protection Agency (EPA)\Ocean Acidification\SCOA Damage Functions\stata\harvest_projections\line plots\sea_plot.tif", as(tif) replace

*weathervane
twoway line weathervaneQt26 weathervaneQt85 year, sort
graph export "C:\Users\CMoore5\OneDrive - Environmental Protection Agency (EPA)\Ocean Acidification\SCOA Damage Functions\stata\harvest_projections\line plots\weathervane_plot.tif", as(tif) replace

**********************************.
* Shrimp
use "C:\Users\CMoore5\OneDrive - Environmental Protection Agency (EPA)\Ocean Acidification\SCOA Damage Functions\stata\harvest_projections\shrimp_harvest_projections.dta"

*Northern brown
twoway line brownQt26 brownQt85 year, sort
graph export "C:\Users\CMoore5\OneDrive - Environmental Protection Agency (EPA)\Ocean Acidification\SCOA Damage Functions\stata\harvest_projections\line plots\brown_plot.tif", as(tif) replace

*Northern pink
twoway line pinkQt26 pinkQt85 year, sort
graph export "C:\Users\CMoore5\OneDrive - Environmental Protection Agency (EPA)\Ocean Acidification\SCOA Damage Functions\stata\harvest_projections\line plots\pink_plot.tif", as(tif) replace

*Northern white
twoway line whiteQt26 whiteQt85 year, sort
graph export "C:\Users\CMoore5\OneDrive - Environmental Protection Agency (EPA)\Ocean Acidification\SCOA Damage Functions\stata\harvest_projections\line plots\white_plot.tif", as(tif) replace
