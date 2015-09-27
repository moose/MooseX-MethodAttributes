package MooseX::MethodAttributes::Role::Meta::Role::Application::Summation;
# ABSTRACT: Role applied to the class responsible for role summation which ensures method attributes propagate from the roles being summed onto the combined role.

our $VERSION = '0.32';

use Moose::Role;
use Moose::Util qw/does_role/;
use namespace::autoclean;

with 'MooseX::MethodAttributes::Role::Meta::Role::Application';

sub _copy_attributes {
    my ($self, $thing) = @_;
    for my $role (@{ $self->get_roles }) {
        $role->_copy_attributes($thing)
            if does_role($role, 'MooseX::MethodAttributes::Role::Meta::Role');
    }
}

1;
