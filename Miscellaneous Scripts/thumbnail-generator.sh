#!/bin/sh

#------------------------------------------------------------------------------
# Project Name      - LearnLinux/Miscellaneous Scripts/thumbnail-generator.sh
# Started On        - Thu 14 Jan 20:54:57 GMT 2021
# Last Change       - Sat 16 Jan 03:23:37 GMT 2021
# Author E-Mail     - terminalforlife@yahoo.com
# Author GitHub     - https://github.com/terminalforlife
#------------------------------------------------------------------------------
# Crappy thumbnail generator, because the people demand it!
#------------------------------------------------------------------------------

Font='Noto-Sans-Display-Bold'
FontSize=200
Text=$1
TextColor='#FFFFFF'
Resize='50%'
Original="$HOME/Pictures/thumbnail.jpg"
Output="$HOME/Desktop/output.jpg"

Err(){
	printf 'ERROR: %s\n' "$2" 1>&2
	[ $1 -gt 0 ] && exit $1
}

#[ $# -ne 1 ] && Err 1 'Thumbnail annotation string required.'

command -v convert 1> /dev/null 2>&1 || Err 1 "Dependency 'convert' not met."
command -v feh 1> /dev/null 2>&1 || Err 1 "Dependency 'feh' not met."

# I know these can be combined, but I'm finding it easier to split them up.
convert "$Original" -auto-level -background '#000000' -vignette 0x120+-60-60\
	-quality 100 "$Output"

[ $? -eq 0 ] && Err=$((Err + $?))

convert "$Output" -fill "$TextColor" -strokewidth 4 -stroke Black\
	-pointsize "$FontSize" -font "$Font" -gravity Center -annotate +0 "$Text"\
	-quality 100 "$Output"

[ $? -eq 0 ] && Err=$((Err + $?))

convert "$Output" -resize "$Resize" "$Output"

[ $? -eq 0 ] && Err=$((Err + $?))

# If '0', then no errors occurred, so display image.
[ $Err -eq 0 ] && feh "$Output"
