capture drop program nlsurX5Eqs
program nlsurX5Eqs

	version 11
	
	syntax varlist(min=9 max=9) if, at(name)
	tokenize `varlist'
	args w1 w2 w3 w4 lnX1 lnX2 lnX3 lnX4 lnX5 

	tempname a1 a2 a3 a4 a5
	scalar `a1' = `at'[1,1]
	scalar `a2' = `at'[1,2]
	scalar `a3' = `at'[1,3]
	scalar `a4' = `at'[1,4]
	scalar `a5' = 1-`a1' + `a2' + `a3' + `a4'
	
	tempname b1 b2 b3 b4 b5
	scalar `b1' = `at'[1,5]
	scalar `b2' = `at'[1,6]
	scalar `b3' = `at'[1,7]
	scalar `b4' = `at'[1,8]
	scalar `b5' = -`b1' - `b2' - `b3' - `b4'
	
	tempname g11 g12 g13 g14 g15
	tempname g21 g22 g23 g24 g25
	tempname g31 g32 g33 g34 g35
	tempname g41 g42 g43 g44 g45
	tempname g51 g52 g53 g54 g55 
		
	scalar `g11' = `at'[1,9]
	scalar `g12' = `at'[1,10]
	scalar `g13' = `at'[1,11]
	scalar `g14' = `at'[1,12]
	scalar `g15' = -`g11'-`g12'-`g13'-`g14'
	
	scalar `g21' = `g12'
	scalar `g22' = `at'[1,13]
	scalar `g23' = `at'[1,14]
	scalar `g24' = `at'[1,15]
	scalar `g25' = -`g21'-`g22'-`g23'-`g24'
	
	scalar `g31' = `g13'
	scalar `g32' = `g23'
	scalar `g33' = `at'[1,16]
	scalar `g34' = `at'[1,17]
	scalar `g35' = -`g31'-`g32'-`g33'-`g34'

	scalar `g41' = `g14'
	scalar `g42' = `g24'
	scalar `g43' = `g34'
	scalar `g44' = `at'[1,18]
	scalar `g45' = -`g41'-`g42'-`g43'-`g44'
	
	scalar `g51' = `g15'
	scalar `g52' = `g25'
	scalar `g53' = `g35'
	scalar `g54' = `g45'
	scalar `g55' = -`g51'-`g52'-`g53'-`g54'

	
	quietly {
	tempvar lnqindex
	gen double `lnqindex' = `a1'*`lnX1' + `a2'*`lnX2' + `a3'*`lnX3' + `a4'*`lnX4'+ `a5'*`lnX5'
	forvalues i = 1/5 {
	forvalues j = 1/5 {
	replace `lnqindex' = `lnqindex' +  0.5*`g`i'`j''*`lnX`i''*`lnX`j''
	}
	}
	replace `w1' = `a1' + `g11'*`lnX1' + `g12'*`lnX2' + `g13'*`lnX3' + `g14'*`lnX4' + `g15'*`lnX5' - `b1'*`lnqindex'  
	replace `w2' = `a2' + `g21'*`lnX1' + `g22'*`lnX2' + `g23'*`lnX3' + `g24'*`lnX4' + `g25'*`lnX5' - `b2'*`lnqindex' 
	replace `w3' = `a3' + `g31'*`lnX1' + `g32'*`lnX2' + `g33'*`lnX3' + `g34'*`lnX4' + `g35'*`lnX5' - `b3'*`lnqindex' 
	replace `w4' = `a4' + `g41'*`lnX1' + `g42'*`lnX2' + `g43'*`lnX3' + `g44'*`lnX4' + `g45'*`lnX5' - `b4'*`lnqindex' 
}
end

