#!/usr/bin/perl

=pod

I had the bless() after a method call to _die. In older versions I called
Perl's die() so the location of the bless() didn't matter. Now it does.

Reported by Sagar Shah.

=cut

use strict;
use warnings;

use Test::More 1.0;

BEGIN {
	use File::Spec::Functions qw(rel2abs catfile);
	my $file = rel2abs( catfile( qw( t lib setup_common.pl) ) );
	require $file;
	}

unlink '.releaserc';
ok( ! (-e '.releaserc'), 'The .releaserc file is missing (good)' );

unlink 'releaserc';
ok( ! (-e 'releaserc'), 'The releaserc file is missing (good)' );

my $class = 'Module::Release';
use_ok( $class );

ok( ! eval{ close STDERR; $class->new() }, 'new() does not die (good)' );

like( $@, qr/Could not find conf file releaserc/,
	'Missing conf file dies with the right error message' );

done_testing();
