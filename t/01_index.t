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

note "Running dnaHash.pl on $senterica ...";
my @obs = `dnaHash.pl $senterica/*.tfa`;
if(!@obs){
  BAIL_OUT("dnaHash.pl does not return any results");
}
chomp(@obs);

subtest 'dnaHash on senterica, all loci present' => sub{
  plan tests => scalar(@locus);

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
    aroC_1 => "MjI1NzY4NTcxOTAwNjQ3NzYzMDAwMDAwMDAwMDQ0MzIwNg==",
    aroC_2 => "MjI4MDUwMzQyOTgxMDU4NTc3MDAwMDAwMDAwMDQ0ODA3OA==",
    aroC_3 => "MjI4NDMwNjM4MTYxMTI3MDQ2MDAwMDAwMDAwMDQ0NTkwNg==",
    aroC_4 => "MjI4ODEwOTMzMzQxMTk1NTE1MDAwMDAwMDAwMDQ0NzgzOA==",
    aroC_5 => "MjI4MTc3MTA4MDQxMDgxNDAwMDAwMDAwMDAwMDQ0NjEzOQ==",
    aroC_6 => "MjI4NDMwNjM4MTYxMTI3MDQ2MDAwMDAwMDAwMDQ0ODIyOA==",
    aroC_7 => "MjI4MDUwMzQyOTgxMDU4NTc3MDAwMDAwMDAwMDQ0NTM3OA==",
    aroC_8 => "MjI4NDMwNjM4MTYxMTI3MDQ2MDAwMDAwMDAwMDQ0NTY2MA==",
    aroC_9 => "MjI4ODEwOTMzMzQxMTk1NTE1MDAwMDAwMDAwMDQ0NTkxOA==",
    aroC_10 => "MjI4MDUwMzQyOTgxMDU4NTc3MDAwMDAwMDAwMDQ0NjcyOA==",
    dnaN_1 => "MjQwOTgwMzc5MTAzMzg2NTIzMDAwMDAwMDAwMDQ3Mjk2MQ==",
    dnaN_2 => "MjM5NDU5MTk4MzgzMTEyNjQ3MDAwMDAwMDAwMDQ2NjcyNw==",
    dnaN_3 => "MjM5MDc4OTAzMjAzMDQ0MTc4MDAwMDAwMDAwMDQ2NTA4OQ==",
    dnaN_4 => "MjM4Njk4NjA4MDIyOTc1NzA5MDAwMDAwMDAwMDQ2Mzg1Mw==",
    dnaN_5 => "MjM4NDQ1MDc3OTAyOTMwMDYzMDAwMDAwMDAwMDQ2MzUyNQ==",
    dnaN_6 => "MjM4MzE4MzEyODQyOTA3MjQwMDAwMDAwMDAwMDQ2NDA5OQ==",
    dnaN_7 => "MjM4ODI1MzczMDgyOTk4NTMyMDAwMDAwMDAwMDQ2NTMyMw==",
    dnaN_8 => "MjQxNzQwOTY5NDYzNTIzNDYxMDAwMDAwMDAwMDQ3MTA5Mg==",
    dnaN_9 => "MjQwOTgwMzc5MTAzMzg2NTIzMDAwMDAwMDAwMDQ2ODA4Mw==",
    dnaN_10 => "MjM3OTM4MDE3NjYyODM4NzcxMDAwMDAwMDAwMDQ2MzcwNg==",
    hemD_1 => "MjA0NzI1NTcxOTM2ODU5MTQ1MDAwMDAwMDAwMDM0NzE1NQ==",
    hemD_2 => "MjAzOTY0OTgxNTc2NzIyMjA3MDAwMDAwMDAwMDM0NjM4Nw==",
    hemD_3 => "MjAyMzE3MDM1Nzk2NDI1NTA4MDAwMDAwMDAwMDM0NDAzNw==",
    hemD_4 => "MjAxOTM2NzQwNjE2MzU3MDM5MDAwMDAwMDAwMDM0MzQ1OA==",
    hemD_5 => "MjAxOTM2NzQwNjE2MzU3MDM5MDAwMDAwMDAwMDM0MzI5Mw==",
    hemD_6 => "MjAzNDU3OTIxMzM2NjMwOTE1MDAwMDAwMDAwMDM0MjM4MQ==",
    hemD_7 => "MjAyMzE3MDM1Nzk2NDI1NTA4MDAwMDAwMDAwMDM0MzMwOA==",
    hemD_8 => "MjAyNjk3MzMwOTc2NDkzOTc3MDAwMDAwMDAwMDM0NDA1Mg==",
    hemD_9 => "MjAyNDQzODAwODU2NDQ4MzMxMDAwMDAwMDAwMDM0NDEwMw==",
    hemD_10 => "MjAyMTkwMjcwNzM2NDAyNjg1MDAwMDAwMDAwMDM0Mjg1Ng==",
    hisD_1 => "MjI5MzE3OTkzNTgxMjg2ODA3MDAwMDAwMDAwMDQ0NDg4MQ==",
    hisD_2 => "MjI5MDY0NDYzNDYxMjQxMTYxMDAwMDAwMDAwMDQ0NDQ4Mw==",
    hisD_3 => "MjMwMDc4NTgzOTQxNDIzNzQ1MDAwMDAwMDAwMDQ0NjYzMw==",
    hisD_4 => "MjMxNTk5NzY0NjYxNjk3NjIxMDAwMDAwMDAwMDQ0ODgyMw==",
    hisD_5 => "MjI5NDQ0NzU4NjQxMzA5NjMwMDAwMDAwMDAwMDQ0MzAzOA==",
    hisD_6 => "MjI4OTM3Njk4NDAxMjE4MzM4MDAwMDAwMDAwMDQ0MzAzMA==",
    hisD_7 => "MjMwNDU4ODc5MTIxNDkyMjE0MDAwMDAwMDAwMDQ0NzI2NQ==",
    hisD_8 => "MjMwNTg1NjQ0MTgxNTE1MDM3MDAwMDAwMDAwMDQ0NTk5MA==",
    hisD_9 => "MjI4OTM3Njk4NDAxMjE4MzM4MDAwMDAwMDAwMDQ0MzQ3NA==",
    hisD_10 => "MjI5ODI1MDUzODIxMzc4MDk5MDAwMDAwMDAwMDQ0Njk4OQ==",
    purE_1 => "MTc4ODY1NDk5NjkyMjAzMjUzMDAwMDAwMDAwMDI3OTA1NA==",
    purE_2 => "MTc3NDcxMDg0MDMxOTUyMjAwMDAwMDAwMDAwMDI3NDI4Mg==",
    purE_3 => "MTc1OTQ5OTAzMzExNjc4MzI0MDAwMDAwMDAwMDI2OTk1Ng==",
    purE_4 => "MTc4NDg1MjA0NTEyMTM0Nzg0MDAwMDAwMDAwMDI3NDgxNA==",
    purE_5 => "MTc4MTA0OTA5MzMyMDY2MzE1MDAwMDAwMDAwMDI3NDUwMg==",
    purE_6 => "MTc4MTA0OTA5MzMyMDY2MzE1MDAwMDAwMDAwMDI3NTYzNg==",
    purE_7 => "MTc4MjMxNjc0MzkyMDg5MTM4MDAwMDAwMDAwMDI3NTgyNA==",
    purE_8 => "MTc3MzQ0MzE4OTcxOTI5Mzc3MDAwMDAwMDAwMDI3NDAyMg==",
    purE_9 => "MTc5NjI2MDkwMDUyMzQwMTkxMDAwMDAwMDAwMDI3NzA4Mg==",
    purE_10 => "MTc4NDg1MjA0NTEyMTM0Nzg0MDAwMDAwMDAwMDI3NTY3Mg==",
    sucA_1 => "MjMwOTY1OTM5MzYxNTgzNTA2MDAwMDAwMDAwMDQ1NjcxNQ==",
    sucA_2 => "MjI3Nzk2ODEyODYxMDEyOTMxMDAwMDAwMDAwMDQ0Nzg4MA==",
    sucA_3 => "MjI5MzE3OTkzNTgxMjg2ODA3MDAwMDAwMDAwMDQ1MjgwNg==",
    sucA_4 => "MjI5NDQ0NzU4NjQxMzA5NjMwMDAwMDAwMDAwMDQ1Mjg0NQ==",
    sucA_5 => "MjMwMDc4NTgzOTQxNDIzNzQ1MDAwMDAwMDAwMDQ1MTM3Ng==",
    sucA_6 => "MjI4NTU3NDAzMjIxMTQ5ODY5MDAwMDAwMDAwMDQ1MDM2NA==",
    sucA_7 => "MjI4NTU3NDAzMjIxMTQ5ODY5MDAwMDAwMDAwMDQ1MDU2Mg==",
    sucA_8 => "MjI5ODI1MDUzODIxMzc4MDk5MDAwMDAwMDAwMDQ1Mjk3Ng==",
    sucA_9 => "MjI3Nzk2ODEyODYxMDEyOTMxMDAwMDAwMDAwMDQ1MDA0Ng==",
    sucA_10 => "MjI4NTU3NDAzMjIxMTQ5ODY5MDAwMDAwMDAwMDQ1MDUyNg==",
    thrA_1 => "MjM3Njg0NDg3NTQyNzkzMTI1MDAwMDAwMDAwMDQ3MDU1Mg==",
    thrA_2 => "MjM4MTkxNTQ3NzgyODg0NDE3MDAwMDAwMDAwMDQ3MjEyNg==",
    thrA_3 => "MjM2OTIzODk3MTgyNjU2MTg3MDAwMDAwMDAwMDQ2ODUzMw==",
    thrA_4 => "MjM4MTkxNTQ3NzgyODg0NDE3MDAwMDAwMDAwMDQ3MDM0NA==",
    thrA_5 => "MjM5MjA1NjY4MjYzMDY3MDAxMDAwMDAwMDAwMDQ3MTgyNA==",
    thrA_6 => "MjM4MTkxNTQ3NzgyODg0NDE3MDAwMDAwMDAwMDQ3MTg4Ng==",
    thrA_7 => "MjM5MzMyNDMzMzIzMDg5ODI0MDAwMDAwMDAwMDQ3NTAyMQ==",
    thrA_8 => "MjM4NDQ1MDc3OTAyOTMwMDYzMDAwMDAwMDAwMDQ3MDcxNA==",
    thrA_9 => "MjM4ODI1MzczMDgyOTk4NTMyMDAwMDAwMDAwMDQ3MDM2OQ==",
    thrA_10 => "MjM5NzEyNzI4NTAzMTU4MjkzMDAwMDAwMDAwMDQ3NTI2NA==",
  );

  plan tests=>scalar(keys(%exp));

  for my $obs(@obs){
    my($allele, $int) = split(/\t/, $obs);
    next if(!$exp{$allele});

    is($int, $exp{$allele}, $allele);
  }
}

