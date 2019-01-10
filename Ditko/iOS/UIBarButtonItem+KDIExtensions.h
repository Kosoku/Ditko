//
//  UIBarButtonItem+KDIExtensions.h
//  Ditko
//
//  Created by William Towe on 3/10/17.
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
