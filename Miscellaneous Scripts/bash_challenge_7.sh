#!/usr/bin/env bash

#------------------------------------------------------------------------------
# Project Name      - ChannelFiles/Miscellaneous Scripts/bash_challenge_7.sh
# Started On        - Tue  7 Dec 20:46:19 GMT 2021
# Last Change       - Tue  7 Dec 21:59:21 GMT 2021
# Author E-Mail     - terminalforlife@yahoo.com
# Author GitHub     - https://github.com/terminalforlife
#------------------------------------------------------------------------------
# A solution of mine for BASH Challenge #7 found on the below page.
#
# https://itsfoss.com/bash-challenge-7/
#
# A quick explanation of the challenge:
#
# The function mimics a data stream; it prints out either RED or BLUE, at
# random, 100 times, on a new line. You have to determine, from a single
# execution of `Stream()`, how many times RED was printed and how many times
# BLUE was printed.
#
# It was not specified whether the counter needed to be live or not.
#------------------------------------------------------------------------------

# You're not allowed to change this, although of course I did, but only
# superficially, not functionally. See the above link for the original code.
Stream() {
	Tokens=('RED' 'BLUE')
	for (( i = 0; i < 100; ++i )); {
		printf '%s\n' ${Tokens[RANDOM % 2]}
	}
}

# Create a FIFO (AKA: named pipe).
[ -p temp.fifo ] || mkfifo temp.fifo

# Start sending the data to the FIFO. Usually, in cases like this, you'd not
# want to use `>` instead of `>>`, but due to the way FIFOs work, it's okay
# here.
Stream > temp.fifo &

# Read from and process the FIFO, line-by-line.
while read; do
	case $REPLY in
		RED)
			(( RedCount++ )) ;;
		BLUE)
			(( BlueCount++ )) ;;
	esac

	printf '\rRed: %-3d   Blue: %-3d' $RedCount $BlueCount

	# Because otherwise it would run too fast to notice it's live.
	sleep 0.01s
done < temp.fifo

printf '\n'
