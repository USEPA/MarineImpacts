capture drop program nlsurX3Eqs
program nlsurX3Eqs

	version 11
	
	syntax varlist if, at(name)
	tokenize `varlist'
	args w1 w2 lnX1 lnX2 lnX3 

	tempname a1 a2 a3 
	scalar `a1' = `at'[1,1]
	scalar `a2' = `at'[1,2]
	scalar `a3' = 1-(`a1'+`a2')
	
	tempname b1 b2 b3 
	scalar `b1' = `at'[1,3]
	scalar `b2' = `at'[1,4]
	scalar `b3' = -`b1'-`b2'
		
	tempname g11 g12 g13 
	tempname g21 g22 g23 
	tempname g31 g32 g33 
		
	scalar `g11' = `at'[1,5]
	scalar `g12' = `at'[1,6]
	scalar `g13' = -`g11'-`g12'
	
	scalar `g21' = `g12'
	scalar `g22' = `at'[1,7]
	scalar `g23' = -`g21'-`g22'
	
	scalar `g31' = `g13'
	scalar `g32' = `g23'
	scalar `g33' = -`g31'-`g32'
	
quietly {
	tempvar lnqindex
	gen double `lnqindex' = `a1'*`lnX1' + `a2'*`lnX2' + `a3'*`lnX3'
	forvalues i = 1/3 {
	forvalues j = 1/3 {
	replace `lnqindex' = `lnqindex' +  0.5*`g`i'`j''*`lnX`i''*`lnX`j''
	}
	}
	replace `w1' = `a1' + `g11'*`lnX1' + `g12'*`lnX2' + `g13'*`lnX3' - `b1'*`lnqindex' 
				   
	replace `w2' = `a2' + `g21'*`lnX1' + `g22'*`lnX2' + `g23'*`lnX3' - `b2'*`lnqindex' 	
}
end

