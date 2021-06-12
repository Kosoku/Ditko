//
//  KDIFunctions.h
//  Ditko
//
//  Created by William Towe on 3/8/17.
//  Copyright © 2021 Kosoku Interactive, LLC. All rights reserved.
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
