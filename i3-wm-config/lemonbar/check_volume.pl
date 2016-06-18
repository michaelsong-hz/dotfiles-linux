#!/usr/bin/env perl 
## Perl script used to check audio volume with pactl

## The sink we are interested in should be given as the 
## 1st argument to the script.
my $sink=$ARGV[0];

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
        ## Extract the current volume of this sink
        /Volume:.*?(\d+)%/;
        print "$1\n";
    }
}
