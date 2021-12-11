#!/usr/bin/env bash

#------------------------------------------------------------------------------
# Project Name      - ChannelFiles/Miscellaneous Scripts/taste_the_rainbow.sh
# Started On        - Sat 11 Dec 09:23:53 GMT 2021
# Last Change       - Sat 11 Dec 09:30:23 GMT 2021
# Author E-Mail     - terminalforlife@yahoo.com
# Author GitHub     - https://github.com/terminalforlife
#------------------------------------------------------------------------------
# This is an entirely pointless script, albeit somewhat educational; it slurps
# a file's data, colorizes each character at random, then spits it out into the
# terminal.
#
# Taste the rainbow, I suppose.
#
# NOTE: Some escape sequences like `\n` will be interpreted, so not all files
#       will display properly. I don't know of a way to mitigate this, due to
#       using the `%b` format specification with the `printf` builtin, to
#       interpret the random ANSI color escape sequences.
#
#       It's also very slow, so don't run this on big files.
#------------------------------------------------------------------------------

[[ -f $1 && -r $1 ]] && Data=`< "$1"`

Colors=(
	'\e[91m' '\e[92m' '\e[93m' '\e[94m' '\e[95m' '\e[96m'
	'\e[31m' '\e[32m' '\e[33m' '\e[34m' '\e[35m' '\e[36m'
)

for (( Char = 0; Char <= ${#Data} - 1; Char++ )); {
	NewData+="${Colors[RANDOM % ${#Colors} - 1]}${Data:Char:1}"
}

printf '%b\n' "$NewData"
