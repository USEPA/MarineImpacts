cd "C:\Users\CMoore5\OneDrive - Environmental Protection Agency (EPA)\Ocean Acidification\SCOA Damage Functions\stata\canada"
discard
clear 
set more off
use canada_mollusk_model_data

* Call nonlinear SUR and evaluate the function program nlsur3Eqs
egen u = rowmiss(w1 w2 lnX1 lnX2 lnX3)
nlsur X3Eqs @ w1 w2 lnX1 lnX2 lnX3 if u==0, parameters( a1 a2 b1 b2	g11 g12 g22) neq(2)

putexcel set mollusk_results, sheet("coefs",replace) modify
putexcel A1=matrix(r(table)), names

estat summarize 
putexcel set mollusk_results, sheet("means",replace) modify
putexcel A1 = matrix(r(stats)),names

matrix V=get(VCE)
matrix list V
putexcel set mollusk_results, sheet("var",replace) modify 
putexcel A1 = matrix(V), names
putexcel close


discard
clear 
set more off
use canada_crustacean_model_data

* Call nonlinear SUR and evaluate the function program nlsur4Eqs
egen u = rowmiss(w1 w2 w3 lnX1 lnX2 lnX3 lnX4)
nlsur X4Eqs  @ w1 w2 w3 lnX1 lnX2 lnX3 lnX4 if u==0, parameters(a1 a2 a3 b1 b2 b3 g11 g12 g13 g22 g23 g33 ) neq(3)

putexcel set crustacean_results, sheet("coefs",replace) modify
putexcel A1=matrix(r(table)), names

estat summarize 
putexcel set crustacean_results, sheet("means",replace) modify
putexcel A1 = matrix(r(stats)),names

matrix V=get(VCE)
matrix list V
putexcel set crustacean_results, sheet("var",replace) modify 
putexcel A1 = matrix(V), names
putexcel close
