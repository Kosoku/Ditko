//
//  KDIRolloverButton.h
//  Ditko
//
//  Created by William Towe on 4/5/17.
//  Copyright © 2018 Kosoku Interactive, LLC. All rights reserved.
//
//  Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
//
//  1. Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
//
//  2. Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
//
//  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

#import <AppKit/AppKit.h>

NS_ASSUME_NONNULL_BEGIN

/**
 Enum describing the possible rollover button states.
 */
typedef NS_ENUM(NSInteger, KDIRolloverButtonState) {
    /**
     Normal button state used when the button's window is main or key.
     */
    KDIRolloverButtonStateNormal,
    /**
     Pressed button state used when the button's window is main or key and the button is pressed.
     */
    KDIRolloverButtonStatePressed,
    /**
     Rollover button state used when the button's window is main or key and the user moves the mouse over the button.
     */
    KDIRolloverButtonStateRollover,
    /**
     Same as normal except the button's window is not main or key.
     */
    KDIRolloverButtonStateNormalInactive,
    /**
     Same as pressed except the button's window is not main or key.
     */
    KDIRolloverButtonStatePressedInactive,
    /**
     Same as rollover except the button's window is not main or key.
     */
    KDIRolloverButtonStateRolloverInactive
};

/**
 KDIRolloverButton is an NSButton subclass that supports rollover. Separate images can be set for all possible states.
 */
@interface KDIRolloverButton : NSButton

/**
 Set the provided image for the rollover state. Passing nil for image will clear the image for that state.
 
 @param image The image to set for state
 @param state The state for which to set image
 */
- (void)setImage:(nullable NSImage *)image forState:(KDIRolloverButtonState)state;

@end

NS_ASSUME_NONNULL_END
