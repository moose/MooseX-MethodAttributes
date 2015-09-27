package MooseX::MethodAttributes::Role::Meta::Method::Wrapped;
# ABSTRACT: wrapped metamethod role allowing code attribute introspection

our $VERSION = '0.32';

use Moose::Role;

use namespace::autoclean;

=method attributes

Gets the list of code attributes of the original method this meta method wraps.

=cut

sub attributes {
    my ($self) = @_;
    return $self->get_original_method->attributes;
}

sub _get_attributed_coderef {
    my ($self) = @_;
    return $self->get_original_method->_get_attributed_coderef;
}

1;
