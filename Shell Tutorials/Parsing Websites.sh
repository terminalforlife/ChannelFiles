#!/bin/sh

#------------------------------------------------------------------------------
# Project Name      - LearnLinux/Shell\ Tutorials/Parsing\ Websites.sh
# Started On        - Tue 25 Feb 15:34:28 GMT 2020
# Last Change       - Tue 25 Feb 15:59:02 GMT 2020
# Author E-Mail     - terminalforlife@yahoo.com
# Author GitHub     - https://github.com/terminalforlife
#------------------------------------------------------------------------------

URL='https://winehq.org'

wget -qO - "$URL" | while read CurLine; do
	case $CurLine in
		*\>Wine\ [0-9].[0-9]\ Released\<*)
			Buffer=${CurLine#*>Wine }
			printf '%s\n' "${Buffer% Released*}"

			exit 0 ;;
	esac
done

wget -qO - "$URL" | sed -e '/>Wine [0-9]\+\.[0-9]\+ Released</!d'\
	-e 's/.*>Wine \([0-9]\+\.[0-9]\+\) .*/\1/' | head -n 1

wget -qO - "$URL" | awk '
	/>Wine [0-9]+\.[0-9]+/ && $4 ~ /^[0-9]+\.[0-9]+$/ {
		print($4)

		exit 0
	}
'
