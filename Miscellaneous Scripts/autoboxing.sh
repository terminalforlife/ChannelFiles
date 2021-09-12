#!/usr/bin/env bash

#------------------------------------------------------------------------------
# Project Name      -
# Started On        - Sun 12 Sep 20:24:27 BST 2021
# Last Change       - Sun 12 Sep 20:27:22 BST 2021
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
