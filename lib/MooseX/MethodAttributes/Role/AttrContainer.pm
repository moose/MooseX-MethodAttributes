package MooseX::MethodAttributes::Role::AttrContainer;
# ABSTRACT: capture code attributes in the class' metaclass

our $VERSION = '0.32';

use Moose::Role;
use Moose::Util qw/find_meta/;

use namespace::autoclean;

=method MODIFY_CODE_ATTRIBUTES ($code, @attrs)

Accepts a list of attributes for a coderef and stores it the class' metaclass.

See L<attributes>.

=cut

sub MODIFY_CODE_ATTRIBUTES {
    my ($class, $code, @attrs) = @_;
    find_meta($class)->register_method_attributes($code, \@attrs);
    return ();
}

1;
