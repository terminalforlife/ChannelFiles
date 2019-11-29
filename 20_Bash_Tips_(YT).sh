#!/bin/bash

#----------------------------------------------------------------------------------
# Project Name      - 20 Bash Tips (YT).sh
# Started On        - Sun 21 Apr 22:37:04 BST 2019
# Last Change       - Fri 26 Apr 15:00:36 BST 2019
# Author E-Mail     - terminalforlife@yahoo.com
# Author GitHub     - https://github.com/terminalforlife
#----------------------------------------------------------------------------------

printf '\n#------------------------------+ BELOW IS THE RESULT OF THE CODE ABOVE +----------------------------------'
printf '\n                               +---------------------------------------+\n\n'

shopt -s globstar
ls -C **

[[ STRING == STRING ]] && echo "WHY?!"
[ STRING == STRING ] && echo "Better."

[[ REGEXSTRING =~ [XS] ]] && echo "Contains X or S."

find /boot -type d -name grub > /dev/null 2>&1
find /boot -type d -name grub > /dev/null 2>&1

A="My string."
echo "${A:3:8}"
echo "${A/rin/rrring}"

[ STRING == STRING ] && echo "True"
[ STRING = STRING ] && echo "Still true"

[ $USER == "ichy" ] && [ $UID -eq 1000 ] && echo "You are ichy."
[ $USER == "ichy" -a $UID -eq 1000 ] && echo "You are still ichy."

declare -i A=1
A+=1
echo $A

A=1
let A=A+1
echo $A
let A++
echo $A

B="My string."
echo ${#B}

declare -a C=("thing" "thing2" "thing3")
echo ${#C[@]}

date "+%F_%X"
printf "%(%F_%X)T\n"

printf -v DUH "%(%F_%X)T\n"
echo $DUH

while read; do
	printf "%s\n" "$REPLY"
done <<-EOF
	Some text would go here.
	And some more here.
	More!
	EVEN MORE!
EOF

cat <<-EOF
	Using cat.
EOF

{ echo hi1; echo hi2; echo hi3; } > $HOME/.logfile.log

! [ STRING1 == STRING1 -a STRING2 == STRING2 ]

echo $(echo $(date))
echo $(echo $(date))

while read; do
	printf "%s\n" "$REPLY"
done < /proc/uptime

echo "Sorry, I can't remember how FIFOs work, and I find them annoying!"

#PROMPT_PARSER(){
#	:
#}
#PROMPT_COMMAND='PROMPT_PARSER'


