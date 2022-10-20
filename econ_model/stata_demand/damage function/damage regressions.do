
use damage_model_data_ph, clear

drop if year > 2089
gen US_Damages = usdamages*10^-6
gen CAN_Damages = candamages*10^-6
gen Temperature_Change = avgtemp-14.60199

keep if scenario=="rcp85"
regress US_Damages Temperature_Change 
regress CAN_Damages Temperature_Change
twoway (scatter US_Damages Temperature_Change) (lfit US_Damages Temperature_Change) (scatter CAN_Damages Temperature_Change) (lfit CAN_Damages Temperature_Change)

graph export "C:\Users\CMoore5\OneDrive - Environmental Protection Agency (EPA)\Ocean Acidification\SCOA Damage Functions\AERE Summer 2022Presentation\figures\damage function graph.png", as(png) replace

