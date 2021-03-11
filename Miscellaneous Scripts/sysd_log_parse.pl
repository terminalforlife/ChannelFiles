#!/usr/bin/env perl

#------------------------------------------------------------------------------
# Project Name      - LearnLinux/Miscellaneous Scripts/sysd_log_parse.pl
# Started On        - Thu 11 Mar 15:03:17 GMT 2021
# Last Change       - Thu 11 Mar 15:08:05 GMT 2021
# Author E-Mail     - terminalforlife@yahoo.com
# Author GitHub     - https://github.com/terminalforlife
#------------------------------------------------------------------------------
# This was written to help with this Linux Mint support forum thread:
#
#   https://forums.linuxmint.com/viewtopic.php?f=90&t=342758
#
# Simple Perl script for the SystemD log, via journalctl(1), to display only
# unique messages, ignoring the time, date, and hostname, and only lines which
# match 'warning', 'error', and 'fail', case-insensitively.
#
# Usage: sysd_log_parse.pl file.log
#------------------------------------------------------------------------------

require List::MoreUtils;

use strict;
use warnings;
use autodie;
use List::MoreUtils 'uniq';

my @Lines;
while (my $Line = <>) {
	$Line =~ /(fail|error|warning)/ia or next;

	my @Cols = split(' ', $Line);
	@Cols = @Cols[4..$#Cols];
	$Line = map("$_ ", @Cols);
	push(@Lines, join(' ', @Cols))
}

print("$_\n") foreach uniq(@Lines)
