//
//  KDIFunctions.h
//  Ditko
//
//  Created by William Towe on 3/8/17.
//  Copyright © 2018 Kosoku Interactive, LLC. All rights reserved.
//
//  Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
//
//  1. Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
//
//  2. Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
//
//  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

#import <TargetConditionals.h>

#if (TARGET_OS_WATCH)
#import <WatchKit/WatchKit.h>
#elif (TARGET_OS_IOS || TARGET_OS_TV)
#import <UIKit/UIKit.h>
#else
#import <AppKit/AppKit.h>
#endif

NS_ASSUME_NONNULL_BEGIN

/**
 Returns the scale of the main screen for the current platform. This calls through to KDIScreenScale(), passing nil.
 
 @return The scale of the main screen
 */
FOUNDATION_EXTERN CGFloat KDIMainScreenScale(void);
/**
 Returns the scale of the provided *screen*, defaults to the main screen if nil is passed.
 
 @param screen The screen for which to return the scale
 @return The screen scale
 */
#if (TARGET_OS_WATCH)
FOUNDATION_EXTERN CGFloat KDIScreenScale(WKInterfaceDevice * _Nullable screen);
#elif (TARGET_OS_IOS || TARGET_OS_TV)
FOUNDATION_EXTERN CGFloat KDIScreenScale(UIScreen * _Nullable screen);
#else
FOUNDATION_EXTERN CGFloat KDIScreenScale(NSScreen * _Nullable screen);
#endif

/**
 Returns a new size after multiplying the width and height by the main screen scale.
 
 @param size The size to adjust
 @return The new size
 */
FOUNDATION_EXTERN CGSize KDICGSizeAdjustedForMainScreenScale(CGSize size);
/**
 Returns a new size after multiplying the width and height by the screen scale.
 
 @param size The size to adjust
 @param screen The screen to adjust for, passing nil will use [UIScreen mainScreen] or [NSScreen mainScreen]
 @return The new size
 */
#if (TARGET_OS_WATCH)
FOUNDATION_EXTERN CGSize KDICGSizeAdjustedForScreenScale(CGSize size, WKInterfaceDevice * _Nullable screen);
#elif (TARGET_OS_IOS || TARGET_OS_TV)
FOUNDATION_EXTERN CGSize KDICGSizeAdjustedForScreenScale(CGSize size, UIScreen * _Nullable screen);
#else
FOUNDATION_EXTERN CGSize KDICGSizeAdjustedForScreenScale(CGSize size, NSScreen * _Nullable screen);
#endif

#if (TARGET_OS_IOS || TARGET_OS_TV)
/**
 Returns the text from the text input.
 
 @param textInput The text input object
 @return The text
 */
FOUNDATION_EXTERN NSString* _Nullable KDITextFromTextInput(id<UITextInput> textInput);
/**
 Returns the selected range from the text input.
 
 @param textInput The text input object
 @return The selected range
 */
FOUNDATION_EXTERN NSRange KDISelectedRangeFromTextInput(id<UITextInput> textInput);
/**
 Returns the text range from text input range.
 
 @param textInput The text input object
 @param range The range
 @return The text range
 */
FOUNDATION_EXTERN UITextRange* KDITextRangeFromTextInputRange(id<UITextInput> textInput, NSRange range);
#endif

NS_ASSUME_NONNULL_END
