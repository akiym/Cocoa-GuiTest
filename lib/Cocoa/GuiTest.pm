package Cocoa::GuiTest;
use strict;
use warnings;
use parent qw/Exporter/;
use Carp ();
use Time::HiRes;

our $VERSION = '0.01';

our @EXPORT_OK = qw/
    SendRawKey

    GetCursorPos
    SendLButtonUp
    SendLButtonDown
    SendMButtonUp
    SendMButtonDown
    SendRButtonUp
    SendRButtonDown
    MouseMoveAbsPix
    MouseMoveRelPix
    MouseMoveWheel
    GetScreenRes

    %VK_ANSI
    %VK_ASCII
    %VK_ASCII_SHIFT
    %VK_ASCII_OPTION
    %VK
    %EVENT_FLAG
/;

our %EXPORT_TAGS = (
    all => [@EXPORT_OK],
);

require XSLoader;
XSLoader::load(__PACKAGE__, $VERSION);

our %EVENT_FLAG = (
    ALPHA_SHIFT  => 0x00010000,
    SHIFT        => 0x00020000,
    CONTROL      => 0x00040000,
    ALTERNATE    => 0x00080000,
    COMMAND      => 0x00100000,
    HELP         => 0x00400000,
    SECONDARY_FN => 0x00800000,
    NUMERIC_PAD  => 0x00200000,
);

our %VK_ANSI = (
    A               => 0x00,
    S               => 0x01,
    D               => 0x02,
    F               => 0x03,
    H               => 0x04,
    G               => 0x05,
    Z               => 0x06,
    X               => 0x07,
    C               => 0x08,
    V               => 0x09,
    B               => 0x0B,
    Q               => 0x0C,
    W               => 0x0D,
    E               => 0x0E,
    R               => 0x0F,
    Y               => 0x10,
    T               => 0x11,
    '1'             => 0x12,
    '2'             => 0x13,
    '3'             => 0x14,
    '4'             => 0x15,
    '6'             => 0x16,
    '5'             => 0x17,
    EQUAL           => 0x18,
    '9'             => 0x19,
    '7'             => 0x1A,
    MINUS           => 0x1B,
    '8'             => 0x1C,
    '0'             => 0x1D,
    RIGHT_BRACKET   => 0x1E,
    O               => 0x1F,
    U               => 0x20,
    LEFT_BRACKET    => 0x21,
    I               => 0x22,
    P               => 0x23,
    L               => 0x25,
    J               => 0x26,
    QUOTE           => 0x27,
    K               => 0x28,
    SEMICOLON       => 0x29,
    BACKSLASH       => 0x2A,
    COMMA           => 0x2B,
    SLASH           => 0x2C,
    N               => 0x2D,
    M               => 0x2E,
    PERIOD          => 0x2F,
    GRAVE           => 0x32,
    KEYPAD_DECIMAL  => 0x41,
    KEYPAD_MULTIPLY => 0x43,
    KEYPAD_PLUS     => 0x45,
    KEYPAD_CLEAR    => 0x47,
    KEYPAD_DIVIDE   => 0x4B,
    KEYPAD_ENTER    => 0x4C,
    KEYPAD_MINUS    => 0x4E,
    KEYPAD_EQUALS   => 0x51,
    KEYPAD_0        => 0x52,
    KEYPAD_1        => 0x53,
    KEYPAD_2        => 0x54,
    KEYPAD_3        => 0x55,
    KEYPAD_4        => 0x56,
    KEYPAD_5        => 0x57,
    KEYPAD_6        => 0x58,
    KEYPAD_7        => 0x59,
    KEYPAD_8        => 0x5B,
    KEYPAD_9        => 0x5C,
);

our %VK = (
    RETURN         => 0x24,
    TAB            => 0x30,
    SPACE          => 0x31,
    DELETE         => 0x33,
    ESCAPE         => 0x35,
    COMMAND        => 0x37,
    SHIFT          => 0x38,
    CAPS_LOCK      => 0x39,
    OPTION         => 0x3A,
    CONTROL        => 0x3B,
    RIGHT_SHIFT    => 0x3C,
    RIGHT_OPTION   => 0x3D,
    RIGHT_CONTROL  => 0x3E,
    FUNCTION       => 0x3F,
    F17            => 0x40,
    VOLUME_UP      => 0x48,
    VOLUME_DOWN    => 0x49,
    MUTE           => 0x4A,
    F18            => 0x4F,
    F19            => 0x50,
    F20            => 0x5A,
    F5             => 0x60,
    F6             => 0x61,
    F7             => 0x62,
    F3             => 0x63,
    F8             => 0x64,
    F9             => 0x65,
    F11            => 0x67,
    F13            => 0x69,
    F16            => 0x6A,
    F14            => 0x6B,
    F10            => 0x6D,
    F12            => 0x6F,
    F15            => 0x71,
    HELP           => 0x72,
    HOME           => 0x73,
    PAGE_UP        => 0x74,
    FORWARD_DELETE => 0x75,
    F4             => 0x76,
    END            => 0x77,
    F2             => 0x78,
    PAGE_DOWN      => 0x79,
    F1             => 0x7A,
    LEFT_ARROW     => 0x7B,
    RIGHT_ARROW    => 0x7C,
    DOWN_ARROW     => 0x7D,
    UP_ARROW       => 0x7E,

    # JIS keyboards only
    JIS_YEN          => 0x5D,
    JIS_UNDERSCORE   => 0x5E,
    JIS_KEYPAD_COMMA => 0x5F,
    JIS_EISU         => 0x66,
    JIS_KANA         => 0x68,
);

