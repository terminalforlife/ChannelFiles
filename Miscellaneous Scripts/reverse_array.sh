#!/usr/bin/env bash

#------------------------------------------------------------------------------
# Project Name      - ChannelFiles/Miscellaneous Scripts/reverse_array.sh
# Started On        - Tue  7 Dec 02:33:55 GMT 2021
# Last Change       - Tue  7 Dec 02:46:20 GMT 2021
# Author E-Mail     - terminalforlife@yahoo.com
# Author GitHub     - https://github.com/terminalforlife
#------------------------------------------------------------------------------
# Three ways in which you can reverse an array in pure-BASH.
#------------------------------------------------------------------------------

printf 'Reversing array of the following values:\n'
printf '100 90 80 70 60 50 40 30 20 10\n\n'

printf '\e[92m:)\e[0m Approach 3, using C-style `for` loop:\n'
Array=(100 90 80 70 60 50 40 30 20 10)

for (( Nr = ${#Array[@]} - 1; Nr >= 0; Nr-- )); {
	printf '%d ' ${Array[Nr]}
}

printf '\n\n'

printf '\e[93m:|\e[0m Approach 1, using `while` loop:\n'
Array=(100 90 80 70 60 50 40 30 20 10)

Nr=$((${#Array[@]} - 1))
while (( Nr >= 0 )); do
	printf '%d ' ${Array[Nr]}

	let Nr--
done

printf '\n\n'

printf '\e[91m:(\e[0m Approach 2, using `extdebug` & `$BASH_ARGV`:\n'
Array=(100 90 80 70 60 50 40 30 20 10)

Func() {
	Array=("${BASH_ARGV[@]}")
}

shopt -s extdebug
Func "${Array[@]}"
shopt -u extdebug

printf '%d ' "${Array[@]}"

printf '\n'
