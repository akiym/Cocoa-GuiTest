use strict;
use warnings;
use utf8;
use Cocoa::GuiTest qw/:all/;
use Time::HiRes qw/sleep/;

my ($width, $height) = GetScreenRes();

my $x = $width / 2;
my $y = $height / 2;

print 'waiting... ';
for my $i (reverse 1..3) {
    local $| = 1;
    print $i;
    sleep 1;
}

print "\n";

MouseMoveAbsPix($x, $y);
sleep 0.05;
SendLButtonDown;

my $r = 2.5;
for my $t (0 .. 100) {
    $x += $r * $t * cos($t);
    $y += $r * $t * sin($t);

    Cocoa::GuiTest::SendLButtonDrag($x, $y);

    sleep 0.05;
}

SendLButtonUp;
