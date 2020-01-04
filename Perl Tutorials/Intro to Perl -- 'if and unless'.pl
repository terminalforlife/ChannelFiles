#!/usr/bin/env perl

use strict;
use warnings;
use autodie;

if ($< == 0){
	print("You are root.\n")
}elsif ($< == 1000){
	print("You are 'ichy'.\n")
}else{
	print("I don't know who you are.\n")
}

print("$ENV{USER}\n")
	if $ENV{USER} eq 'ichy';

print("$ENV{USER}\n") if $ENV{USER} eq 'ichy';
print("$ENV{USER}\n") unless $ENV{USER} ne 'ichy';

unless ($< != 0){
	print("You are root.\n")
}elsif ($< == 1000){
	print("You are 'ichy'.\n")
}else{
	print("I don't know who you are.\n")
}

if (not $< == 0){
	print("You are not root.\n")
}elsif ($< != 1000){
	print("You are not 'ichy'.\n")
}else{
	print("You are neither 'root' nor 'ichy'.")
}

# Numeric comparison operators.
# ==       - Equal to
# !=       - Not equal to
# >        - Greater than
# <        - Less than
# <=       - Less than or equal to
# >=       - Greater than or equal to

if ('this' =~ '^th'){
	print("Regex matched.\n")
}elsif ('this' ne 'this'){
	print("String is equal to.\n")
}

# String comparison operators.
# eq       - Same as (equal to)
# ne       - Not the same (not equal to)
# gt       - Greater than
# lt       - Less than
# le       - Less than or equal to
# ge       - Greater than
# =~       - String is equal to REGEX
# !~       - String is not equal to REGEX

#THING ? THING : THING
