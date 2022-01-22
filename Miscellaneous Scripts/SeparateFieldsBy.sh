#!/usr/bin/env bash

#----------------------------------------------------------------------------------
# Project Name      - LearnLinux/SeparateFieldsBy.sh
# Started On        - Wed 27 Nov 18:56:46 GMT 2019
# Last Change       - Sat 22 Jan 02:52:41 GMT 2022
# Author E-Mail     - terminalforlife@yahoo.com
# Author GitHub     - https://github.com/terminalforlife
#----------------------------------------------------------------------------------
# Posted to Reddit on 'r/bash' in an effort to help someone with their query.
#----------------------------------------------------------------------------------

FieldOut() { # Usage: FieldOut [SEPARATOR] [FIELD_1] [FIELD_2] ...
	local CurField Sep=$1
	shift

	local FirstField='true'
	for CurField in "$@"; {
		if [[ ${FirstField:-false} == true ]]; then
			# It's the first field, so omit separator.
			unset FirstField
			printf '%s ' "$CurField"
		else
			# No separator at the begnining or end of line.
			printf '%-2s%s ' "$Sep" "$CurField"
		fi
	}

	# Removing trailing whitespace.
	printf '\b'
}

# Fetch kernel version.
ProcFile='/proc/version'
if [[ -f $ProcFile && -r $ProcFile ]]; then
	# Get version string from PROC file.
	read -a VerStr < $ProcFile
	CurKernVer=${VerStr[2]}
elif type -P uname &> /dev/null; then
	# Resort to using an external utility.
	CurKernVer=`uname -r`
fi

# Assign values of the current date and time to an array.
read -a DateTime <<< "$(printf '%(%F %X)T')"

# Newline escaped to keep code from trailing off-screen.
FieldOut '|' "$USER ($UID)" "$HOSTNAME"\
	"${CurKernVer:-N/A}" "${DateTime[0]}"  "${DateTime[1]}"
