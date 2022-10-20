capture drop program nlsurX4Eqs
program nlsurX4Eqs

	version 11
	
	syntax varlist(min=7 max=7) if, at(name)	
	tokenize `varlist'
	args w1 w2 w3 lnX1 lnX2 lnX3 lnX4 

	tempname a1 a2 a3 a4
	scalar `a1' = `at'[1,1]
	scalar `a2' = `at'[1,2]
	scalar `a3' = `at'[1,3]
	scalar `a4' = 1 - (`a1' + `a2' + `a3')
	
	tempname b1 b2 b3 b4
	scalar `b1' = `at'[1,4]
	scalar `b2' = `at'[1,5]
	scalar `b3' = `at'[1,6]
	scalar `b4' = -`b1' - `b2' - `b3'
	
	tempname g11 g12 g13 g14
	tempname g21 g22 g23 g24
	tempname g31 g32 g33 g34
	tempname g41 g42 g43 g44
		
	scalar `g11' = `at'[1,7]
	scalar `g12' = `at'[1,8]
	scalar `g13' = `at'[1,9]
	scalar `g14' = -`g11'-`g12'-`g13'
	
	scalar `g21' = `g12'
	scalar `g22' = `at'[1,10]
	scalar `g23' = `at'[1,11]
	scalar `g24' = -`g21'-`g22'-`g23'
	
	scalar `g31' = `g13'
	scalar `g32' = `g23'
	scalar `g33' = `at'[1,12]
	scalar `g34' = -`g31'-`g32'-`g33'

	scalar `g41' = `g14'
	scalar `g42' = `g24'
	scalar `g43' = `g34'
	scalar `g44' = -`g41'-`g42'-`g43'
	
	quietly {
	tempvar lnqindex
	gen double `lnqindex' = `a1'*`lnX1' + `a2'*`lnX2' + `a3'*`lnX3' + `a4'*`lnX4'
	forvalues i = 1/4 {
	forvalues j = 1/4 {
	replace `lnqindex' = `lnqindex' +  0.5*`g`i'`j''*`lnX`i''*`lnX`j''
	}
	}
	replace `w1' = `a1' + `g11'*`lnX1' + `g12'*`lnX2' + `g13'*`lnX3' + `g14'*`lnX4' - `b1'*`lnqindex' 
	replace `w2' = `a2' + `g21'*`lnX1' + `g22'*`lnX2' + `g23'*`lnX3' + `g24'*`lnX4' - `b2'*`lnqindex' 
	replace `w3' = `a3' + `g31'*`lnX1' + `g32'*`lnX2' + `g33'*`lnX3' + `g34'*`lnX4' - `b3'*`lnqindex' 
}
end
