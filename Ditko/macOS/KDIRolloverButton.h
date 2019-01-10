//
//  KDIRolloverButton.h
//  Ditko
//
//  Created by William Towe on 4/5/17.
//  Copyright © 2019 Kosoku Interactive, LLC. All rights reserved.
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//  http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.

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
