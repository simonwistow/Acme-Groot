package Acme::Groot;
use strict;
use warnings;
our $VERSION = '1.0';

my $branches = "GRooT gROOT " x 2;
my $i        = 0;

sub _groot {
    my $roots = unpack "b*", pop;
    my @groot = ( 'g', 'r', 'o', 'o', 't', ' ' );
    my @GROOT = ( 'G', 'R', 'O', 'O', 'T', "\t" );
    my $leaves = $branches;
    foreach ( split //, $roots ) {
        $leaves .= $_ ? $GROOT[$i] : $groot[$i];
        $i++;
        $i = 0 if $i > 5;
    }
    return $leaves;
}

sub _ungroot {
    my $leaves = pop;
    $leaves =~ s/^$branches//g;
    my @roots;
    foreach ( split //, $leaves) {
        push @roots, /[groot ]/ ? 0 : 1;
    }
    return pack "b*", join '', @roots;
}

sub _i_am_groot {
    return $_[0] =~ /\S/;
}

sub _I_am_GROOT {
    return $_[0] =~ /^$branches/;
}

sub import {
    open 0 or print "Can't regroot '$0'\n" and exit;
    ( my $groot = join "", <0> ) =~ s/.*^\s*use\s+Acme::Groot\s*;\n//sm;
    local $SIG{__WARN__} = \&evil;
    do { eval _ungroot $groot; exit }
        unless _i_am_groot $groot and not _I_am_GROOT $groot;
    open my $fh, ">$0" or print "Cannot groot '$0'\n" and exit;
    print $fh "use Acme::Groot;\n", _groot $groot and exit;
    print "use Acme::Groot;\n", _groot $groot and exit;
    return;
}
"I am Groot";

__END__

=head1 NAME

Acme::Groot - An encoding scheme for Guardians of the Galaxy fans

=head1 SYNOPSIS

  use Acme::Groot;

  print "I am Groot";

=head1 DESCRIPTION

The first time you run a program under C<use Acme::Groot>, the module
removes most of the unsightly characters from your source file.  The
code continues to work exactly as it did before, but now it looks like
this:

  use Acme::Groot;
  GRooT gROOT GRooT gROOT grooT	GroOt GROoT gRoOT gROOt	GrooT GROot groOt 
  gRoot	grOot	grOot groOt Groot	GrOoT	gROot groOt GROot GroOt GROoT	GRoOT 
  GROOt	GrooT GROoT groOt grOOT GroOT	gROot	groOt GRoOT	gr

=head1 DIAGNOSTICS

=head2 C<Can't groot '%s'>

Acme::Groot could not access the source file to modify it.

=head2 C<Can't regroot '%s'>

Acme::Groot could not access the source file to execute it.

=head1 AUTHOR

Simon Wistow <simon@thegestalt.org>

This was based on Leon Brocard's Acme::Buffy module which was, in turn,
based on Damian Conway's Bleach module and was inspired by an
idea by Philip Newton. I too blame the London Perl Mongers ...
http://www.mail-archive.com/london-pm%40lists.dircon.co.uk/msg03353.html


=head1 COPYRIGHT

Copyright (c) 2017, Simon Wistow. All Rights Reserved.  This module is
free software. It may be used, redistributed and/or modified under the
terms of the Perl Artistic License (see
http://www.perl.com/perl/misc/Artistic.html)

