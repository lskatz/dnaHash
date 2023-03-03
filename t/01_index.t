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
    aroC_1 => "MjI1NzY4NTcxOTAwNjQ3NjU2NDA2NTYyODQwOTIxNzg2Mg==",
    aroC_2 => "MjI4MDUwMzQyOTgxMDU4NDY5MzI5MjU2OTA2NjkxOTUwMg==",
    aroC_3 => "MjI4NDMwNjM4MTYxMTI2OTM4MTQ5NzA1OTE3NjUzMzQ1OA==",
    aroC_4 => "MjI4ODEwOTMzMzQxMTk1NDA2OTcwMTU0OTI4NjE1MTUxOA==",
    aroC_5 => "MjI4MTc3MTA4MDQxMDgxMjkyMjY5NDA2NTc3MDEyMjkzOQ==",
    aroC_6 => "MjI4NDMwNjM4MTYxMTI2OTM4MTQ5NzA1OTE3NjUzNTc4MA==",
    aroC_7 => "MjI4MDUwMzQyOTgxMDU4NDY5MzI5MjU2OTA2NjkxNjgwMg==",
    aroC_8 => "MjI4NDMwNjM4MTYxMTI2OTM4MTQ5NzA1OTE3NjUzMzIxMg==",
    aroC_9 => "MjI4ODEwOTMzMzQxMTk1NDA2OTcwMTU0OTI4NjE0OTU5OA==",
    aroC_10 => "MjI4MDUwMzQyOTgxMDU4NDY5MzI5MjU2OTA2NjkxODE1Mg==",
    dnaN_1 => "MjQwOTgwMzc5MTAzMzg2NDA5MjI0NTIzMjc5Mzg5MjczNw==",
    dnaN_2 => "MjM5NDU5MTk4MzgzMTEyNTMzOTQyNzI3MjM1NTQyMTk5MQ==",
    dnaN_3 => "MjM5MDc4OTAzMjAzMDQ0MDY1MTIyMjc4MjI0NTgwNDIyNQ==",
    dnaN_4 => "MjM4Njk4NjA4MDIyOTc1NTk2MzAxODI5MjEzNjE4Njg2MQ==",
    dnaN_5 => "MjM4NDQ1MDc3OTAyOTI5OTUwNDIxNTI5ODcyOTc3NTc4MQ==",
    dnaN_6 => "MjM4MzE4MzEyODQyOTA3MTI3NDgxMzgwMjAyNjU3MDk3OQ==",
    dnaN_7 => "MjM4ODI1MzczMDgyOTk4NDE5MjQxOTc4ODgzOTM5MzcwNw==",
    dnaN_8 => "MjQxNzQwOTY5NDYzNTIzMzQ2ODY1NDIxMzAxMzEyMzEyNA==",
    dnaN_9 => "MjQwOTgwMzc5MTAzMzg2NDA5MjI0NTIzMjc5Mzg4Nzg1OQ==",
    dnaN_10 => "MjM3OTM4MDE3NjYyODM4NjU4NjYwOTMxMTkxNjk1NDQ1OA==",
    hemD_1 => "MjA0NzI1NTcxOTM2ODU5MDQ4MzQxNzE3NTY3NzAyOTM5NQ==",
    hemD_2 => "MjAzOTY0OTgxNTc2NzIyMTEwNzAwODE5NTQ1Nzc5NjM3MQ==",
    hemD_3 => "MjAyMzE3MDM1Nzk2NDI1NDEyNDc4ODczODMxNjEyNDEzMw==",
    hemD_4 => "MjAxOTM2NzQwNjE2MzU2OTQzNjU4NDI0ODIwNjUwNzQyNg==",
    hemD_5 => "MjAxOTM2NzQwNjE2MzU2OTQzNjU4NDI0ODIwNjUwNzI2MQ==",
    hemD_6 => "MjAzNDU3OTIxMzM2NjMwODE4OTQwMjIwODY0NDk3MDg2MQ==",
    hemD_7 => "MjAyMzE3MDM1Nzk2NDI1NDEyNDc4ODczODMxNjEyMzQwNA==",
    hemD_8 => "MjAyNjk3MzMwOTc2NDkzODgxMjk5MzIyODQyNTc0MDI3Ng==",
    hemD_9 => "MjAyNDQzODAwODU2NDQ4MjM1NDE5MDIzNTAxOTMyOTU3NQ==",
    hemD_10 => "MjAyMTkwMjcwNzM2NDAyNTg5NTM4NzI0MTYxMjkxNzU3Ng==",
    hisD_1 => "MjI5MzE3OTkzNTgxMjg2Njk4NzMwNzUzNjA5ODk3MDA2NQ==",
    hisD_2 => "MjI5MDY0NDYzNDYxMjQxMDUyODUwNDU0MjY5MjU1ODkxNQ==",
    hisD_3 => "MjMwMDc4NTgzOTQxNDIzNjM2MzcxNjUxNjMxODIwNDA3Mw==",
    hisD_4 => "MjMxNTk5NzY0NjYxNjk3NTExNjUzNDQ3Njc1NjY3MDc3NQ==",
    hisD_5 => "MjI5NDQ0NzU4NjQxMzA5NTIxNjcwOTAzMjgwMjE3MzU5OA==",
    hisD_6 => "MjI4OTM3Njk4NDAxMjE4MjI5OTEwMzA0NTk4OTM1MjA4Ng==",
    hisD_7 => "MjMwNDU4ODc5MTIxNDkyMTA1MTkyMTAwNjQyNzgyMDgzMw==",
    hisD_8 => "MjMwNTg1NjQ0MTgxNTE0OTI4MTMyMjUwMzEzMTAyNDkzNA==",
    hisD_9 => "MjI4OTM3Njk4NDAxMjE4MjI5OTEwMzA0NTk4OTM1MjUzMA==",
    hisD_10 => "MjI5ODI1MDUzODIxMzc3OTkwNDkxMzUyMjkxMTc5MzY3Nw==",
    purE_1 => "MTc4ODY1NDk5NjkyMjAzMTY4NTUxMTg0ODIyMzA2NDU5MA==",
    purE_2 => "MTc3NDcxMDg0MDMxOTUyMTE2MjA5NTM4NDQ4NzgwMDY4Mg==",
    purE_3 => "MTc1OTQ5OTAzMzExNjc4MjQwOTI3NzQyNDA0OTMzMTg0NA==",
    purE_4 => "MTc4NDg1MjA0NTEyMTM0Njk5NzMwNzM1ODExMzQ0NDIyMg==",
    purE_5 => "MTc4MTA0OTA5MzMyMDY2MjMwOTEwMjg2ODAwMzgyNzc4Mg==",
    purE_6 => "MTc4MTA0OTA5MzMyMDY2MjMwOTEwMjg2ODAwMzgyODkxNg==",
    purE_7 => "MTc4MjMxNjc0MzkyMDg5MDUzODUwNDM2NDcwNzAzNDQ4MA==",
    purE_8 => "MTc3MzQ0MzE4OTcxOTI5MjkzMjY5Mzg4Nzc4NDU5NTA0Ng==",
    purE_9 => "MTc5NjI2MDkwMDUyMzQwMTA2MTkyMDgyODQ0MjI5NDg3NA==",
    purE_10 => "MTc4NDg1MjA0NTEyMTM0Njk5NzMwNzM1ODExMzQ0NTA4MA==",
    sucA_1 => "MjMwOTY1OTM5MzYxNTgzMzk2OTUyNjk5MzI0MDY1MTc4Nw==",
    sucA_2 => "MjI3Nzk2ODEyODYxMDEyODIzNDQ4OTU3NTY2MDUwODU1Mg==",
    sucA_3 => "MjI5MzE3OTkzNTgxMjg2Njk4NzMwNzUzNjA5ODk3Nzk5MA==",
    sucA_4 => "MjI5NDQ0NzU4NjQxMzA5NTIxNjcwOTAzMjgwMjE4MzQwNQ==",
    sucA_5 => "MjMwMDc4NTgzOTQxNDIzNjM2MzcxNjUxNjMxODIwODgxNg==",
    sucA_6 => "MjI4NTU3NDAzMjIxMTQ5NzYxMDg5ODU1NTg3OTc0MzI5Mg==",
    sucA_7 => "MjI4NTU3NDAzMjIxMTQ5NzYxMDg5ODU1NTg3OTc0MzQ5MA==",
    sucA_8 => "MjI5ODI1MDUzODIxMzc3OTkwNDkxMzUyMjkxMTc5OTY2NA==",
    sucA_9 => "MjI3Nzk2ODEyODYxMDEyODIzNDQ4OTU3NTY2MDUxMDcxOA==",
    sucA_10 => "MjI4NTU3NDAzMjIxMTQ5NzYxMDg5ODU1NTg3OTc0MzQ1NA==",
    thrA_1 => "MjM3Njg0NDg3NTQyNzkzMDEyNzgwNjMxODUxMDU1MDU1Mg==",
    thrA_2 => "MjM4MTkxNTQ3NzgyODg0MzA0NTQxMjMwNTMyMzM3MzYzMA==",
    thrA_3 => "MjM2OTIzODk3MTgyNjU2MDc1MTM5NzMzODI5MTMxNjI3Nw==",
    thrA_4 => "MjM4MTkxNTQ3NzgyODg0MzA0NTQxMjMwNTMyMzM3MTg0OA==",
    thrA_5 => "MjM5MjA1NjY4MjYzMDY2ODg4MDYyNDI3ODk0OTAxNjMzNg==",
    thrA_6 => "MjM4MTkxNTQ3NzgyODg0MzA0NTQxMjMwNTMyMzM3MzM5MA==",
    thrA_7 => "MjM5MzMyNDMzMzIzMDg5NzExMDAyNTc3NTY1MjIyNDkwOQ==",
    thrA_8 => "MjM4NDQ1MDc3OTAyOTI5OTUwNDIxNTI5ODcyOTc4Mjk3MA==",
    thrA_9 => "MjM4ODI1MzczMDgyOTk4NDE5MjQxOTc4ODgzOTM5ODc1Mw==",
    thrA_10 => "MjM5NzEyNzI4NTAzMTU4MTc5ODIzMDI2NTc2MTg0MTI4MA==",
  );

  plan tests=>scalar(keys(%exp));

  for my $obs(@obs){
    my($allele, $int) = split(/\t/, $obs);
    next if(!$exp{$allele});

    is($int, $exp{$allele}, $allele);
  }
}

