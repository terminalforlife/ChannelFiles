#!/usr/bin/env bash
#cito M:755 O:0 G:0 T:/usr/bin/ishelive
#------------------------------------------------------------------------------
# Project Name      - ChannelFiles/Miscellaneous Scripts/ishelive.sh
# Started On        - Fri  3 Sep 13:57:14 BST 2021
# Last Change       - Sat 22 Jan 02:48:23 GMT 2022
# Author E-Mail     - terminalforlife@yahoo.com
# Author GitHub     - https://github.com/terminalforlife
#------------------------------------------------------------------------------
# Simple script to show when 'Terminalforlife' (YouTube) is live streaming.
#
# Features:
#
# N/A
#
# Bugs:
#
#TODO: Completely broken. Keeps showing as 'Live', despite not being 'Live'.
#
# Dependencies:
#
#   bash (>= 3.0)
#   wget (>= 1.19.4-1) | curl (>= 7.58.0-2)
#------------------------------------------------------------------------------

CurVer='2022-01-22'
Progrm=${0##*/}

Usage() {
	while read; do
		printf '%s\n' "$REPLY"
	done <<-EOF
		Usage: $Progrm [OPTS]

		  -h, --help               - Display this help information.
		  -v, --version            - Output the version datestamp.
		  -C, --nocolor            - Omit ANSI color escape sequences.
		  -l, --link               - Display URL to YouTube channel.
	EOF
}

Err() {
	printf 'Err: %s\n' "$2" 1>&2
	(( $1 > 0 )) && exit $1
}

Domain='https://www.youtube.com'
URL="$Domain/c/Terminalforlife"
Match='"iconType":"LIVE"'

Red='\e[91m'
Green='\e[92m'
Reset='\e[0m'

while [[ -n $1 ]]; do
	case $1 in
		--help|-h|-\?)
			Usage; exit 0 ;;
		--version|-v)
			printf '%s\n' "$CurVer"; exit 0 ;;
		--nocolor|-C)
			NoColor='True' ;;
		--link|-l)
			DoLink='True' ;;
		*)
			Err 1 'Incorrect option(s) specified.' ;;
	esac
	shift
done

case $NoColor in
	True)
		Red=
		Green=
		Reset= ;;
esac

if type -P curl &> /dev/null; then
	Data=`curl -A 'Mozilla/5.0' -s "$URL"`
elif type -P wget &> /dev/null; then
	Data=`wget -U 'Mozilla/5.0' -qO - "$URL"`
else
	Err 1 "Neither 'wget' nor 'curl' found."
fi

while read Line; do
	case $Line in
		*$Match*)
			IsLive='True'
			break ;;
	esac
done <<< "$Data"

if [[ $IsLive == True ]]; then
	if [[ $DoLink == True ]]; then
		printf "${Green}%s$Reset\n" "$ChannelHome"
	else
		printf "${Green}Live$Reset\n"
	fi
else
	printf "$Red<Offline>$Reset\n"
fi
