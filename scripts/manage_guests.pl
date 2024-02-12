#!/usr/bin/perl
use strict;
use warnings;

if (scalar @ARGV == 0) {
    print "No input\n";
    exit 0;
}

# get the file from the arguments
my $filename = $ARGV[0];

# Open the file for reading
open(my $fh, '<', $filename) or die "Failed to open $filename: $!";

# Read guest names from the file
my @guests;
while (my $guest = <$fh>) {
    chomp $guest;  # Remove newline character
    push @guests, $guest;
}

# Close the file
close $fh;

if (scalar @ARGV == 1) {
    print "No action specified\n";
    exit 1;
}

# Get action to execute
my $action = lc $ARGV[1];

if (!ref($action) eq 'SCALAR') {
    print "Action must be a string\n";
}

# Print the guest names
foreach my $guest (@guests) {
    print "Guest is: $guest ==> ";
    if ($action eq "start") {
        print "Booting guest\n";
        system "virsh start $guest";
    } elsif ($action eq "stop") {
        print "Stopping guest\n";
        system "virsh shutdown $guest";
    } elsif ($action eq "restore") {
        if (scalar @ARGV == 2) {
            print "You need to provide a snapshot name\n";
            exit 1;
        }
        my $snapshot = $ARGV[2];
        print "Restoring $snapshot for guest\n";
        system "virsh snapshot-revert --domain $guest --snapshotname $snapshot --force";
    } else {
        print "Unknown action: $action\n";
    }
}