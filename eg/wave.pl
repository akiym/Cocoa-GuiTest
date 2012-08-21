use 5.016;
use warnings FATAL => 'all';
use utf8;
use Cocoa::GuiTest;
use Time::HiRes qw/sleep/;

my ($width, $height) = Cocoa::GuiTest::GetScreenRes();

my $hz = 10;
my $omega = 2.0 * 3.14 * $hz;

for my $x (0 .. $width) {
    my $y = 141 * sin($omega * $x);
    $y += $height / 2;

    Cocoa::GuiTest::MouseMoveAbsPix($x, $y);

    sleep 0.005;
}
