#!/usr/bin/env bash

#------------------------------------------------------------------------------
# Project Name      - LearnLinux/Shell Tutorials/sort-films-by-year.sh
# Started On        - Sat  5 Jun 00:33:24 BST 2021
# Last Change       - Sat 22 Jan 03:07:45 GMT 2022
# Author E-Mail     - terminalforlife@yahoo.com
# Author GitHub     - https://github.com/terminalforlife
#------------------------------------------------------------------------------
# Uploaded for Learn Linux (YT channel) viewer Bruce Scott.
#
# If you like this, check out MIF (Movie Index Filter), an old BASH program I
# originally wrote many years ago; it organises films in a similar way to this.
#
# The main purpose of MIF, which can be found in the Extra repository on my
# GitHub, is to create a movie index file (using the same by-year directories)
# and to list movies by filtering those you've seen or not seen. User
# intervention is required to say whether you've seen a film, but it's all
# quite straight-forward.
#
# It might be time to update MIF with some of the new, fancier code shown
# below! I may also need to make a video on it, demonstrating its use.
#------------------------------------------------------------------------------

while read; do
	printf '%s\n' "$REPLY"
done <<-EOF

	!! Warning !!                                                 !! WARNING !!

	You've executed a script intended to create directories named the year of
	each of the films — as files — found in the current working directory, and
	to then move said files into their respective directories.

	A video about this script can be found here:
	https://www.youtube.com/watch?v=v1w58USfrjY
	You'll find the relevant information towards the end.

	NOTE: If you see no output after this warning, it's likely that no
	      appropriate files in the current working directory were handled.

	This script assumes the filenames follow the format of:

	'FILM_NAME (YYYY).EXT'

	Where 'EXT' is the file's extension, and 'YYYY' is a four-digit year. This
	much must be true! The film name itself can contain pretty much any set of
	characters, except the year between and including the parentheses.

	This action cannot be directly undone!

	!! WARNING !!                                                 !! WARNING !!

EOF

read -n 1 -p 'Press any key to continue... '
printf '\n\n'

# Add extensions to the brace expansion, if needed.
for File in *.{mkv,mp4,avi}; {
	[[ -f $File ]] || continue

	Count=0
	CaptureCount=0
	while (( Count <= ${#File} )); do
		Char=${File:Count:1}

		if [[ $Char == '(' ]]; then
			OpenParensFound='True'
		elif [[ $OpenParensFound == True ]]; then
			if (( CaptureCount == 4 )); then
				[[ $Char == ')' ]] && break
			else
				Year+=$Char

				(( CaptureCount++ ))
			fi
		fi

		(( Count++ ))
	done

	# Replace the four `[0-9]` instances with `[[:digit:]]` if you run into
	# locale issues; you probably won't, but I mention it just in-case.
	[[ -z ${Year/[0-9][0-9][0-9][0-9]/} ]] || continue

	[[ -d $Year ]] || mkdir -v "$Year"

	# Add the flag `--no-clobber` (or `-n`) if you want to disallow overwrites.
	mv -v "$File" "$Year"/
}
