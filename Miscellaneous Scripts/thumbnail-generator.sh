#!/bin/sh

#------------------------------------------------------------------------------
# Project Name      - ChannelFiles/Miscellaneous Scripts/thumbnail-generator.sh
# Started On        - Thu 14 Jan 20:54:57 GMT 2021
# Last Change       - Mon 13 Sep 11:34:06 BST 2021
# Author E-Mail     - terminalforlife@yahoo.com
# Author GitHub     - https://github.com/terminalforlife
#------------------------------------------------------------------------------
# Crappy thumbnail generator, because the people demand it!
#------------------------------------------------------------------------------

Font='Ubuntu-Mono-Bold'
FontSize=180
Text=$1
TextColor='#FFFFFF'
StrokeColor='#000000'
StrokeWidth=4
Original="$HOME/Pictures/Surface Texture with Logo 2.jpg"
Output="$HOME/Desktop/output.jpg"

# Use this if you want multi-line auto-boxing of the text. This needs BASH.
#Title() {
#	MaxLen=0
#	IFS='|' read -a Lines <<< "$1"
#	for Line in "${Lines[@]}"; {
#		Len=${#Line}
#		(( Len > MaxLen )) && MaxLen=$Len
#	}
#
#	printf -v Bar '%*s' $((MaxLen + 2)) ' '
#
#	printf '%s\n' "┌${Bar// /─}┐"
#	for Line in "${Lines[@]}"; {
#		printf '│ %-*s │\n' $MaxLen "$Line"
#	}
#	printf '%s\n' "└${Bar// /─}┘"
#}
#
#printf -v Text '%b' "$(Title "$1")"

Err(){
	printf 'ERROR: %s\n' "$2" 1>&2
	[ $1 -gt 0 ] && exit $1
}

[ $# -ne 1 ] && Err 1 'Thumbnail annotation string required.'

command -v convert 1> /dev/null 2>&1 || Err 1 "Dependency 'convert' not met."
command -v feh 1> /dev/null 2>&1 || Err 1 "Dependency 'feh' not met."

convert "$Original" -background '#000000' -vignette 0x120+-60-60\
	-quality 100 "$Output"

[ $? -eq 0 ] && Err=$((Err + $?))

convert "$Output" -fill "$TextColor" -stroke "$StrokeColor"\
	-strokewidth $StrokeWidth -pointsize "$FontSize" -font "$Font"\
	-gravity Center -annotate +0 "$Text" -quality 100 "$Output"

[ $? -eq 0 ] && Err=$((Err + $?))

[ $Err -eq 0 ] && feh "$Output"
