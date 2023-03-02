#!/usr/bin/env perl

use strict;
use warnings;
use lib './lib';
use File::Basename qw/dirname/;
use FindBin qw/$RealBin/;
use Data::Dumper;

use Test::More tests => 2;

$ENV{PATH} = "$RealBin/../scripts:".$ENV{PATH};

my $senterica = dirname($0)."/senterica";
my @locus = qw(aroC dnaN hemD hisD purE sucA thrA);

subtest 'dnaHash on senterica, all loci present' => sub{
  plan tests => scalar(@locus);

  my @obs = `dnaHash.pl $senterica/*.tfa`;
  if(!@obs){
    BAIL_OUT("dnaHash.pl does not return any results");
  }
  
  for my $locus(@locus){
    my $numAlleles = grep(/$locus/, @obs);
    cmp_ok($numAlleles, '>', 0, "at least one $locus result");
  }
};

subtest 'dnaHash on senterica' => sub{

  my %exp=(
    aroC_1 => 444987,
    aroC_2 => 449877,
    aroC_3 => 447708,
    aroC_4 => 449643,
    aroC_5 => 447939,
    aroC_6 => 450030,
    aroC_7 => 447177,
    aroC_8 => 447462,
    aroC_9 => 447723,
    aroC_10 => 448527,

    dnaN_1 => 474862,
    dnaN_2 => 468616,
    dnaN_3 => 466975,
    dnaN_4 => 465736,
    dnaN_5 => 465406,
    dnaN_6 => 465979,
    dnaN_7 => 467207,
    dnaN_8 => 472999,
    dnaN_9 => 469984,
    dnaN_10 => 465583,

    hemD_1 => 348770,
    hemD_2 => 347996,
    hemD_3 => 345633,
    hemD_4 => 345051,
    hemD_5 => 344886,
    hemD_6 => 343986,
    hemD_7 => 344904,
    hemD_8 => 345651,
    hemD_9 => 345700,
    hemD_10 => 344451,

    hisD_1 => 446690,
    hisD_2 => 446290,
    hisD_3 => 448448,
    hisD_4 => 450650,
    hisD_5 => 444848,
    hisD_6 => 444836,
    hisD_7 => 449083,
    hisD_8 => 447809,
    hisD_9 => 445280,
    hisD_10 => 448802,

    purE_1 => 280465,
    purE_2 => 275682,
    purE_3 => 271344,
    purE_4 => 276222,
    purE_5 => 275907,
    purE_6 => 277041,
    purE_7 => 277230,
    purE_8 => 275421,
    purE_9 => 278499,
    purE_10 => 277080,

    sucA_1 => 458537,
    sucA_2 => 449677,
    sucA_3 => 454615,
    sucA_4 => 454655,
    sucA_5 => 453191,
    sucA_6 => 452167,
    sucA_7 => 452365,
    sucA_8 => 454789,
    sucA_9 => 451843,
    sucA_10 => 452329,

    thrA_1 => 472427,
    thrA_2 => 474005,
    thrA_3 => 470402,
    thrA_4 => 472223,
    thrA_5 => 473711,
    thrA_6 => 473765,
    thrA_7 => 476909,
    thrA_8 => 472595,
    thrA_9 => 472253,
    thrA_10 => 477155,

  );

  plan tests=>scalar(keys(%exp));

  my @obs = `dnaHash.pl $senterica/*.tfa`;
  if(!@obs){
    BAIL_OUT("dnaHash.pl does not return any results");
  }
  
  chomp(@obs);
  for my $obs(@obs){
    my($allele, $int) = split(/\t/, $obs);
    next if(!$exp{$allele});

    is($int, $exp{$allele}, $allele);
  }
}

