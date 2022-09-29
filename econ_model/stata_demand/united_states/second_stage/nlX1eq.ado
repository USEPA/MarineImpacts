capture drop program nlX1eq
program nlX1eq

	version 11
	
	syntax varlist if, at(name)
	tokenize `varlist'
	args w1 lnX1 lnX2  

	tempname a1 a2
	scalar `a1' = `at'[1,1]
	scalar `a2' = 1-`a1'
	
	tempname b1 b2
	scalar `b1' = `at'[1,2]
			
	tempname g11 g12 
			
	scalar `g11' = `at'[1,3]
	scalar `g12' = -`g11'
	
		
quietly {
	tempvar lnqindex
	gen double `lnqindex' = `a1'*`lnX1' + `a2'*`lnX2' +  0.5*`g11'*`lnX1'*`ln1' +  0.5*`g12'*`lnX1'*`ln2'
	replace `w1' = `a1' + `g11'*`lnX1' + `g12'*`lnX2' - `b1'*`lnqindex' 
}
end

