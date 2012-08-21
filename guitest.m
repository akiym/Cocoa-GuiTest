#include "EXTERN.h"
#include "perl.h"
#include "XSUB.h"
#include "ppport.h"

// undefine Move macro, this is conflict to Mac OS X QuickDraw API.
#undef Move

#import <Foundation/Foundation.h>
#import <ApplicationServices/ApplicationServices.h>

void simple_mouse(CGEventType mouse_type, CGPoint location, CGMouseButton mouse_button) {
    CGEventRef event;

    event = CGEventCreateMouseEvent(NULL, mouse_type, location, mouse_button);
    CGEventPost(kCGHIDEventTap, event);
    CFRelease(event);
}

XS(Cocoa__GuiTest__GetCursorPos) {
    dXSARGS;
    CGPoint location;

    location = CGEventGetLocation(CGEventCreate(NULL));

    ST(0) = sv_2mortal(newSVnv(location.x));
    ST(1) = sv_2mortal(newSVnv(location.y));

    XSRETURN(2);
}

XS(Cocoa__GuiTest__SendLButtonUp) {
    dXSARGS;
    CGPoint location;

    location = CGEventGetLocation(CGEventCreate(NULL));
    simple_mouse(kCGEventLeftMouseUp, location, kCGMouseButtonLeft);

    XSRETURN(0);
}

XS(Cocoa__GuiTest__SendLButtonDown) {
    dXSARGS;
    CGPoint location;

    location = CGEventGetLocation(CGEventCreate(NULL));
    simple_mouse(kCGEventLeftMouseDown, location, kCGMouseButtonLeft);

    XSRETURN(0);
}

XS(Cocoa__GuiTest__SendMButtonUp) {
    dXSARGS;
    CGPoint location;

    location = CGEventGetLocation(CGEventCreate(NULL));
    simple_mouse(kCGEventOtherMouseUp, location, kCGMouseButtonCenter);

    XSRETURN(0);
}

XS(Cocoa__GuiTest__SendMButtonDown) {
    dXSARGS;
    CGPoint location;

    location = CGEventGetLocation(CGEventCreate(NULL));
    simple_mouse(kCGEventOtherMouseDown, location, kCGMouseButtonCenter);

    XSRETURN(0);
}

XS(Cocoa__GuiTest__SendRButtonUp) {
    dXSARGS;
    CGPoint location;

    location = CGEventGetLocation(CGEventCreate(NULL));
    simple_mouse(kCGEventRightMouseUp, location, kCGMouseButtonRight);

    XSRETURN(0);
}

XS(Cocoa__GuiTest__SendRButtonDown) {
    dXSARGS;
    CGPoint location;

    location = CGEventGetLocation(CGEventCreate(NULL));
    simple_mouse(kCGEventRightMouseDown, location, kCGMouseButtonRight);

    XSRETURN(0);
}

XS(Cocoa__GuiTest__MouseMoveAbsPix) {
    dXSARGS;
    SV* sv_x;
    SV* sv_y;
    CGEventRef event;

    if (items < 2) {
        Perl_croak(aTHX_ "Usage: Cocoa::GuiTest::MouseMoveAbsPix($x, $y)");
    }

    sv_x = ST(0);
    sv_y = ST(1);

    simple_mouse(kCGEventMouseMoved, CGPointMake(SvNV(sv_x), SvNV(sv_y)), kCGMouseButtonLeft);

    XSRETURN(0);
}

XS(Cocoa__GuiTest__GetScreenRes) {
    dXSARGS;
    size_t width, height;

    width = CGDisplayPixelsWide(kCGDirectMainDisplay);
    height = CGDisplayPixelsHigh(kCGDirectMainDisplay);

    ST(0) = sv_2mortal(newSViv(width));
    ST(1) = sv_2mortal(newSViv(height));

    XSRETURN(2);
}

XS(boot_Cocoa__GuiTest) {
    newXS("Cocoa::GuiTest::GetCursorPos", Cocoa__GuiTest__GetCursorPos, __FILE__);
    newXS("Cocoa::GuiTest::SendLButtonUp", Cocoa__GuiTest__SendLButtonUp, __FILE__);
    newXS("Cocoa::GuiTest::SendLButtonDown", Cocoa__GuiTest__SendLButtonDown, __FILE__);
    newXS("Cocoa::GuiTest::SendMButtonUp", Cocoa__GuiTest__SendMButtonUp, __FILE__);
    newXS("Cocoa::GuiTest::SendMButtonDown", Cocoa__GuiTest__SendMButtonDown, __FILE__);
    newXS("Cocoa::GuiTest::SendRButtonUp", Cocoa__GuiTest__SendRButtonUp, __FILE__);
    newXS("Cocoa::GuiTest::SendRButtonDown", Cocoa__GuiTest__SendRButtonDown, __FILE__);
    newXS("Cocoa::GuiTest::MouseMoveAbsPix", Cocoa__GuiTest__MouseMoveAbsPix, __FILE__);
    newXS("Cocoa::GuiTest::GetScreenRes", Cocoa__GuiTest__GetScreenRes, __FILE__);
}
