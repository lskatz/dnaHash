#!/usr/bin/env perl 

use warnings;
use strict;
use Data::Dumper;
use Getopt::Long;
use File::Basename qw/basename/;

use Bio::SeqIO;

use version 0.77;
our $VERSION = '0.1.1';

local $0 = basename $0;
sub logmsg{local $0=basename $0; print STDERR "$0: @_\n";}
exit(main());

sub main{
  my $settings={};
  GetOptions($settings,qw(help)) or die $!;
  usage() if(!@ARGV || $$settings{help});

  # Get different powers of 2 for different nucleotides
  # before starting any heavy computation.
  my $ntFlags = ntFlags($settings);

  for my $fasta(@ARGV){
    my $in = Bio::SeqIO->new(-file=>$fasta);
    while(my $seq = $in->next_seq){
      my $int = dnaHash($seq->seq, $ntFlags, $settings);
      print join("\t", $seq->id, $int)."\n";
    }
  }

  return 0;
}

# return an int of a product sum of the DNA scores
# Each position is translated to base-1 and then multiplied
# with the flag of the nucleotide (A=>1, C=>2,...).
# Each product is summed across the DNA sequence.
sub dnaHash{
  my($dna, $ntFlags, $settings) = @_;

  my $productSum = 0;
  my $length = length($dna);
  for(my $i=0; $i<$length; $i++){
    my $nt = substr($dna, $i, 1);
    my $product = $$ntFlags{$nt} * ($i+1);
    $productSum += $product;
  }
  return $productSum;
}

# Create a hash of A=>1, C=>2, G=>4, T=>8,
# then B=>16, D=>32, E=>64, ... Z=>33554432
sub ntFlags{
  my($settings) = @_;
  
  # Make an order of nucleotides with the common ones up front
  my @order = ("A".."Z");
  for my $nt(sort{$b cmp $a} qw(A C G T)){
    @order = grep{$_ ne $nt} @order;
    unshift(@order, $nt);
  }

  # Apply increasing powers of 2 to each one
  my %flag;
  for(my $power=0; $power<@order; $power++){
    $flag{$order[$power]} = 2**$power;
  }
  return \%flag;
}

sub usage{
  print "$0: hashes DNA with a unique algorithm
  Usage: $0 [options] file1.fasta...
  --help   This useful help menu
  \n";
  exit 0;
}