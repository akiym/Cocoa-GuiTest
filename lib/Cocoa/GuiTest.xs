#define PERL_NO_GET_CONTEXT /* we want efficiency */
#include <EXTERN.h>
#include <perl.h>
#include <XSUB.h>

#define NEED_newSVpvn_flags
#include "ppport.h"

// undefine Move macro, this is conflict to Mac OS X QuickDraw API.
#undef Move

#import <Foundation/Foundation.h>
#import <ApplicationServices/ApplicationServices.h>

void simple_mouse(CGEventType mouse_type, CGPoint location, CGMouseButton mouse_button) {
    CGEventRef event;

    event = CGEventCreateMouseEvent(NULL, mouse_type, location, mouse_button);
    CGEventPost(kCGSessionEventTap, event);
    CFRelease(event);
}

void simple_wheel(CGScrollEventUnit units, CGWheelCount wheelCount, int32_t change) {
    CGEventRef event;

    event = CGEventCreateScrollWheelEvent(NULL, units, wheelCount, change);
    CGEventPost(kCGSessionEventTap, event);
    CFRelease(event);
}

MODULE = Cocoa::GuiTest    PACKAGE = Cocoa::GuiTest

PROTOTYPES: DISABLE

void
SendRawKey(SV* sv_keycode, SV* sv_flag)
CODE:
{
    CGEventRef event;

    event = CGEventCreateKeyboardEvent(NULL, (CGKeyCode)SvIV(sv_keycode), true);
    CGEventSetFlags(event, (CGEventFlags)SvIV(sv_flag));
    CGEventPost(kCGSessionEventTap, event);
    CFRelease(event);
}

void
GetCursorPos()
PPCODE:
{
    CGPoint location;

    location = CGEventGetLocation(CGEventCreate(NULL));
    XPUSHs(sv_2mortal(newSVnv(location.x)));
    XPUSHs(sv_2mortal(newSVnv(location.y)));
}

void
SendLButtonUp()
CODE:
{
    CGPoint location;

    location = CGEventGetLocation(CGEventCreate(NULL));
    simple_mouse(kCGEventLeftMouseUp, location, kCGMouseButtonLeft);
}

void
SendLButtonDown()
CODE:
{
    CGPoint location;

    location = CGEventGetLocation(CGEventCreate(NULL));
    simple_mouse(kCGEventLeftMouseDown, location, kCGMouseButtonLeft);
}

void
SendMButtonUp()
CODE:
{
    CGPoint location;

    location = CGEventGetLocation(CGEventCreate(NULL));
    simple_mouse(kCGEventOtherMouseUp, location, kCGMouseButtonCenter);
}

void
SendMButtonDown()
CODE:
{
    CGPoint location;

    location = CGEventGetLocation(CGEventCreate(NULL));
    simple_mouse(kCGEventOtherMouseDown, location, kCGMouseButtonCenter);
}

void
SendRButtonUp()
CODE:
{
    CGPoint location;

    location = CGEventGetLocation(CGEventCreate(NULL));
    simple_mouse(kCGEventRightMouseUp, location, kCGMouseButtonRight);
}

void
SendRButtonDown()
CODE:
{
    CGPoint location;

    location = CGEventGetLocation(CGEventCreate(NULL));
    simple_mouse(kCGEventRightMouseDown, location, kCGMouseButtonRight);
}

void
SendLButtonDrag(SV* sv_x, SV* sv_y)
CODE:
{
    CGPoint location;

    location = CGPointMake(SvNV(sv_x), SvNV(sv_y));
    simple_mouse(kCGEventLeftMouseDragged, location, kCGMouseButtonLeft);
}

void
MouseMoveAbsPix(SV* sv_x, SV* sv_y)
CODE:
{
    CGPoint location;

    location = CGPointMake(SvNV(sv_x), SvNV(sv_y));
    simple_mouse(kCGEventMouseMoved, location, kCGMouseButtonLeft);
}

void
MouseMoveWheel(SV* change)
CODE:
{
    // 1 for Y-only, 2 for Y-X, 3 for Y-X-Z
    simple_wheel(kCGScrollEventUnitLine, 1, SvNV(change));
}

void
GetScreenRes()
PPCODE:
{
    XPUSHs(sv_2mortal(newSViv(CGDisplayPixelsWide(kCGDirectMainDisplay))));
    XPUSHs(sv_2mortal(newSViv(CGDisplayPixelsHigh(kCGDirectMainDisplay))));
}
