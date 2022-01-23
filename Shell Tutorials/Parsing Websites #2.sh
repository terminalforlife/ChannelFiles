#!/bin/sh

#------------------------------------------------------------------------------
# Project Name      - LearnLinux/Shell\ Tutorials/Parsing\ Websites\ \#.sh
# Started On        - Wed 26 Feb 15:05:20 GMT 2020
# Last Change       - Wed 26 Feb 15:40:23 GMT 2020
# Author E-Mail     - terminalforlife@yahoo.com
# Author GitHub     - https://github.com/terminalforlife
#------------------------------------------------------------------------------
# List out the Clicks Per Day rank, on Distrowatch, of distributions in the
# past 7 days. The first argument (integer) decides how many total ranks are
# shown, with '10' being the maximum.
#
# Usage: Parsing\ Websites\ \#.sh [RANKS]
#------------------------------------------------------------------------------

URL='https://distrowatch.com/index.php?dataspan=trending-1'

printf '%-3s   %s\n' 'RANK' 'NAME'

Rank=0
wget -qO - "$URL" | while read Line; do
	case $Line in
		*'class="phr2"'*)
			Rank=$(( Rank + 1 ))
			Buffer=${Line#*a href=\"}
			printf '#%-3d   %s\n' $Rank "${Buffer%%\">*}"

			[ $Rank -eq ${1:-10} ] && exit 0 ;;
	esac
done
