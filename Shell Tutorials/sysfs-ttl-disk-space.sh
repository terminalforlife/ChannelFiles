#!/usr/bin/env bash

#------------------------------------------------------------------------------
# Project Name      - LearnLinux/Shell Tutorials/sysfs-ttl-disk-space.sh
# Started On        - Thu 17 Dec 17:17:40 GMT 2020
# Last Change       - Sat 22 Jan 03:24:45 GMT 2022
# Author E-Mail     - terminalforlife@yahoo.com
# Author GitHub     - https://github.com/terminalforlife
#------------------------------------------------------------------------------

for Dir in /sys/block/*; {
	[[ -d $Dir ]] || continue

	CurSectors=`< "$Dir"/size`
	(( Sectors += CurSectors ))
}

Result=$(( (Sectors * 512) / 1024 / 1024 / 1024 ))

printf "Total: %'d GiB\n" $Result
