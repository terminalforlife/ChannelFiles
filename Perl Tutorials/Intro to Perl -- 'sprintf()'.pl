#!/usr/bin/env perl

use strict;
use warnings;
use autodie;

my $Variable = 'Tom Hanks';

my $NewVar = sprintf("%s\n", $Variable);

print("$NewVar\n")
