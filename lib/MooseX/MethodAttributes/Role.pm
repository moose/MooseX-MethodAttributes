package MooseX::MethodAttributes::Role;
# ABSTRACT: code attribute introspection

our $VERSION = '0.31';

use Moose ();
use Moose::Exporter;
use Moose::Util::MetaRole;
use Moose::Util qw/find_meta does_role ensure_all_roles/;
# Ensure trait is registered
use MooseX::MethodAttributes::Role::Meta::Role ();
use namespace::autoclean;

=head1 SYNOPSIS

    package MyRole;
    use MooseX::MethodAttributes::Role;

    sub foo : Bar Baz('corge') { ... }

    my $attrs = MyRole->meta->get_method('foo')->attributes; # ["Bar", "Baz('corge')"]

=head1 DESCRIPTION

This module allows you to write a Moose Role with code attributes of methods to
be introspected using Moose meta method objects.

=begin Pod::Coverage

init_meta

=end Pod::Coverage

=cut

Moose::Exporter->setup_import_methods( also => 'Moose::Role' );

sub init_meta {
    my ($class, %options) = @_;

    my $for_class = $options{for_class};
    my $meta = find_meta($for_class);

    return $meta if $meta
        && does_role($meta, 'MooseX::MethodAttributes::Role::Meta::Role');

    $meta = Moose::Meta::Role->create( $for_class )
        unless $meta;

    $meta = Moose::Util::MetaRole::apply_metaroles(
        for            => $meta->name,
        role_metaroles => {
            role => ['MooseX::MethodAttributes::Role::Meta::Role'],
        },
    );

    ensure_all_roles($meta->name,
        'MooseX::MethodAttributes::Role::AttrContainer',
    );

    return $meta;
}

1;
