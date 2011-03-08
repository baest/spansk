package Verbs;

use strict;
use warnings;
use base 'Exporter';
use IrregularVerbs;
use List::MoreUtils qw/none/;
use POSIX;

our @EXPORT = qw/@verbs verb_form remove_accent get_form get_random_form get_random_verb/;
my @form = qw(yo t˙ el/ella nosotros vosotros ellos/ellas);
my @form_danish = qw(jeg du han/hun vi i de);

#http://users.ipfw.edu/jehle/VERBLIST.HTm

our @verbs = qw/jugar llamo caer dar salir venir estudiar cantar usar conocer decir saber ver ser beber tocar oir poner/;
#@verbs = qw/costar jugar estar llamar poder caer dar salir venir estudiar cantar usar conocer decir saber ver ser tener beber tocar oir hacer poner/;
@verbs = qw/hablar llamar comer vivir costar ir seguir pasear querer ser traer poder hacer andar tener estar comprar viajar cerrar/;

my %endings = (
	ar => [ qw/o as a amos ·is an/ ],
	er => [ qw/o es e emos Èis en/ ],
	ir => [ qw/o es e imos Ìs en/ ],
);

sub verb_form {
	my ($verb, $form_id) = @_;
	my $base = substr($verb, 0, -2);
	my $end = substr($verb, -2);
	my $cnt = 0;

	if (exists $replace{$verb}) {
		my ($exceptions, $replace, $iverb) = @{$replace{$verb}};

		my $x = "$base$endings{$end}[$form_id]";
		my $num = $form_id+1;

		if ($iverb && exists $iverb->{$num}) {
			$x = $iverb->{$num} 
		}
		elsif ($exceptions && none { $num == $_ } @$exceptions) {
			eval "\$x =~ $replace";
		}

		return $x;
	}

	elsif (exists $iverbs{$verb}) {
		return $iverbs{$verb}[$form_id];
	}

	elsif (exists $endings{$end}) {
		return "$base$endings{$end}[$form_id]";
	}
}

sub remove_accent {
	my ($verb) = @_;
	$verb =~ tr/·ÈÌ/aei/;
	return $verb;
}

sub get_form {
	my ($form_id) = @_;

	my $form = $form[$form_id];
	my $form_danish = $form_danish[$form_id];

	return ($form, $form_danish);
}

sub get_random_form {
	my $form_id = floor(rand(scalar(@form)));
	return ($form_id, get_form($form_id));
}

sub get_random_verb {
	return $verbs[floor(rand(scalar(@verbs)))];
}

1;
