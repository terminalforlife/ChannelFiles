#!/bin/sh

#------------------------------------------------------------------------------
# Project Name      - LearnLinux/Miscellaneous Scripts/thumbnail-generator.sh
# Started On        - Thu 14 Jan 20:54:57 GMT 2021
# Last Change       - Mon 12 Jul 11:23:50 BST 2021
# Author E-Mail     - terminalforlife@yahoo.com
# Author GitHub     - https://github.com/terminalforlife
#------------------------------------------------------------------------------
# Crappy thumbnail generator, because the people demand it!
#------------------------------------------------------------------------------

#Font='Noto-Sans-Display-Bold'
#Font='Mononoki-Bold'
#Font='AppleStorm-Extra-Bold'
Font='Ubuntu-Mono-Bold'
FontSize=180 # Default: 200
Text=$1
TextColor='#FFFFFF'
StrokeColor='#000000'
StrokeWidth=4
#Original="$HOME/Pictures/TFL Banner (simple_1080p).jpg"
Original="$HOME/Pictures/Surface Texture with Logo 2.jpg"
Output="$HOME/Desktop/output.jpg"

Err(){
	printf 'ERROR: %s\n' "$2" 1>&2
	[ $1 -gt 0 ] && exit $1
}

[ $# -ne 1 ] && Err 1 'Thumbnail annotation string required.'

command -v convert 1> /dev/null 2>&1 || Err 1 "Dependency 'convert' not met."
command -v feh 1> /dev/null 2>&1 || Err 1 "Dependency 'feh' not met."

# I know these can be combined, but I'm finding it easier to split them up.
convert "$Original" -background '#000000' -vignette 0x120+-60-60\
	-quality 100 "$Output"

[ $? -eq 0 ] && Err=$((Err + $?))

convert "$Output" -fill "$TextColor" -stroke "$StrokeColor" -strokewidth $StrokeWidth\
	-pointsize "$FontSize" -font "$Font" -gravity Center -annotate +0 "$Text"\
	-quality 100 "$Output"

[ $? -eq 0 ] && Err=$((Err + $?))

# If '0', then no errors occurred, so display image.
[ $Err -eq 0 ] && feh "$Output"
