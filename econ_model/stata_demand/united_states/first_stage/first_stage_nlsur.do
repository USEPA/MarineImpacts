*  
cd "C:\Users\CMoore5\OneDrive - Environmental Protection Agency (EPA)\Ocean Acidification\SCOA Damage Functions\stata\united_states\first_stage"
discard
clear 
set more off
use "C:\Users\CMoore5\OneDrive - Environmental Protection Agency (EPA)\Ocean Acidification\SCOA Damage Functions\stata\united_states\first_stage\data\first_stage_model_data.dta"

* Dropped mussels because small expenditure shares (<.01) are creating numerical issues in post-estimation processing (e.g. welfare estimates and flexibilities)

* Call nonlinear SUR and evaluate the function program nlsur7Eqs
egen u = rowmiss(w1 w2 w3 w4 w5 lnX1 lnX2 lnX3 lnX4 lnX5 lnX6 )
nlsur X6Eqs @ w1 w2 w3 w4 w5 lnX1 lnX2 lnX3 lnX4 lnX5 lnX6 if u==0, ///
				parameters( a1  a2  a3  a4  a5  ///
							b1  b2  b3  b4  b5  ///
							g11 g12 g13 g14 g15 ///
							    g22 g23 g24 g25 ///
							        g33 g34 g35 ///
							            g44 g45 ///
											g55) neq(5)

putexcel set first_stage_results, sheet("coefs",replace) modify
putexcel A1=matrix(r(table)), names

estat summarize 
putexcel set first_stage_results, sheet("means",replace) modify
putexcel A1 = matrix(r(stats)),names

matrix V=get(VCE)
matrix list V
putexcel set first_stage_results, sheet("covar_matrix",replace) modify 
putexcel A1 = matrix(V), names
putexcel close

use "C:\Users\CMoore5\OneDrive - Environmental Protection Agency (EPA)\Ocean Acidification\SCOA Damage Functions\stata\united_states\harvest_projections\rcp26_1s_projections.dta", clear
							
predict w1_hat26, eq(#1)
predict w2_hat26, eq(#2)
predict w3_hat26, eq(#3)
predict w4_hat26, eq(#4)
predict w5_hat26, eq(#5)
gen w6_hat26 = 1-(w1_hat26+w2_hat26+w3_hat26+w4_hat26+w5_hat26) 
export excel w1_hat26 w2_hat26 w3_hat26 w4_hat26 w5_hat26 w6_hat26 using "C:\Users\CMoore5\OneDrive - Environmental Protection Agency (EPA)\Ocean Acidification\SCOA Damage Functions\stata\united_states\first_stage\first_stage_results.xlsx", sheet("w_hat26") sheetmodify firstrow(variables)

use "C:\Users\CMoore5\OneDrive - Environmental Protection Agency (EPA)\Ocean Acidification\SCOA Damage Functions\stata\united_states\harvest_projections\rcp85_1s_projections.dta", clear
							
predict w1_hat85, eq(#1)
predict w2_hat85, eq(#2)
predict w3_hat85, eq(#3)
predict w4_hat85, eq(#4)
predict w5_hat85, eq(#5)
gen w6_hat85 = 1-(w1_hat85+w2_hat85+w3_hat85+w4_hat85+w5_hat85)
export excel w1_hat85 w2_hat85 w3_hat85 w4_hat85 w5_hat85 w6_hat85 using "C:\Users\CMoore5\OneDrive - Environmental Protection Agency (EPA)\Ocean Acidification\SCOA Damage Functions\stata\united_states\first_stage\first_stage_results.xlsx", sheet("w_hat85") sheetmodify firstrow(variables)