# ASCII table
our %VK_ASCII = (
    a    => 0x00,
    b    => 0x0B,
    c    => 0x08,
    d    => 0x02,
    e    => 0x0E,
    f    => 0x03,
    g    => 0x05,
    h    => 0x04,
    i    => 0x22,
    j    => 0x26,
    k    => 0x28,
    l    => 0x25,
    m    => 0x2E,
    n    => 0x2D,
    o    => 0x1F,
    p    => 0x23,
    q    => 0x0C,
    r    => 0x0F,
    s    => 0x01,
    t    => 0x11,
    u    => 0x20,
    v    => 0x09,
    w    => 0x0D,
    x    => 0x07,
    y    => 0x10,
    z    => 0x06,
    '1'  => 0x12,
    '2'  => 0x13,
    '3'  => 0x14,
    '4'  => 0x15,
    '5'  => 0x17,
    '6'  => 0x16,
    '7'  => 0x1A,
    '8'  => 0x1C,
    '9'  => 0x19,
    '0'  => 0x1D,
    '='  => 0x18,
    '-'  => 0x1B,
    ']'  => 0x1E,
    '['  => 0x21,
    q{'} => 0x27,
    ';'  => 0x29,
    '\\' => 0x2A,
    ','  => 0x2B,
    '/'  => 0x2C,
    '.'  => 0x2F,
    '`'  => 0x32,

    ' '  => $VK{SPACE},
    "\n" => $VK{RETURN},

    # Shift
    A   => [0x00, $EVENT_FLAG{SHIFT}],
    B   => [0x0B, $EVENT_FLAG{SHIFT}],
    C   => [0x08, $EVENT_FLAG{SHIFT}],
    D   => [0x02, $EVENT_FLAG{SHIFT}],
    E   => [0x0E, $EVENT_FLAG{SHIFT}],
    F   => [0x03, $EVENT_FLAG{SHIFT}],
    G   => [0x05, $EVENT_FLAG{SHIFT}],
    H   => [0x04, $EVENT_FLAG{SHIFT}],
    I   => [0x22, $EVENT_FLAG{SHIFT}],
    J   => [0x26, $EVENT_FLAG{SHIFT}],
    K   => [0x28, $EVENT_FLAG{SHIFT}],
    L   => [0x25, $EVENT_FLAG{SHIFT}],
    M   => [0x2E, $EVENT_FLAG{SHIFT}],
    N   => [0x2D, $EVENT_FLAG{SHIFT}],
    O   => [0x1F, $EVENT_FLAG{SHIFT}],
    P   => [0x23, $EVENT_FLAG{SHIFT}],
    Q   => [0x0C, $EVENT_FLAG{SHIFT}],
    R   => [0x0F, $EVENT_FLAG{SHIFT}],
    S   => [0x01, $EVENT_FLAG{SHIFT}],
    T   => [0x11, $EVENT_FLAG{SHIFT}],
    U   => [0x20, $EVENT_FLAG{SHIFT}],
    V   => [0x09, $EVENT_FLAG{SHIFT}],
    W   => [0x0D, $EVENT_FLAG{SHIFT}],
    X   => [0x07, $EVENT_FLAG{SHIFT}],
    Y   => [0x10, $EVENT_FLAG{SHIFT}],
    Z   => [0x06, $EVENT_FLAG{SHIFT}],
    '~' => [$VK_ANSI{GRAVE}, $EVENT_FLAG{SHIFT}],
    '!' => [$VK_ANSI{'1'}, $EVENT_FLAG{SHIFT}],
    '@' => [$VK_ANSI{'2'}, $EVENT_FLAG{SHIFT}],
    '#' => [$VK_ANSI{'3'}, $EVENT_FLAG{SHIFT}],
    '$' => [$VK_ANSI{'4'}, $EVENT_FLAG{SHIFT}],
    '%' => [$VK_ANSI{'5'}, $EVENT_FLAG{SHIFT}],
    '^' => [$VK_ANSI{'6'}, $EVENT_FLAG{SHIFT}],
    '&' => [$VK_ANSI{'7'}, $EVENT_FLAG{SHIFT}],
    '*' => [$VK_ANSI{'8'}, $EVENT_FLAG{SHIFT}],
    '(' => [$VK_ANSI{'9'}, $EVENT_FLAG{SHIFT}],
    ')' => [$VK_ANSI{'0'}, $EVENT_FLAG{SHIFT}],
    '_' => [$VK_ANSI{MINUS}, $EVENT_FLAG{SHIFT}],
    '+' => [$VK{EQUAL}, $EVENT_FLAG{SHIFT}],
    '{' => [$VK_ANSI{LEFT_BRACKET}, $EVENT_FLAG{SHIFT}],
    '}' => [$VK_ANSI{RIGHT_BRACKET}, $EVENT_FLAG{SHIFT}],
    '|' => [$VK_ANSI{BACKSLASH}, $EVENT_FLAG{SHIFT}],
    ':' => [$VK_ANSI{SEMICOLON}, $EVENT_FLAG{SHIFT}],
    '"' => [$VK_ANSI{QUOTE}, $EVENT_FLAG{SHIFT}],
    '<' => [$VK_ANSI{COMMA}, $EVENT_FLAG{SHIFT}],
    '>' => [$VK_ANSI{PERIOD}, $EVENT_FLAG{SHIFT}],
    '?' => [$VK_ANSI{SLASH}, $EVENT_FLAG{SHIFT}],
);

# compatibility for Win32::GuiTest
my %VK_GUITEST = (
    BAC => $VK{DELETE},
    BS  => $VK{DELETE},
    BKS => $VK{DELETE},
    #BRE => $VK{CANCEL},
    CAP => $VK{CAPS_LOCK},
    DEL => $VK{FORWARD_DELETE},
    DOW => $VK{DOWN_ARROW},
    END => $VK{END},
    ENT => $VK{RETURN},
    ESC => $VK{ESCAPE},
    HEL => $VK{HELP},
    HOM => $VK{HOME},
    #INS => $VK{INSERT},
    LEF => $VK{LEFT_ARROW},
    #NUM => $VK{NUMLOCK},
    #PGD => $VK{NEXT},
    #PGU => $VK{PRIOR},
    #PRT => $VK{SNAPSHOT},
    RIG => $VK{RIGHT_ARROW},
    #SCR => $VK{SCROLL},
    TAB => $VK{TAB},
    UP  => $VK{UP_ARROW},
    F1  => $VK{F1},
    F2  => $VK{F2},
    F3  => $VK{F3},
    F4  => $VK{F4},
    F5  => $VK{F5},
    F6  => $VK{F6},
    F7  => $VK{F7},
    F8  => $VK{F8},
    F9  => $VK{F9},
    F10 => $VK{F10},
    F11 => $VK{F11},
    F12 => $VK{F12},
    F13 => $VK{F13},
    F14 => $VK{F14},
    F15 => $VK{F15},
    F16 => $VK{F16},
    F17 => $VK{F17},
    F18 => $VK{F18},
    F19 => $VK{F19},
    F20 => $VK{F20},
    #F21 => $VK{F21},
    #F22 => $VK{F22},
    #F23 => $VK{F23},
    #F24 => $VK{F24},
    SPC => $VK{SPACE},
    SPA => $VK{SPACE},
    #LWI => $VK{LWIN},
    #RWI => $VK{RWIN},
    #APP => $VK{APPS},
);

sub MouseMoveRelPix {
    my ($x, $y) = @_;
    my ($cursor_x, $cursor_y) = Cocoa::GuiTest::GetCursorPos();
    Cocoa::GuiTest::MouseMoveAbsPix($cursor_x + $x, $cursor_y + $y);
}

sub MouseMoveClick {
    my ($x, $y) = @_;
    Cocoa::GuiTest::MouseMoveAbsPix($x, $y);
    Cocoa::GuiTest::SendLButtonUp();
    sleep 0.5;
    Cocoa::GuiTest::SendLButtonDown();
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

=head2 SendLButtonUp()

=head2 SendLButtonDown()

=head2 SendMButtonUp()

=head2 SendMButtonDown()

=head2 SendRButtonUp()

=head2 SendRButtonDown()

=head2 MouseMoveAbsPix($x, $y)

=head2 MouseMoveRelPix($x, $y)

=head2 GetCursorPos()

=head2 GetScreenRes()

=head1 AUTHOR

Takumi Akiyama E<lt>t.akiym at gmail.comE<gt>

=head1 SEE ALSO

L<Win32::GuiTest>

=head1 LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
