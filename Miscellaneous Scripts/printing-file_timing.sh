#!/usr/bin/env bash

#------------------------------------------------------------------------------
# Project Name      - ChannelFiles/Miscellaneous Scripts/printing-file_timing.sh
# Started On        - Thu  6 Jan 21:38:11 GMT 2022
# Last Change       - Thu  6 Jan 22:06:29 GMT 2022
# Author E-Mail     - terminalforlife@yahoo.com
# Author GitHub     - https://github.com/terminalforlife
#------------------------------------------------------------------------------
# My result, on an i5 4690K @ stock, not stressed:
#
#   Method 1: 0.001
#   Method 2: 0.189
#   Method 3: 0.570
#   Method 4: 0.822
#
# Various methods of displaying a large (>59,000 lines, 6.5MB) database with
# very long lines. The database (albeit not guaranteed to be the same size) can
# be acquired by using previewer(1) (see the PerlProjects repository).
#
# I've intentionally ordered them by speed, with the top method being the
# fastest. By all means, run this on a small, medium, and large file, to get
# an idea of what you might feel is appropriate for a given task.
#------------------------------------------------------------------------------

TIMEFORMAT='%R'

printf 'Method 1: '
time {
	cat ~/.config/reviewer.db
} &> /dev/null

printf 'Method 2: '
time {
	File=`< ~/.config/reviewer.db`
	printf '%s\n' "$File"
} &> /dev/null

printf 'Method 3: '
time {
	while read; do
		printf '%s\n' "$REPLY"
	done < ~/.config/reviewer.db
} &> /dev/null

printf 'Method 4: '
time {
	readarray Lines < ~/.config/reviewer.db
	printf '%s\n' "${Lines[@]}"
} &> /dev/null
