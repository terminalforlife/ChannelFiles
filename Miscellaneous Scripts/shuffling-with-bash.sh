#!/usr/bin/env bash

#------------------------------------------------------------------------------
# Project Name      - ChannelFiles/Miscellaneous Scripts/shuffling-with-bash.sh
# Started On        - Fri 25 Mar 20:12:04 GMT 2022
# Last Change       - Fri 25 Mar 20:23:55 GMT 2022
# Author E-Mail     - terminalforlife@yahoo.com
# Author GitHub     - https://github.com/terminalforlife
#------------------------------------------------------------------------------
# Function version of the code I wrote in a recent commit to Extra. This was
# paired alongside a YouTube video which talked about this script. The function
# isn't necessary, but it's used here to demonstrate how it can be done as a
# function, especially with a name reference.
#
# CAVEAT: Do not provide duplicate values, else this function will not work, -
#         because it will never leave the loops; this is explained in the
#         aforementioned YouTube video.
#
#         Obviously, this is pure-BASH, so it's going to be pretty slow when
#         you start introducing a few hundred values, largely due to this not
#         being a particularly optimized solution -- refer to the YouTube video
#         for an explanation and some thoughts on that.
#
#         If portability is more important than performance, and you're using
#         this as a one-off and/of with few values, then this is a decent
#         solution.
#
# Do note that 'coreutils' provides shuf(1), which can do what this script is
# doing, and very quickly, making it ideal for shuffling a lot of values.
# Whether you consider a manual approach preferable is up to you and down to
# your circumstances.
#
#   printf '%s\n' some random values | shuf
#
# Because of the name reference, BASH >= 4.3 is required. Without the name
# reference, merely as early as BASH 3.1 is required, making this a potentially
# very portable solution.
#
# Usage: $0 STRING STRING [STRING ...]
#------------------------------------------------------------------------------

Shuf() {
	declare -n _Out=$1
	shift

	In=("$@")
	Len=${#In[@]}
	until (( ${#_Out[@]} == Len )); do
		while :; do
			Found='False'
			Rand=${In[RANDOM % Len]}
			for Index in "${_Out[@]}"; {
				if [[ $Index == $Rand ]]; then
					Found='True'
					break
				fi
			}

			if [[ $Found == False ]]; then
				_Out+=("$Rand")
				break
			fi
		done
	done
}

Shuf Shuffled "$@"
printf '%s\n' "${Shuffled[@]}"
