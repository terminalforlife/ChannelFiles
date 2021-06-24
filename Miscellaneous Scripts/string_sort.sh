#!/usr/bin/env bash

#------------------------------------------------------------------------------
# Project Name      - ChannelFiles/Miscellaneous Scripts/string_sort.sh
# Started On        - Thu 24 Jun 05:18:52 BST 2021
# Last Change       - Thu 24 Jun 06:37:07 BST 2021
# Author E-Mail     - terminalforlife@yahoo.com
# Author GitHub     - https://github.com/terminalforlife
#------------------------------------------------------------------------------
# Manual approach to sorting a single string in BASH. For now, this should be
# considered experimental, and as more of a concept.
#
# NOTE: This only works with just lowercase alphabetical characters, but if you
#       want, you can tweak it for only uppercase, numbers, and perhaps
#       experiment with variations thereof.
#
#       Another caveat is that duplicate letters will be ignored, sadly.
#
# Usage: string_sort STRING
#------------------------------------------------------------------------------

Len=${#1}
for Alpha in {a..z}; {
	for (( Char = 0; Char <= Len; Char++ )); {
		if [ "${1:Char:1}" == "$Alpha" ]; then
			printf '%s' "${1:Char:1}"

			break
		fi
	}
}

printf '\n'
