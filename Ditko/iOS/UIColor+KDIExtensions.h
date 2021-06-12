//
//  UIColor+KDIExtensions.h
//  Ditko
//
//  Created by William Towe on 3/7/17.
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

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (KDIExtensions)

#pragma mark Creation
/**
 Creates and returns a color in the RGB color space with random values between 0 and 255 for R, G, and B respectively. Alpha is always 1.0.
 */
@property (class,readonly,nonatomic) UIColor *KDI_colorRandomRGB;
/**
 Creates and returns a UIColor in the RGB color space with random values between 0 and 255 for R, G, B, and A respectively.
 */
@property (class,readonly,nonatomic) UIColor *KDI_colorRandomRGBA;
/**
 Creates and returns a random color in the HSB color space, using values between 0 and 240 for H, S, and B respectively. Alpha is always 1.0.
 */
@property (class,readonly,nonatomic) UIColor *KDI_colorRandomHSB;
/**
 Creates and returns a random color in the HSB color space, using values between 0 and 240 for H, S, B, and A respectively.
 */
@property (class,readonly,nonatomic) UIColor *KDI_colorRandomHSBA;

#pragma mark Hexadecimal
/**
 Creates and returns a color by parsing *hexadecimalString*.
 
 @param hexadecimalString The string to parse
 @return The UIColor created from *hexadecimalString*
 */
+ (nullable UIColor *)KDI_colorWithHexadecimalString:(nullable NSString *)hexadecimalString;

/**
 Returns the hexadecimal string from *color*.
 
 @param color The color for which to return a hexadecimal string
 @return The hexadecimal string
 */
+ (nullable NSString *)KDI_hexadecimalStringFromColor:(UIColor *)color;
/**
 Returns [self.class KDI_hexadecimalStringFromColor:self].
 */
- (nullable NSString *)KDI_hexadecimalString;

#pragma mark Visibility
/**
 Tells where the the color has enough luminance compared to the backgroundColor at stated tolerance (luminance level to surpass).
 
 @param backgroundColor the color of the background
 @param tolerance the luminance level tolerance
 @return BOOL
 */
- (BOOL)KDI_colorVisibleOverBackgroundColor:(UIColor *)backgroundColor tolerance:(CGFloat)tolerance;

#pragma mark Contrasting
/**
 Creates and returns a contrasting color for the provided *color*, which will either be UIColor.blackColor or UIColor.whiteColor depending on the perceived brightness of *color*. The perceived brightness is calculated using https://www.w3.org/TR/AERT#color-contrast as a reference. If the contrasting color cannot be computed, *color* is returned.
 
 @param color The color for which to compute the contrasting color
 @return The contrasting color
 */
+ (nullable UIColor *)KDI_contrastingColorOfColor:(nullable UIColor *)color;
/**
 Returns [self.class KDI_contrastingColorOfColor:self].
 
 @return The contrasting color
 */
- (UIColor *)KDI_contrastingColor;

#if (TARGET_OS_IOS)
/**
 Returns a contrasting UIStatusBarStyle for the provided *color*.
 
 @param color The color for which to compute a contrasting status bar style
 @return The contrasting status bar style
 */
+ (UIStatusBarStyle)KDI_contrastingStatusBarStyleForColor:(nullable UIColor *)color;
/**
 Returns [self.class KDI_contrastingStatusBarStyleForColor:self].
 
 @return The contrasting status bar style
 */
- (UIStatusBarStyle)KDI_contrastingStatusBarStyle;
#endif

#pragma mark Inverse
/**
 Creates and returns the inverse of the provided color. The inverse of UIColor.blackColor is UIColor.whiteColor.
 
 @param color The color for which to return the inverse color
 @return The inverse color
 */
+ (nullable UIColor *)KDI_inverseColorOfColor:(nullable UIColor *)color;
/**
 Returns [self.class KDI_inverseColorOfColor:self].
 
 @return The inverse color
 */
- (UIColor *)KDI_inverseColor;

#pragma mark Hue
/**
 Returns a color by adjusting the hue of the *color* by *delta*.
 
 @param color The color to adjust
 @param delta The amount to adjust by
 @return The new color
 */
+ (nullable UIColor *)KDI_colorByAdjustingHueOfColor:(nullable UIColor *)color delta:(CGFloat)delta;
/**
 Returns [self.class KDI_colorByAdjustingHueOfColor:self delta:delta].
 */
- (nullable UIColor *)KDI_colorByAdjustingHueBy:(CGFloat)delta;
/**
 Returns a color by adjusting the hue of the *color* by a *percent* of its current value.
 
 @param color The color to adjust
 @param percent The percentage to adjust by
 @return The new color
 */
+ (nullable UIColor *)KDI_colorByAdjustingHueOfColor:(nullable UIColor *)color percent:(CGFloat)percent;
/**
 Returns [self.class KDI_colorByAdjustingHueOfColor:self percent:percent].
 */
- (nullable UIColor *)KDI_colorByAdjustingHueByPercent:(CGFloat)percent;

#pragma mark Saturation
/**
 Returns a color by adjusting the saturation of the *color* by *delta*.
 
 @param color The color to adjust
 @param delta The amount to adjust by
 @return The new color
 */
+ (nullable UIColor *)KDI_colorByAdjustingSaturationOfColor:(nullable UIColor *)color delta:(CGFloat)delta;
/**
 Returns [self.class KDI_colorByAdjustingSaturationOfColor:self delta:delta].
 */
- (nullable UIColor *)KDI_colorByAdjustingSaturationBy:(CGFloat)delta;
/**
 Returns a color by adjusting the saturation of the *color* by a *percent* of its current value.
 
 @param color The color to adjust
 @param percent The percentage to adjust by
 @return The new color
 */
+ (nullable UIColor *)KDI_colorByAdjustingSaturationOfColor:(nullable UIColor *)color percent:(CGFloat)percent;
/**
 Returns [self.class KDI_colorByAdjustingSaturationOfColor:self percent:percent].
 */
- (nullable UIColor *)KDI_colorByAdjustingSaturationByPercent:(CGFloat)percent;

#pragma mark Brightness
/**
 Returns a color by adjusting the brightness of *color* by *delta*. Clamps the new brightness between 0.0 and 1.0.
 
 @param color The color to adjust
 @param delta The amount to adjust the brightness
 @return The new color
 */
+ (nullable UIColor *)KDI_colorByAdjustingBrightnessOfColor:(nullable UIColor *)color delta:(CGFloat)delta;
/**
 Calls `[self.class KDI_colorByAdjustingBrightnessOfColor:self delta:delta]`.
 
 @param delta The amount to adjust the brightness
 @return The new color
 */
- (nullable UIColor *)KDI_colorByAdjustingBrightnessBy:(CGFloat)delta;
/**
 Returns a color by adjusting the brightness of the *color* by a *percent* of its current value.
 
 @param color The color to adjust
 @param percent The percentage to adjust by
 @return The new color
 */
+ (nullable UIColor *)KDI_colorByAdjustingBrightnessOfColor:(nullable UIColor *)color percent:(CGFloat)percent;
/**
 Returns [self.class KDI_colorByAdjustingBrightnessOfColor:self percent:percent].
 */
- (nullable UIColor *)KDI_colorByAdjustingBrightnessByPercent:(CGFloat)percent;

@end

NS_ASSUME_NONNULL_END
