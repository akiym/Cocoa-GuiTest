package Cocoa::GuiTest;
use strict;
use warnings;
use parent qw/Exporter/;
our $VERSION = '0.01';

our @EXPORT_OK = qw/
    GetCursorPos
    SendLButtonUp
    SendLButtonDown
    SendMButtonUp
    SendMButtonDown
    SendRButtonUp
    SendRButtonDown
    MouseMoveAbsPix
    MouseMoveRelPix
    GetScreenRes
/;

our %EXPORT_TAGS = (
    ALL => [@EXPORT_OK],
);

require XSLoader;
XSLoader::load(__PACKAGE__, $VERSION);

sub MouseMoveRelPix {
    my ($x, $y) = @_;
    my ($cursor_x, $cursor_y) = Cocoa::GuiTest::GetCursorPos();
    Cocoa::GuiTest::MouseMoveAbsPix($cursor_x + $x, $cursor_y + $y);
}

1;
__END__

=head1 NAME

Cocoa::GuiTest - GUI test utilities for Mac

=head1 SYNOPSIS

  use Cocoa::GuiTest;

=head1 DESCRIPTION

Cocoa::GuiTest is

=head1 FUNCTIONS

=over 4

=item SendLButtonUp()

=item SendLButtonDown()

=item SendMButtonUp()

=item SendMButtonDown()

=item SendRButtonUp()

=item SendRButtonDown()

=item MouseMoveAbsPix($x, $y)

=item MouseMoveRelPix($x, $y)

=item GetCursorPos()

=item GetScreenRes()

=back

=head1 AUTHOR

Takumi Akiyama E<lt>t.akiym at gmail.comE<gt>

=head1 SEE ALSO

L<Win32::GuiTest>

=head1 LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
