#!/usr/bin/bash

#------------------------------------------------------------------------------
# Project Name      - ChannelFiles/Miscellaneous Scripts/grep_after_in_awk.sh
# Started On        - Sat  3 Jul 04:01:13 BST 2021
# Last Change       - Sat  3 Jul 07:34:45 BST 2021
# Author E-Mail     - terminalforlife@yahoo.com
# Author GitHub     - https://github.com/terminalforlife
#------------------------------------------------------------------------------
# Mimic functionality of `grep -A 2 MATCH FILE`, using AWK, but only use the
# first match.
#------------------------------------------------------------------------------

awk -v Count=0 '
	{
		if (Found == "True") {
			Count++
			Lines[$0]++

			if (Count >= 2) {
				exit(0)
			}
		} else if ($0 ~ /^z/) {
			Found="True"
			MatchLine=$0
		}
	}

	END {
		print(MatchLine);

		asorti(Lines, Sorted);
		for (Line in Sorted) {
			print(Sorted[Line])
		}
	}
' <<-EOF
	Here
	are some
	z
	random lines
	for you lovely people
	!!!
EOF
