#!/usr/bin/env bash

#------------------------------------------------------------------------------
# Project Name      - ChannelFiles/Miscellaneous Scripts/unused_workspaces_in_i3.sh
# Started On        - Thu 25 Nov 01:04:26 GMT 2021
# Last Change       - Thu 25 Nov 01:11:39 GMT 2021
# Author E-Mail     - terminalforlife@yahoo.com
# Author GitHub     - https://github.com/terminalforlife
#------------------------------------------------------------------------------
# I wrote this script to help someone with their i3 (window manager) script, -
# but thought it might be useful for other people, too. It basically lists out
# workspaces which are NOT in use, based on workspaces which ARE and a list of
# valid workspaces.
#
# This probably requires that the workspace names be numeric.
#------------------------------------------------------------------------------

# The individual available (valid) numeric workspace names.
Valids=({1..10})

# Generate a list of workspaces, by name, which are in-use.
IFS=',' read -a Fields <<< "$(i3-msg -t get_workspaces)"
for Field in "${Fields[@]}"; {
	case $Field in
		\"num\":*) Loadeds+=("${Field#*:}") ;;
	esac
}

# Determine workspaces which are not in use.
for Valid in "${Valids[@]}"; {
	Found='False'
	for Loaded in "${Loadeds[@]}"; {
		[ "$Valid" == "$Loaded" ] && Found='True'
	}

	[ "$Found" == 'False' ] && Unloadeds+=("$Valid")
}

printf '%s\n' "${Unloadeds[@]}"
