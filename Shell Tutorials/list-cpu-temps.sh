#!/usr/bin/env bash

#------------------------------------------------------------------------------
# Project Name      - LearnLinux/Shell Tutorials/list-cpu-temps.sh
# Started On        - Thu 17 Dec 17:36:35 GMT 2020
# Last Change       - Sat 22 Jan 03:00:31 GMT 2022
# Author E-Mail     - terminalforlife@yahoo.com
# Author GitHub     - https://github.com/terminalforlife
#------------------------------------------------------------------------------

printf '\e[1;32m%-14s %-s\e[0m\n' 'NAME' 'RESULT'

MonDir='/sys/class/hwmon/hwmon2'
for File in "$MonDir"/*; {
	[[ -f $File ]] || continue

	if [[ ${File##*/} == *_label ]]; then
		Label=`< "$File"`
	elif [[ ${File##*/} == *_input ]]; then
		Input=`< "$File"`
	elif [[ -n $Label && -n $Input ]]; then
		printf '%-14s %-s\n' "$Label" "$Input"

		Label=
		Input=
	fi
}
