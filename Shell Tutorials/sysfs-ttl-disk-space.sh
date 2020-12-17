#!/usr/bin/env bash

#------------------------------------------------------------------------------
# Project Name      - LearnLinux/Shell Tutorials/sysfs-ttl-disk-space.sh
# Started On        - Thu 17 Dec 17:17:40 GMT 2020
# Last Change       - Thu 17 Dec 17:17:51 GMT 2020
# Author E-Mail     - terminalforlife@yahoo.com
# Author GitHub     - https://github.com/terminalforlife
#------------------------------------------------------------------------------

declare -i Sectors=0
for Dir in /sys/block/*; {
	[ -d "$Dir" ] || continue
	Sectors+=`< "$Dir"/size`
}

Result=$(( (Sectors * 512) / 1024 / 1024 ))

printf "Total: %'d GiB\n" $Result
