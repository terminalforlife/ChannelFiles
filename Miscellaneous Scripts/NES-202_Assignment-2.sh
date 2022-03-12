#!/usr/bin/env bash

#------------------------------------------------------------------------------
# Project Name      - ChannelFiles/Miscellaneous Scripts/NES-202_Assignment-2.sh
# Started On        - Sat 12 Mar 01:44:15 GMT 2022
# Last Change       - Sat 12 Mar 03:24:21 GMT 2022
# Author E-Mail     - terminalforlife@yahoo.com
# Author GitHub     - https://github.com/terminalforlife
#------------------------------------------------------------------------------
# Adresses the below assignment, found on YouTube.
#
#   https://www.youtube.com/watch?v=H_nCtDlcHQg
#
# I should point out: I don't understand a word the man said in the video.
#
# NOTES:
#
#   * Recursive operations weren't specified in the video, so I didn't opt for
#     a recursive function or using find(1). Generally, if you don't need
#     recursion, I don't see the need for something like find(1).
#
#   * Globbing tends to sort things, but to ensure things are properly
#     sorted, I used a `Sort()` function with a name reference to the array to
#     sort. The sort(1) tool from coreutils could've been used instead, but it
#     would've been a dependency, and it's not especially necessary, unless
#     there are a LOT of files in the target directory, or the machine is slow.
#
#   * For the most part, this script makes efficient use of system resources, -
#     with only 2 dependencies: less(1) for paging and numfmt(1) for formatting
#     the file size in a human-readable way. Paging wasn't specified, but it
#     seemed impractical without it, especially given the looping nature of the
#     menu.
#
#   * I find the menu excessive. It's ill-worded, not very presentable, and the
#     lines are far too long, but it was part of the assignment, so I stuck
#     with it. I would've probably used the `select` loop if it weren't for the
#     desired menu title. I do prefer to write it all out manually, though.
#
#   * It wasn't specified to write this in BASH or '/bin/sh', so I went with
#     BASH, as it's modern, a commonly-found shell, and offers features which
#     would make this more efficient and easier to write and maintain.
#
#   * There was no mention of hidden files, but if we're talking about "all -
#     files", we should include them, so I used `dotglob` to do so.
#
#   * To avoid making a mess of the user's terminal, I opted to use tput(1)
#     (for portability) to save and restore the terminal text before the loop
#     starts. Part of this process was to use the `trap` builtin to ensure the
#     user's terminal returned to normal at EXIT.
#------------------------------------------------------------------------------

Err() {
	printf '%s: %s\n' "$1" "$2" 1>&2
	exit 1
}

if (( $# != 1 )); then
	Err "${0##*/}" 'Accept one argument only'
elif ! [[ -d $1 ]]; then
	Err "$1" 'does not exist'
fi

# Semi-optimized bubble sort algo., for lexicographic array sorting in
# ascending order. It's asking a lot of BASH if you have several thousands of
# files.
Sort() {
	declare -n Arr=$1

	Len=${#Arr[@]}
	for (( Iter = 0; Iter < Len; Iter++ )); {
		Switched='False'
		for (( Index = 0; Index < Len - (1 + Iter); Index++ )); {
			if [[ ${Arr[Index]} > ${Arr[Index + 1]} ]]; then
				Temporary=${Arr[Index]}
				Arr[Index]=${Arr[Index + 1]}
				Arr[Index + 1]=$Temporary

				Switched='True'
			fi
		}

		[[ $Switched == False ]] && break
	}
}

SigHandler() {
	tput rmcup
}

trap SigHandler EXIT HUP

read -d '' Menu <<-EOF
	PLEASE SELECT A CHOICE:
	  1. List name of all files that end with .sh only inn the given directory.
	  2. List name of all files that are writable in the given directory.
	  3. List name and size of the file with largest size in the given directory.
	  4. List all filenames that have at least one digit in the given directory. Ex: ass2.sh
	  5. Exit
EOF

shopt -s dotglob

tput smcup
tput clear
while :; do
	printf '\ec%s\n\n' "$Menu"
	read -p ': '

	case $REPLY in
		1)
			for File in *.sh; {
				[[ -f $File ]] && Files+=("$File")
			}

			Sort Files
			printf '%s\n' "${Files[@]}" | less ;;
		2)
			for File in *; {
				[[ -f $File && -w $File ]] && Files+=("$File")
			}

			Sort Files
			printf '%s\n' "${Files[@]}" | less ;;
		3)
			for File in *; {
				if [[ -f $File && -w $File ]]; then
					Files+=(`stat -c '%f:%s' "$File"`)
				fi
			} | less ;;
		4)
			# Cannot convert an array to an associative array, so if the user
			# selects one of the other array-related options, then this, it'll
			# break. This fixes that by re-declaring the variable.
			unset Files

			for File in *; {
				if [[ -f $File ]]; then
					Size=`stat -c '%s' "$File" 2>&-`
					declare -A Files[$Size]=$File
				fi
			}

			for Size in "${!Files[@]}"; {
				(( Size > MaxSize )) && (( MaxSize = Size ))
			}

			printf '\n'
			printf '%s %s\n' $MaxSize "${Files[$MaxSize]}" | numfmt --to=iec
			printf '\n'

			read -sn 1 -p 'Press any key to continue... ' ;;
		5)
			break ;;
	esac
done
