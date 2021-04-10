#! /usr/bin/env perl
# title           :FPKM2TPM.pl
# description     :This code will process the FPKM matrix and generate TPM matrix.
# author          :c.s.sivasubramani
# date            :11042021
# version         :0.1
# usage           :perl FPKM2TPM.pl <input.txt> <output.txt>
# notes           :
# ==============================================================================

use strict;
use warnings;

my $FPKM_Matrix = $ARGV[0];
my $TPM_Martix = $ARGV[1];

my $usage = "perl FPKM2TPM.pl <input.txt> <output.txt>";

if($ARGV[1] eq ""){
	die $usage,"\n";
}

open(FA, $FPKM_Matrix);
open(OUT, ">$TPM_Martix");
while(<FA>){
	chomp();
	my @arr = split(/\s+/, $_);
	my @tpm = ();
	my $sum = 0;
	$tpm[0] = $arr[0];
	for (my $i=1;$i<=$#arr;$i++){
		$sum += $arr[$i];
	}
	for (my $i=1;$i<=$#arr;$i++){
		$tpm[$i] = ($arr[$i] / $sum) * 10^6
	}
	print OUT join("\t", @tpm),"\n";
}
close OUT;
close FA;
