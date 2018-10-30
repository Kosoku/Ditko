//
//  UIBarButtonItem+KDIExtensions.h
//  Ditko
//
//  Created by William Towe on 3/10/17.
//  Copyright © 2018 Kosoku Interactive, LLC. All rights reserved.
//
//  Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
//
//  1. Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
//
//  2. Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
//
//  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

#import <Ditko/KDIDefines.h>

NS_ASSUME_NONNULL_BEGIN

/**
 A block that is invoked when the bar button item is tapped. The receiver is sent as the only parameter.
 
 @param barButtonItem The bar button item that was tapped
 */
typedef void(^KDIUIBarButtonItemBlock)(__kindof UIBarButtonItem *barButtonItem);

@interface UIBarButtonItem (KDIExtensions)

/**
 Get and set the bar button item block which will be invoked when the bar button item is tapped. Setting this will override the target and action of the receiver.
 */
@property (copy,nonatomic,nullable) KDIUIBarButtonItemBlock KDI_block;

/**
 Creates and returns a flexible space UIBarButtonItem.
 
 @return The bar button item
 */
+ (UIBarButtonItem *)KDI_flexibleSpaceBarButtonItem;
/**
 Creates and returns a fixed space UIBarButtonItem with _width_.
 
 @param width The width of the fixed space bar button item
 @return The bar button item
 */
+ (UIBarButtonItem *)KDI_fixedSpaceBarButtonItemWithWidth:(CGFloat)width;

/**
 Returns KDI_labelBarButtonItemWithText:color:, passing *text* and nil respectively.
 
 @param text The label text
 @return The initialized instance
 */
+ (UIBarButtonItem *)KDI_labelBarButtonItemWithText:(NSString *)text;
/**
 Returns KDI_labelBarButtonItemWithText:color:font:, passing *text*, nil, and nil respectively.
 
 @param text The label text
 @param color The label text color
 @return The initialized instance
 */
+ (UIBarButtonItem *)KDI_labelBarButtonItemWithText:(NSString *)text color:(nullable UIColor *)color;
/**
 Returns KDI_labelBarButtonItemWithText:color:, passing *text* and nil respectively.
 
 @param text The label text
 @param color The label text color, the default is UIColor.blackColor
 @param font The label font, the default is [UIFont systemFontOfSize:17.0]
 @return The initialized instance
 */
+ (UIBarButtonItem *)KDI_labelBarButtonItemWithText:(NSString *)text color:(nullable UIColor *)color font:(nullable UIFont *)font;

/**
 Creates and returns a UIBarButtonItem with *image* and *block*.
 
 @param image The bar button item image
 @param style The bar button item style
 @param block The block to invoke when the bar button item is tapped
 @return The bar button item
 */
+ (UIBarButtonItem *)KDI_barButtonItemWithImage:(nullable UIImage *)image style:(UIBarButtonItemStyle)style block:(nullable KDIUIBarButtonItemBlock)block;
/**
 Creates and returns a UIBarButtonItem with *title* and *block*.
 
 @param title The bar button item title
 @param style The bar button item style
 @param block The block to invoke when the bar button item is tapped
 @return The bar button item
 */
+ (UIBarButtonItem *)KDI_barButtonItemWithTitle:(nullable NSString *)title style:(UIBarButtonItemStyle)style block:(nullable KDIUIBarButtonItemBlock)block;
/**
 Creates and returns a UIBarButtonItem with *image* and *block*.
 
 @param barButtonSystemItem The bar button system item
 @param block The block to invoke when the bar button item is tapped
 @return The bar button item
 */
+ (UIBarButtonItem *)KDI_barButtonSystemItem:(UIBarButtonSystemItem)barButtonSystemItem block:(nullable KDIUIBarButtonItemBlock)block;

@end

NS_ASSUME_NONNULL_END
