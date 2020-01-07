#!/usr/bin/env perl

use strict;
use warnings;
use autodie;

my $A = 0;
my $B = 'string';
chomp(my $C = `ls`);

print("$A\n");
print("$B\n");
print("$C\n");

#----------------------------------------------------------------------------------

my @List = ('one', 'two', 'three');

foreach my $Index (@List){
	print("$Index, ")
}

print("\n");

#----------------------------------------------------------------------------------

if ($< == 1000){
	print("You are 'ichy'.\n")
}elsif ($< == 0){
	print("You are 'root'.\n")
}else{
	print("I don't know you!\n")
}
