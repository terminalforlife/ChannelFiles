#!/bin/sh

A=0
B='string'
C=`ls`

printf "$A\n"
printf "$B\n"
printf "$C\n"

#----------------------------------------------------------------------------------

Array=('one' 'two' 'three')

for Index in ${Array[@]}; do
	printf "$Index, "
done

printf "\n"

#----------------------------------------------------------------------------------

if [ `id -u` -eq 1000 ]; then
	echo "You are 'ichy'."
elif [ `id -u` -eq 0 ]; then
	echo "You are 'root'."
else
	echo "I don't know you!"
fi
