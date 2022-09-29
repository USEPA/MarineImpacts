capture drop program nlsurX2Eqs
program nlsurX2Eqs

	version 11
	
	syntax varlist if, at(name)
	tokenize `varlist'
	args w1 lnX1 lnX2  

	tempname a1 a2
	scalar `a1' = `at'[1,1]
	scalar `a2' = 1-`a1'
	
	tempname b1 b2
	scalar `b1' = `at'[1,2]
	scalar `b2' = -`b1'
		
	tempname g11 g12 
	tempname g21 g22 
		
	scalar `g11' = `at'[1,3]
	scalar `g12' = -`g11'
	
	scalar `g21' = `g12'
	scalar `g22' = -`g21'
	
quietly {
	tempvar lnqindex
	gen double `lnqindex' = `a1'*`lnX1' + `a2'*`lnX2' 
	forvalues i = 1/2 {
	forvalues j = 1/2 {
	replace `lnqindex' = `lnqindex' +  0.5*`g`i'`j''*`lnX`i''*`lnX`j''
	}
	}
	replace `w1' = `a1' + `g11'*`lnX1' + `g12'*`lnX2' - `b1'*`lnqindex' 
}
end

