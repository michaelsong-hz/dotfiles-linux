#!/usr/bin/env perl 
## Perl script used to check audio volume with pactl

## The sink we are interested in should be given as the 
## 1st argument to the script.
die("Need a sink number as the first argument\n") if @ARGV < 1;
my $sink=$ARGV[0];

## If the script has been run with a second argument,
## that argument will be the volume threshold we are checking
my $volume_limit=$ARGV[1]||undef;

## Run the pactl command and save the output in 
## the filehandle $fh
open(my $fh, '-|', 'pactl list sinks');

## Set the record separator to consecutive newlines (same as -000)
## this means we read the info for each sink as a single "line".
$/="\n\n";

## Go through the pactl output
while (<$fh>) {
    ## If this is the sink we are interested in
    if (/#$sink/) {
        ## Checks if it is muted
        /Mute: (.+?)/;
        if ($1 eq 'y') { print "M("; }
        ## Extract the current colume of this sink
        /Volume:.*?(\d+)%/;
        print "$1\n";
    }
}
