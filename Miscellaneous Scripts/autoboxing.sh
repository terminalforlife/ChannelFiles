#!/usr/bin/env bash

#------------------------------------------------------------------------------
# Project Name      -
# Started On        - Sun 12 Sep 20:24:27 BST 2021
# Last Change       - Sun 12 Sep 20:42:40 BST 2021
# Author E-Mail     - terminalforlife@yahoo.com
# Author GitHub     - https://github.com/terminalforlife
#------------------------------------------------------------------------------
# I wrote this for my video:
#
#   https://www.youtube.com/watch?v=1Uv8KfUjRBU
#
# This basically allows you to automatically surrounding your text in pretty
# boxes, which looks especially nice with Unicode. You can change the Unicode
# characters to something else, if you'd prefer. You might like gucharmap(1).
#
# The Unicode will need a viable font. I think I use the 'fonts-opensymbol'
# package in Ubuntu-based distributions, or maybe 'fonts-symbola'.
#------------------------------------------------------------------------------

Title() {
	printf -v Bar '%*s' $((${#1} + 2)) ' '
	printf '%s\n║ %s ║\n%s\n' "╔${Bar// /═}╗" "$1" "╚${Bar// /═}╝"
}

Title 'Using Unicode for pretty boxes.'

Title() {
	printf -v Bar '%*s' $((${#1} + 2)) ' '
	printf '%s\n| %s |\n%s\n' "+${Bar// /-}+" "$1" "+${Bar// /-}+"
}

Title 'Using ASCII for so-so boxes.'

Title() {
	# Pre-process to get the maximum length. It's not as efficient, but we're
	# still talking peanuts here, so it should be more than fine!
	MaxLen=0
	for Line in "$@"; {
		Len=${#Line}
		(( Len > MaxLen )) && MaxLen=$Len
	}

	printf -v Bar '%*s' $((MaxLen + 2)) ' '

	printf '%s\n' "/${Bar// /-}\\"
	for Line in "$@"; {
		printf '| %-*s |\n' $MaxLen "$Line"
	}
	printf '%s\n' "\\${Bar// /-}/"
}

# One argument per line; it's not as convenient as `\n`, but it suffices.
Title 'Handling multiple lines is' 'doable too, with alignment.'
