use strict;
use warnings;
use utf8;
use Cocoa::GuiTest qw/:all/;
use Time::HiRes qw/sleep/;

system 'open -a TextEdit';
sleep 1;
SendRawKey($VK_ASCII{n}, $EVENT_FLAG{COMMAND});
sleep 1;

SendKeys(<<'...');
    This is a test message,
    but also a little demo for the
    SendKeys function.
    3, 2, 1, 0...
    Closing TextEdit.......... by yourself :)
...

SendRawKey($VK_ASCII{w}, $EVENT_FLAG{COMMAND});

sub SendKeys {
    my ($text, $delay) = @_;
    $delay //= 0.05;

    for my $char (split //, $text) {
        my $keycode = $VK_ASCII{$char};
        if (not defined $keycode) {
            die "ascii only";
        } elsif (ref $keycode eq 'ARRAY') {
            SendRawKey(@$keycode);
        } else {
            SendRawKey($keycode, 0);
        }
        sleep $delay;
    }
}
