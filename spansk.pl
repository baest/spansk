#!/usr/bin/perl
use Mojolicious::Lite;
use File::Basename;

app->static->root(File::Basename::dirname(app->static->root) . '/static');


# /
get '/' => 'index';

app->start;

__DATA__

@@ index.html.ep
% layout 'index';
