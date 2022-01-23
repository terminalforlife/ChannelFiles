#!/usr/bin/env bash

#------------------------------------------------------------------------------
# Project Name      - LearnLinux/Shell Tutorials/clearing-cache-files.sh
# Started On        - Wed 16 Dec 22:58:47 GMT 2020
# Last Change       - Sat 22 Jan 03:03:30 GMT 2022
# Author E-Mail     - terminalforlife@yahoo.com
# Author GitHub     - https://github.com/terminalforlife
#------------------------------------------------------------------------------
# Simple script to interactively remove cache and thumbnails of each user, as
# well as blast away cached (downloaded) Debian packages and uninstall what was
# installed by 'orphaned' packages.
#
# You can either run:
#
#   $ chmod u+x clearing-cache-files.sh
#
# So that you need only run:
#
#   $ ./clearing-cache-files.sh
#
# ...or you can just run:
#
#   $ bash clearing-cache-files.sh
#
# This will ignore the root user, by the way.
#------------------------------------------------------------------------------

if (( UID > 0 )); then
	printf 'Err: Root access is required.\n' 1>&2
	exit 1
fi

for Dir in /home/*; {
	read -sp "Delete cache files for '${Dir##*/}' user? [Y/N] "

	case $REPLY in
		[Yy][Ee][Ss]|[Yy])
			if [[ -d $Dir && $Dir != lost+found ]]; then
				rm -rv "$Dir"/.cache "$Dir"/.thumbnails
			fi ;;
		[Nn][Oo]|[Nn])
			continue
			exit 2 ;;
		*|'')
			exit 2 ;;
	esac
}

apt-get autoremove
apt-get clean
