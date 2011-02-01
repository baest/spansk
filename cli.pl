#!/usr/bin/perl
use strict;
use warnings;
use feature ':5.10'; 
use Verbs;
use Data::Dump qw/pp/;
use List::MoreUtils qw/any/;
use Getopt::Long;
use Unicode::Normalize;

my %opt = (
	form  => 1
);

GetOptions(\%opt,
	'test',
	'print:s',
	'form!',
);

if ($opt{test}) {
	my ($correct, $incorrect) = (0, 0);
	while(1) {
		my $verb = get_random_verb();
		my ($form_id, $form, $form_danish) = get_random_form();
		print "$verb:\n";
		print "$form ($form_danish) ...? > ";
		$_ = readline;
		chomp;

		last unless $_;

		my $verb_form = verb_form($verb, $form_id);

		if ($_ eq $verb_form) {
			say "Korrekt!\n";
			++$correct;
		}
		elsif ($_ eq remove_accent($verb_form)) {
			say "Korrekt! ($verb_form)\n";
			++$correct;
		}
		else {
			say "Forkert, det rigtige svar er $verb_form!\n";
			++$incorrect;
		}
	}

	say "\nResultat: $correct korrekte og $incorrect forkerte svar!";
}

elsif (defined $opt{print}) {
	my @lverbs = @verbs;

	@lverbs = ($opt{print}) if ($opt{print} && any { $_ eq $opt{print} } @lverbs);

	foreach my $verb (@lverbs) {

		say $verb, ":\n";

		for my $cnt (0..5) {
			my $verb_form = verb_form($verb, $cnt);
			print [get_form($cnt)]->[0], ' ' if ($opt{form});
			#print $form[$cnt], ' ' if ($opt{form});
			say $verb_form;

			#say "$form[$cnt] ", remove_accent($verb_form);
		}

		say '';

		my $line = <STDIN> if @lverbs > 1;
		#exit if $verb eq 'vivir';
	}
}
