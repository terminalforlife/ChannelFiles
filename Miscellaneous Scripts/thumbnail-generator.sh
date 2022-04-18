#!/bin/bash

#------------------------------------------------------------------------------
# Project Name      - ChannelFiles/Miscellaneous Scripts/thumbnail-generator.sh
# Started On        - Thu 14 Jan 20:54:57 GMT 2021
# Last Change       - Mon 18 Apr 19:19:23 BST 2022
# Author E-Mail     - terminalforlife@yahoo.com
# Author GitHub     - https://github.com/terminalforlife
#------------------------------------------------------------------------------
# Crappy thumbnail generator, because the people demand it!
#
# Pipes separate lines, not `\n`!
#------------------------------------------------------------------------------

Font='3270-Medium'
FontSize=160
Text=$1
TextColor='#FFFFFF'
Original="$HOME/Pictures/TFL Banner (simple_1080p).jpg"
Output="$HOME/Desktop/thumbnail.jpg"

Err(){
	printf 'ERROR: %s\n' "$2" 1>&2
	[ $1 -gt 0 ] && exit $1
}

Title() {
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

(( $# == 1 )) || Err 1 'Thumbnail annotation string required.'

type -P convert &> /dev/null || Err 1 "Dependency 'convert' not met."
type -P feh &> /dev/null || Err 1 "Dependency 'feh' not met."

if convert "$Original" -gaussian-blur 18x18 -quality 100 "$Output"; then
	convert "$Output" -fill "$TextColor" -pointsize "$FontSize" -font "$Font"\
		-weight Medium -gravity Center -annotate +0 "$Title" -quality 100 "$Output"

	if (( $? == 0 )); then
		feh "$Output" || Err 1 'Failed to show thumbnail with feh(1).'
	else
		Err 1 'Second convert(1) pass failed.'
	fi
else
	Err 1 'First convert(1) pass failed.'
fi
