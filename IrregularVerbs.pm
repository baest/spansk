package IrregularVerbs;

use strict;
use warnings;
use base 'Exporter';

our @EXPORT = qw/%iverbs %replace/;

our %iverbs = (
	ir      => [qw/voy vas va vamos vais van/],
	ser     => [qw/soy eres es somos sois son/],
);

# replace is the places NOT to replace
our %replace = (
	costar => [ [4,5], 's/o/ue/' ],
	seguir  => [ [4,5], 's/e/i/', { 1 => 'sigo' }],
	querer => [ [4,5,6], 's/ue/uie/'],
	traer   => [ undef, undef, { 1 => 'traigo' }],
	hacer => [ undef, undef, { 1 => 'hago' }],
	tener => [ [1,4,5], 's/e/ie/', { 1 => 'tengo' }],
	poder => [ [4,5], 's/o/ue/'],
	estar => [ [4], 's/a/á/', { 1 => 'estoy' } ],
	cerrar => [ [4,5], 's/e/ie/' ],
);

"hablo";
