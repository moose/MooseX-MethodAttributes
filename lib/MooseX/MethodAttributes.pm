package MooseX::MethodAttributes;
# ABSTRACT: code attribute introspection

our $VERSION = '0.30';

use Moose ();
use Moose::Exporter;
use Moose::Util::MetaRole;
use Moose::Util qw/find_meta does_role/;
# Ensure trait is registered
use MooseX::MethodAttributes::Role::Meta::Role ();

=head1 SYNOPSIS

    package MyClass;

    use Moose;
    use MooseX::MethodAttributes;

    sub foo : Bar Baz('corge') { ... }

    my $attrs = MyClass->meta->get_method('foo')->attributes; # ["Bar", "Baz('corge')"]

=head1 DESCRIPTION

This module allows code attributes of methods to be introspected using Moose
meta method objects.

=begin Pod::Coverage

init_meta

=end Pod::Coverage

=cut

Moose::Exporter->setup_import_methods(
    also => 'Moose',
);

sub init_meta {
    my ($class, %options) = @_;

    my $for_class = $options{for_class};
    my $meta = find_meta($for_class);

    return $meta if $meta
        && does_role($meta, 'MooseX::MethodAttributes::Role::Meta::Class')
        && does_role($meta->method_metaclass, 'MooseX::MethodAttributes::Role::Meta::Method')
        && does_role($meta->wrapped_method_metaclass, 'MooseX::MethodAttributes::Role::Meta::Method::MaybeWrapped');

    $meta = Moose::Meta::Class->create( $for_class )
        unless $meta;

    $meta = Moose::Util::MetaRole::apply_metaroles(
        for             => $for_class,
        class_metaroles => {
            class  => ['MooseX::MethodAttributes::Role::Meta::Class'],
            method => ['MooseX::MethodAttributes::Role::Meta::Method'],
            wrapped_method => [
                'MooseX::MethodAttributes::Role::Meta::Method::MaybeWrapped'],
        },
    );

    Moose::Util::MetaRole::apply_base_class_roles(
        for_class => $for_class,
        roles     => ['MooseX::MethodAttributes::Role::AttrContainer'],
    );

    return $meta;
}

1;
