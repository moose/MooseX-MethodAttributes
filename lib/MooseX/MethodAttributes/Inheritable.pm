package MooseX::MethodAttributes::Inheritable;
# ABSTRACT: inheritable code attribute introspection

our $VERSION = '0.33';

=head1 SYNOPSIS

    package BaseClass;
    use base qw/MooseX::MethodAttributes::Inheritable/;

    package SubClass;
    use base qw/BaseClass/;

    sub foo : Bar {}

    my $attrs = SubClass->meta->get_method('foo')->attributes; # ["Bar"]

=head1 DESCRIPTION

This module does the same as C<MooseX::MethodAttributes>, except that classes
inheriting from other classes using it don't need to do anything special to get
their code attributes captured.

Note that instead of inheriting from this module, you can instead simply
compose (C<with>) the L<MooseX::MethodAttributes::Role::AttrContainer::Inheritable> role.

=cut

# Ensure trait is registered
use MooseX::MethodAttributes::Role::Meta::Role ();

use Moose;

use namespace::autoclean;

with 'MooseX::MethodAttributes::Role::AttrContainer::Inheritable';

__PACKAGE__->meta->make_immutable;
1;

