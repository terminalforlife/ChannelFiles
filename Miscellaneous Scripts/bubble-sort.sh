#!/usr/bin/env bash

#------------------------------------------------------------------------------
# Project Name      - ChannelFiles/Miscellaneous Scripts/bubble-sort.sh
# Started On        - Tue  4 Jan 16:57:26 GMT 2022
# Last Change       - Tue  4 Jan 17:04:17 GMT 2022
# Author E-Mail     - terminalforlife@yahoo.com
# Author GitHub     - https://github.com/terminalforlife
#------------------------------------------------------------------------------
# Talked about this over here:
#
#   https://www.youtube.com/watch?v=o3SZ1mWuidU
#
# This is basically a demonstration of the 'Bubble Sort' algorithm, both for
# numeric sorting and alphabetic sorting. In the video, I only showed the top
# approach, and `Data` was `Numbers`.
#------------------------------------------------------------------------------

Data=(9 2 5 3 1 8 7 6 0 4)
Len=${#Data[*]}

for (( Iter = 0; Iter < Len; Iter++ )); {
	for (( Index = 0; Index < Len - 1 - Iter; Index++ )); {
		if (( ${Data[Index]} > ${Data[Index + 1]} )); then
			Temporary=${Data[Index]}
			Data[Index]=${Data[Index + 1]}
			Data[Index + 1]=$Temporary
		fi
	}
}

printf '%d ' "${Data[@]}"
printf '\n'

# Below is the same as above, but for alphanumeric sorting.

Data=(6 j f 8 l s 1 d 4 z)
Len=${#Data[*]}

for (( Iter = 0; Iter < Len; Iter++ )); {
	for (( Index = 0; Index < Len - 1 - Iter; Index++ )); {
		if [[ ${Data[Index]} > ${Data[Index + 1]} ]]; then
			Temporary=${Data[Index]}
			Data[Index]=${Data[Index + 1]}
			Data[Index + 1]=$Temporary
		fi
	}
}

printf '%s ' "${Data[@]}"
printf '\n'

# Below is an example of numeric sorting, but in a function, for re-use.

NumericSort() {
	local Len=$# Data=("$@") Iter Index Temporary
	for (( Iter = 0; Iter < Len; Iter++ )); {
		for (( Index = 0; Index < Len - 1 - Iter; Index++ )); {
			if (( ${Data[Index]} > ${Data[Index + 1]} )); then
				Temporary=${Data[Index]}
				Data[Index]=${Data[Index + 1]}
				Data[Index + 1]=$Temporary
			fi
		}
	}

	printf '%d ' ${Data[*]}
}

NumericSort 9 2 5 3 1 8 7 6 0 4
printf '\n'
