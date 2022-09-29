*  
cd "C:\Users\CMoore5\OneDrive - Environmental Protection Agency (EPA)\Ocean Acidification\SCOA Damage Functions\stata\united_states\second_stage"
discard
clear 
set more off
***********************************************************************
* clam
use "C:\Users\cmoore5\OneDrive - Environmental Protection Agency (EPA)\Ocean Acidification\SCOA Damage Functions\stata\united_states\second_stage\data\clam2s_model_data"

* Call nonlinear SUR and evaluate the function program nlsur4Eqs
egen u = rowmiss(w1 w2 w3 lnX1 lnX2 lnX3 lnX4)
nlsur X4Eqs  @ w1 w2 w3 lnX1 lnX2 lnX3 lnX4 if u==0, parameters(a1 a2 a3 b1 b2 b3 g11 g12 g13 g22 g23 g33 ) neq(3)
												
putexcel set second_stage_results, sheet("clam_coefs",replace) modify
putexcel A1=matrix(r(table)), names

estat summarize 
putexcel set second_stage_results, sheet("clam_means",replace) modify
putexcel A1 = matrix(r(stats)),names

matrix V=get(VCE)
matrix list V
putexcel set second_stage_results, sheet("clam_var",replace) modify 
putexcel A1 = matrix(V), names
putexcel close
					
clear
use "C:\Users\CMoore5\OneDrive - Environmental Protection Agency (EPA)\Ocean Acidification\SCOA Damage Functions\stata\united_states\harvest_projections\clam_harvest_projections.dta"
gen lnX1 = ln(quahogQt26) 
gen lnX2 = ln(softclamQt26)
gen lnX3 = ln(geoduckQt26)
gen lnX4 = ln(surfclamQt26)

predict w1_hat26, eq(#1)
predict w2_hat26, eq(#2)
predict w3_hat26, eq(#3)

sum *_hat26

***********************************************************************
* crab
discard
clear 
use "C:\Users\cmoore5\OneDrive - Environmental Protection Agency (EPA)\Ocean Acidification\SCOA Damage Functions\stata\united_states\second_stage\data\crab2s_model_data.dta"

* Call nonlinear SUR and evaluate the function program nlsur5Eqs
egen u = rowmiss(w1 w2 w3 lnX1 lnX2 lnX3 lnX4 )
nlsur X4Eqs @ w1 w2 w3 lnX1 lnX2 lnX3 lnX4 if u==0, ///
				parameters( a1  a2  a3  ///
							b1  b2  b3  ///
							g11 g12 g13 ///
							    g22 g23 ///
							        g33 ) neq(3)

putexcel set second_stage_results, sheet("crab_coefs",replace) modify
putexcel A1=matrix(r(table)), names

estat summarize 
putexcel set second_stage_results, sheet("crab_means",replace) modify
putexcel A1 = matrix(r(stats)),names

matrix V=get(VCE)
matrix list V
putexcel set second_stage_results, sheet("crab_var",replace) modify 
putexcel A1 = matrix(V), names
putexcel close

																		
***********************************************************************												
* lobster
discard
clear 
use "C:\Users\cmoore5\OneDrive - Environmental Protection Agency (EPA)\Ocean Acidification\SCOA Damage Functions\stata\united_states\second_stage\data\lobster2s_model_data.dta"

* Generate index for linear model
gen lnQ = w1*lnX1 + w2*lnX2

* linear regression
reg w1 lnX1 lnX2 lnQ

putexcel set second_stage_results, sheet("lobster_coefs",replace) modify
putexcel A1=matrix(r(table)), names

estat summarize 
putexcel set second_stage_results, sheet("lobster_means",replace) modify
putexcel A1 = matrix(r(stats)),names

matrix V=get(VCE)
matrix list V
putexcel set second_stage_results, sheet("lobster_var",replace) modify 
putexcel A1 = matrix(V), names
putexcel close
						

***********************************************************************
* oyster 												
discard
clear 
use "C:\Users\cmoore5\OneDrive - Environmental Protection Agency (EPA)\Ocean Acidification\SCOA Damage Functions\stata\united_states\second_stage\data\oyster2s_model_data.dta"

* Call nonlinear SUR and evaluate the function program nlsur3Eqs
egen u = rowmiss(w1 w2 lnX1 lnX2 lnX3)
nlsur X3Eqs @ w1 w2 lnX1 lnX2 lnX3 if u==0, ///
				parameters( a1  a2  ///
							b1  b2  ///
							g11 g12 ///
							    g22) neq(2)
putexcel set second_stage_results, sheet("oyster_coefs",replace) modify
putexcel A1=matrix(r(table)), names

estat summarize 
putexcel set second_stage_results, sheet("oyster_means",replace) modify
putexcel A1 = matrix(r(stats)),names

matrix V=get(VCE)
matrix list V
putexcel set second_stage_results, sheet("oyster_var",replace) modify 
putexcel A1 = matrix(V), names
putexcel close

														
***********************************************************************
* scallop
discard
clear 
use "C:\Users\cmoore5\OneDrive - Environmental Protection Agency (EPA)\Ocean Acidification\SCOA Damage Functions\stata\united_states\second_stage\data\scallop2s_model_data.dta"

* Call nonlinear SUR and evaluate the function program nlsur3Eqs
egen u = rowmiss(w1 w2 lnX1 lnX2 lnX3)
nlsur X3Eqs @ w1 w2 lnX1 lnX2 lnX3 if u==0, ///
				parameters( a1  a2  ///
							b1  b2  ///
							g11 g12 ///
							    g22) neq(2)
putexcel set second_stage_results, sheet("scallop_coefs",replace) modify
putexcel A1=matrix(r(table)), names

estat summarize 
putexcel set second_stage_results, sheet("scallop_means",replace) modify
putexcel A1 = matrix(r(stats)),names

matrix V=get(VCE)
matrix list V
putexcel set second_stage_results, sheet("scallop_var",replace) modify 
putexcel A1 = matrix(V), names
putexcel close

clear
use "C:\Users\CMoore5\OneDrive - Environmental Protection Agency (EPA)\Ocean Acidification\SCOA Damage Functions\stata\united_states\harvest_projections\scallop_harvest_projections.dta"
gen lnX1 = ln(bayQt26) 
gen lnX2 = ln(seaQt26)
gen lnX3 = ln(weathervaneQt26)

predict w1_hat26, eq(#1)
predict w2_hat26, eq(#2)

sum *_hat26								
***********************************************************************
* shrimp
discard
clear 
use "C:\Users\cmoore5\OneDrive - Environmental Protection Agency (EPA)\Ocean Acidification\SCOA Damage Functions\stata\united_states\second_stage\data\shrimp2s_model_data.dta"

* Call nonlinear SUR and evaluate the function program nlsur3Eqs
egen u = rowmiss(w1 w2 lnX1 lnX2 lnX3 )
nlsur X3Eqs @ w1 w2 lnX1 lnX2 lnX3 if u==0, ///
				parameters( a1  a2  ///
							b1  b2  ///
							g11 g12 ///
							    g22 ) neq(2)
putexcel set second_stage_results, sheet("shrimp_coefs",replace) modify
putexcel A1=matrix(r(table)), names

estat summarize 
putexcel set second_stage_results, sheet("shrimp_means",replace) modify
putexcel A1 = matrix(r(stats)),names

matrix V=get(VCE)
matrix list V
putexcel set second_stage_results, sheet("shrimp_var",replace) modify 
putexcel A1 = matrix(V), names
putexcel close

