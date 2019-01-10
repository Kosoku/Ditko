//
//  NSTextField+KDIExtensions.h
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

@interface NSTextField (KDIExtensions)

/**
 Set and get the background style of the receiver. Calls through to the relevant cell methods.
 */
@property (assign,nonatomic) NSBackgroundStyle KDI_backgroundStyle;

/**
 Returns `[self KDI_labelWithText:text font:nil alignment:0 lineBreakMode:0]`.
 
 @param text The text of the label
 @return The initialized receiver
 */
+ (instancetype)KDI_labelWithText:(NSString *)text;
/**
 Returns `[self KDI_labelWithText:text font:font alignment:0 lineBreakMode:0]`.
 
 @param text The text of the label
 @param font The font of the label
 @return The initialized receiver
 */
+ (instancetype)KDI_labelWithText:(NSString *)text font:(nullable NSFont *)font;
/**
 Returns `[self KDI_labelWithText:text font:font alignment:alignment lineBreakMode:0]`.
 
 @param text The text of the label
 @param font The font of the label
 @param alignment The alignment of the label
 @return The initialized receiver
 */
+ (instancetype)KDI_labelWithText:(NSString *)text font:(nullable NSFont *)font alignment:(NSTextAlignment)alignment;
/**
 Creates and returns an instance of the receiver and sets the relevant properties on it and its cell.
 
 @param text The text of the label
 @param font The font of the label
 @param alignment The alignment of the label
 @param lineBreakMode The line break mode of the label
 @return The initialized receiver
 */
+ (instancetype)KDI_labelWithText:(NSString *)text font:(nullable NSFont *)font alignment:(NSTextAlignment)alignment lineBreakMode:(NSLineBreakMode)lineBreakMode;

@end

NS_ASSUME_NONNULL_END
