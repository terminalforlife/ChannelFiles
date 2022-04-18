#!/bin/bash

#------------------------------------------------------------------------------
# Project Name      - ChannelFiles/Miscellaneous Scripts/thumbnail-generator.sh
# Started On        - Thu 14 Jan 20:54:57 GMT 2021
# Last Change       - Fri  8 Apr 23:28:47 BST 2022
# Author E-Mail     - terminalforlife@yahoo.com
# Author GitHub     - https://github.com/terminalforlife
#------------------------------------------------------------------------------
# Crappy thumbnail generator, because the people demand it!
#------------------------------------------------------------------------------

#Font='Ubuntu-Mono-Bold'
#Font='JetBrains-Mono-Bold'
Font='3270-Medium'
FontSize=160
Text=$1
TextColor='#FFFFFF'
Original="$HOME/Pictures/TFL Banner (simple_1080p).jpg"
Output="$HOME/Desktop/thumbnail.jpg"

# Use this if you want multi-line auto-boxing of the text. This needs BASH.
Title() {
	# Similar to above's `for` loop, but interpreting a line delimiter of '|'.
	IFS='|' read -ra Lines <<< "$1"
	for Line in "${Lines[@]}"; {
		Len=${#Line}
		(( Len > MaxLen )) && MaxLen=$Len
	}

	printf -v Bar '%*s' $((MaxLen + 0)) ' '

	printf '%s\n' "⌜${Bar// / }⌝"
	for Line in "${Lines[@]}"; {
		printf ' %*s \n' $MaxLen "$Line"
	}
	printf '%s\n' "⌞${Bar// / }⌟"
}

printf -v Title '%s' "$(Title "$1")"
printf '%s\n' "$(Title "$1")"

#exit

Err(){
	printf 'ERROR: %s\n' "$2" 1>&2
	[ $1 -gt 0 ] && exit $1
}

[ $# -ne 1 ] && Err 1 'Thumbnail annotation string required.'

command -v convert 1> /dev/null 2>&1 || Err 1 "Dependency 'convert' not met."
command -v feh 1> /dev/null 2>&1 || Err 1 "Dependency 'feh' not met."

convert "$Original" -gaussian-blur 18x18 -quality 100 "$Output"

[ $? -eq 0 ] && Err=$((Err + $?))

convert "$Output" -fill "$TextColor" -pointsize "$FontSize" -font "$Font"\
	-weight Medium -gravity Center -annotate +0 "$Title" -quality 100 "$Output"

[ $? -eq 0 ] && Err=$((Err + $?))

[ $Err -eq 0 ] && feh "$Output"
