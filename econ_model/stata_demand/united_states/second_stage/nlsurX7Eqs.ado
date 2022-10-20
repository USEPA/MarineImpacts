capture drop program nlsurX7Eqs
program nlsurX7Eqs

	version 11
	
	syntax varlist if, at(name)
	tokenize `varlist'
	args w1 w2 w3 w4 w5 w6 lnX1 lnX2 lnX3 lnX4 lnX5 lnX6 lnX7 

	tempname a1 a2 a3 a4 a5 a6 a7
	scalar `a1' = `at'[1,1]
	scalar `a2' = `at'[1,2]
	scalar `a3' = `at'[1,3]
	scalar `a4' = `at'[1,4]
	scalar `a5' = `at'[1,5]
	scalar `a6' = `at'[1,6]
	scalar `a7' = -1*(`a1' + `a2' + `a3' + `a4' +`a5' + `a6')
	
	tempname b1 b2 b3 b4 b5 b6 b7
	scalar `b1' = `at'[1,7]
	scalar `b2' = `at'[1,8]
	scalar `b3' = `at'[1,9]
	scalar `b4' = `at'[1,10]
	scalar `b5' = `at'[1,11]
	scalar `b6' = `at'[1,12]
	scalar `b7' = -`b1' - `b2' - `b3' - `b4' - `b5' - `b6'
	
	tempname g11 g12 g13 g14 g15 g16 g17
	tempname g21 g22 g23 g24 g25 g26 g27
	tempname g31 g32 g33 g34 g35 g36 g37
	tempname g41 g42 g43 g44 g45 g46 g47
	tempname g51 g52 g53 g54 g55 g56 g57
	tempname g61 g62 g63 g64 g65 g66 g67
	tempname g71 g72 g73 g74 g75 g76 g77
		
	scalar `g11' = `at'[1,13]
	scalar `g12' = `at'[1,14]
	scalar `g13' = `at'[1,15]
	scalar `g14' = `at'[1,16]
	scalar `g15' = `at'[1,17]
	scalar `g16' = `at'[1,18]
	scalar `g17' = -`g11'-`g12'-`g13'-`g14'-`g15'-`g16'
	
	scalar `g21' = `g12'
	scalar `g22' = `at'[1,19]
	scalar `g23' = `at'[1,20]
	scalar `g24' = `at'[1,21]
	scalar `g25' = `at'[1,22]
	scalar `g26' = `at'[1,23]
	scalar `g27' = -`g21'-`g22'-`g23'-`g24'-`g25'-`g26'
	
	scalar `g31' = `g13'
	scalar `g32' = `g23'
	scalar `g33' = `at'[1,24]
	scalar `g34' = `at'[1,25]
	scalar `g35' = `at'[1,26]
	scalar `g36' = `at'[1,27]
	scalar `g37' = -`g31'-`g32'-`g33'-`g34'-`g35'-`g36'

	scalar `g41' = `g14'
	scalar `g42' = `g24'
	scalar `g43' = `g34'
	scalar `g44' = `at'[1,28]
	scalar `g45' = `at'[1,29]
	scalar `g46' = `at'[1,30]
	scalar `g47' = -`g41'-`g42'-`g43'-`g44'-`g45'-`g46'
	
	scalar `g51' = `g15'
	scalar `g52' = `g25'
	scalar `g53' = `g35'
	scalar `g54' = `g45'
	scalar `g55' = `at'[1,31]
	scalar `g56' = `at'[1,32]
	scalar `g57' = -`g51'-`g52'-`g53'-`g54'-`g55'-`g56'

	scalar `g61' = `g16'
	scalar `g62' = `g26'
	scalar `g63' = `g36'
	scalar `g64' = `g46'
	scalar `g65' = `g56'
	scalar `g66' = `at'[1,33]
	scalar `g67' = -`g61'-`g62'-`g63'-`g64'-`g65'-`g66'
	
	scalar `g71' = `g16'
	scalar `g72' = `g26'
	scalar `g73' = `g36'
	scalar `g74' = `g46'
	scalar `g75' = `g56'
	scalar `g76' = `g67'
	scalar `g77' = -`g61'-`g62'-`g63'-`g64'-`g65'-`g66'
	
	
	quietly {
	tempvar lnqindex
	gen double `lnqindex' = `a1'*`lnX1' + `a2'*`lnX2' + `a3'*`lnX3' + `a4'*`lnX4'+ `a5'*`lnX5'+`a6'*`lnX6'+`a7'*`lnX7'
	forvalues i = 1/7 {
	forvalues j = 1/7 {
	replace `lnqindex' = `lnqindex' +  0.5*`g`i'`j''*`lnX`i''*`lnX`j''
	}
	}
	replace `w1' = `a1' + `g11'*`lnX1' + `g12'*`lnX2' + `g13'*`lnX3' + `g14'*`lnX4' + `g15'*`lnX5' + `g16'*`lnX6' + `g17'*`lnX7'- `b1'*`lnqindex' 
	replace `w2' = `a2' + `g21'*`lnX1' + `g22'*`lnX2' + `g23'*`lnX3' + `g24'*`lnX4' + `g25'*`lnX5' + `g26'*`lnX6' + `g27'*`lnX7'- `b2'*`lnqindex' 
	replace `w3' = `a3' + `g31'*`lnX1' + `g32'*`lnX2' + `g33'*`lnX3' + `g34'*`lnX4' + `g35'*`lnX5' + `g36'*`lnX6' + `g37'*`lnX7'- `b3'*`lnqindex' 
	replace `w4' = `a4' + `g41'*`lnX1' + `g42'*`lnX2' + `g43'*`lnX3' + `g44'*`lnX4' + `g45'*`lnX5' + `g46'*`lnX6' + `g47'*`lnX7'- `b4'*`lnqindex' 
	replace `w5' = `a5' + `g51'*`lnX1' + `g52'*`lnX2' + `g53'*`lnX3' + `g54'*`lnX4' + `g55'*`lnX5' + `g56'*`lnX6' + `g57'*`lnX7'- `b5'*`lnqindex' 
	replace `w6' = `a6' + `g61'*`lnX1' + `g62'*`lnX2' + `g63'*`lnX3' + `g64'*`lnX4' + `g65'*`lnX5' + `g66'*`lnX6' + `g67'*`lnX7'- `b6'*`lnqindex' 
}
end

