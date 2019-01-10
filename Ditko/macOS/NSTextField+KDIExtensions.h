//
//  NSTextField+KDIExtensions.h
//  Ditko
//
//  Created by William Towe on 4/5/17.
//  Copyright © 2019 Kosoku Interactive, LLC. All rights reserved.
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
