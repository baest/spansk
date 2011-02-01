#!/usr/bin/perl
use Mojolicious::Lite;
use File::Basename;
use Verbs;

app->static->root(File::Basename::dirname(app->static->root) . '/static');


# /
get '/' => 'index';

get '/json' => sub {
	my $self = shift;

	my $params = $self->req->params->to_hash;
	my $verb_form = verb_form($params->{verb}, $params->{form_id});
	my $data;

	if ($params->{guess} eq $verb_form) {
		$data = { msg => 'Korrekt!' };
	}
	elsif ($params->{guess} eq remove_accent($verb_form)) {
		$data = { msg => "Korrekt! ($verb_form)" };
	}
	else {
		$data = { msg => "Forkert, det rigtige svar er $verb_form!" };
	}
	$self->render(json => $data );
	return;
} => 'json';

get '/game' => sub {
	my $self = shift;
	my $verb = get_random_verb();
	my ($form_id, $form, $form_danish) = get_random_form();

	$self->stash(
		verb        => get_random_verb(),
		form_id     => $form_id,
		form        => $form,
		form_danish => $form_danish,
	);
} => 'game';

app->start;

__DATA__

@@ index.html.ep
% layout 'index';

@@ game.html.ep
% layout 'game';
