#!/usr/bin/env bash

#------------------------------------------------------------------------------
# Project Name      - LearnLinux/Shell Tutorials/clearing-cache-files.sh
# Started On        - Wed 16 Dec 22:58:47 GMT 2020
# Last Change       - Wed 16 Dec 23:23:44 GMT 2020
# Author E-Mail     - terminalforlife@yahoo.com
# Author GitHub     - https://github.com/terminalforlife
#------------------------------------------------------------------------------
# Simple script to interactively remove cache and thumbnails of each user.
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

if [ $UID -gt 0 ]; then
	printf 'ERROR: Root access is required.\n' 1>&2
	exit 1
fi

for Dir /home/*; {
	read -sp "Delete cache files for '${Dir##*/}' user? [Y/N] "

	case $REPLY in
		[Yy][Ee][Ss]|[Yy])
			if [ -d "$Dir" ] && [ "$Dir" != 'lost+found' ]; then
				rm -rv "$Dir"/.cache "$Dir"/.thumbnails
			fi ;;
		[Nn][Oo]|[Nn])
			continue
	esac
}

apt-get autoremove
apt-get clean
