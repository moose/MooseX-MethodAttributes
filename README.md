# NAME

MooseX::MethodAttributes - code attribute introspection

# VERSION

version 0.29

# SYNOPSIS

    package MyClass;

    use Moose;
    use MooseX::MethodAttributes;

    sub foo : Bar Baz('corge') { ... }

    my $attrs = MyClass->meta->get_method('foo')->attributes; # ["Bar", "Baz('corge')"]

# DESCRIPTION

This module allows code attributes of methods to be introspected using Moose
meta method objects.

# AUTHORS

- Florian Ragwitz <rafl@debian.org>
- Tomas Doran <bobtfish@bobtfish.net>

# COPYRIGHT AND LICENSE

This software is copyright (c) 2009 by Florian Ragwitz.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

# CONTRIBUTORS

- Dave Rolsky <autarch@urth.org>
- David Steinbrunner <dsteinbrunner@pobox.com>
- Karen Etheridge <ether@cpan.org>
- Marcus Ramberg <marcus@nordaaker.com>
- Peter E Karman <pek@dewpoint.msi.umn.edu>
- Tomas Doran (t0m) <bobtfish@bobtfish.net>
