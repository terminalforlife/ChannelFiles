#!/usr/bin/env bash

#------------------------------------------------------------------------------
# Project Name      - ChannelFiles/Miscellaneous Scripts/ishelive.sh
# Started On        - Fri  3 Sep 13:57:14 BST 2021
# Last Change       - Fri  3 Sep 14:35:42 BST 2021
# Author E-Mail     - terminalforlife@yahoo.com
# Author GitHub     - https://github.com/terminalforlife
#------------------------------------------------------------------------------
# Features:
#
#TODO: Display URL if live.
#
# Bugs:
#
# N/A
#
# Dependencies:
#
#   bash (>= 4.3-14)
#   wget (>= 1.19.4-1) | curl (>= 7.58.0-2)
#------------------------------------------------------------------------------

CurVer='2021-09-03'
Progrm=${0##*/}

Usage(){
	while read; do
		printf '%s\n' "$REPLY"
	done <<-EOF
		Usage: $Progrm [OPTS]

		  -h, --help               - Display this help information.
		  -v, --version            - Output the version datestamp.
	EOF
}

Err(){
	printf 'ERROR: %s\n' "$2" 1>&2
	[ $1 -gt 0 ] && exit $1
}

Domain='https://www.youtube.com'
URL="$Domain/results?search_query=Terminalforlife&sp=EgQQAUAB"

while [ "$1" ]; do
	case $1 in
		--help|-h|-\?)
			Usage; exit 0 ;;
		--version|-v)
			printf '%s\n' "$CurVer"; exit 0 ;;
		*)
			Err 1 'Incorrect option(s) specified.' ;;
	esac
	shift
done

if type -P curl &> /dev/null; then
	Data=`curl -A 'Mozilla/5.0' -s "$URL"`
elif type -P wget &> /dev/null; then
	Data=`wget -U 'Mozilla/5.0' -qO - "$URL"`
else
	Err 1 "Neither 'wget' nor 'curl' found."
fi

while read Line; do
	case $Line in
		*'"live_chat_show_ongoing_poll_results_in_banner":true'*)
			IsLive='True' ;;
	esac
done <<< "$Data"

printf 'Terminalforlife: '
if [ "$IsLive" == 'True' ]; then
	printf '\e[92mLive\e[0m\n'
else
	printf '\e[91mOffline\e[0m\n'
fi
