#!/usr/bin/env bash

#------------------------------------------------------------------------------
# Project Name      - ChannelFiles/Miscellaneous Scripts/Advent of Code/2021_day-3.sh
# Started On        - Sun  5 Dec 02:50:29 GMT 2021
# Last Change       - Sat 22 Jan 02:58:39 GMT 2022
# Author E-Mail     - terminalforlife@yahoo.com
# Author GitHub     - https://github.com/terminalforlife
#------------------------------------------------------------------------------
# This is for the Advent of Code (2021, Day 3) challenge. I'm so proud of this
# monstrosity that I decided to push it up to my GitHub. I hope you find it
# interesting.
#
# NOTE: This is working with the example data.
#------------------------------------------------------------------------------

Data='00100 11110 10110 10111 10101 01111 00111 11100 10000 11001 00010 01010'

for Number in $Data; {
	for (( Digit = 0; Digit <= 4; Digit++ )); {
		declare Column$Digit+=${Number:Digit:1}
	}
}

for Column in $Column0 $Column1 $Column2 $Column3 $Column4; {
	Ones=0
	Zeros=0
	for (( Digit = 0; Digit <= 4; Digit++ )); {
		case ${Column:Digit:1} in
			0) let Zeros++ ;;
			1) let Ones++ ;;
		esac
	}

	if (( Zeros > Ones )); then
		GammaBin+=1
	else
		GammaBin+=0
	fi

	if (( Zeros < Ones )); then
		EpsilonBin+=1
	else
		EpsilonBin+=0
	fi
}

printf -v GammaDec '%d\n' $(( 2#$GammaBin ))
printf -v EpsilonDec '%d\n' $(( 2#$EpsilonBin ))
printf 'Result: %d\n' $(( GammaDec * EpsilonDec ))
