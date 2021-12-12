#!/usr/bin/env bash

#------------------------------------------------------------------------------
# Project Name      - ChannelFiles/Miscellaneous Scripts/BNOTIONS_bash_challenge.sh
# Started On        - Sun 12 Dec 04:28:56 GMT 2021
# Last Change       - Sun 12 Dec 22:48:37 GMT 2021
# Author E-Mail     - terminalforlife@yahoo.com
# Author GitHub     - https://github.com/terminalforlife
#------------------------------------------------------------------------------
# A pure-BASH solution to the @BNOTIONS BASH challenge found in the below link.
#
#   https://github.com/BNOTIONS/bash-challenge
#
# This challenge was made for Mac users, but I'll be writing a Linux solution.
# To see this script in action, run it with the 'users.csv' file, which can be
# found through the above link.
#
# NOTE: This script will not work if any of the fields contain the file's
#       delimiter character of a comma. The header will not be included. This
#       can perhaps be handled by checking for a quotation mark, then, if it's
#       found, ignore any proceeding commas unless there's another quotation
#       mark.
#------------------------------------------------------------------------------

if [ -f "$1" ] && [ -r "$1" ]; then
	First='True'
	while IFS=',' read -a Line; do
		if [ "$First" == 'True' ]; then
			First='False'
			continue
		fi

		printf '%s %s <%s>\n' "${Line[3]//\"/}"\
			"${Line[4]//\"/}" "${Line[2]//\"/}"
	done < "$1"
else
	printf 'Err: File missing or unreadable.\n' 1>&2
	exit 1
fi
