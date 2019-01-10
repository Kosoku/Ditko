//
//  NSColor+KDIExtensions.h
//  Ditko
//
//  Created by William Towe on 3/8/17.
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

@interface NSColor (KDIExtensions)

#pragma mark Creation
/**
 Creates and returns a color in the RGB color space with random values between 0 and 255 for R, G, and B respectively. Alpha is always 1.0.
 */
@property (class,readonly,nonatomic) NSColor *KDI_colorRandomRGB;
/**
 Creates and returns a UIColor in the RGB color space with random values between 0 and 255 for R, G, B, and A respectively.
 */
@property (class,readonly,nonatomic) NSColor *KDI_colorRandomRGBA;
/**
 Creates and returns a random color in the HSB color space, using values between 0 and 240 for H, S, and B respectively. Alpha is always 1.0.
 */
@property (class,readonly,nonatomic) NSColor *KDI_colorRandomHSB;
/**
 Creates and returns a random color in the HSB color space, using values between 0 and 240 for H, S, B, and A respectively.
 */
@property (class,readonly,nonatomic) NSColor *KDI_colorRandomHSBA;

#pragma mark Hexadecimal
/**
 Creates and returns a color by parsing *hexadecimalString*.
 
 @param hexadecimalString The string to parse
 @return The UIColor created from *hexadecimalString*
 */
+ (nullable NSColor *)KDI_colorWithHexadecimalString:(nullable NSString *)hexadecimalString;

/**
 Returns the hexadecimal string from *color*.
 
 @param color The color for which to return a hexadecimal string
 @return The hexadecimal string
 */
+ (nullable NSString *)KDI_hexadecimalStringFromColor:(NSColor *)color;
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
- (BOOL)KDI_colorVisibleOverBackgroundColor:(NSColor *)backgroundColor tolerance:(CGFloat)tolerance;

#pragma mark Contrasting
/**
 Creates and returns a contrasting color for the provided *color*, which will either be NSColor.blackColor or NSColor.whiteColor depending on the perceived brightness of *color*. The perceived brightness is calculated using https://www.w3.org/TR/AERT#color-contrast as a reference. If the contrasting color cannot be computed, *color* is returned.
 
 @param color The color for which to compute the contrasting color
 @return The contrasting color
 */
+ (nullable NSColor *)KDI_contrastingColorOfColor:(nullable NSColor *)color;
/**
 Returns [self.class KDI_contrastingColorOfColor:self].
 
 @return The contrasting color
 */
- (NSColor *)KDI_contrastingColor;

#pragma mark Inverse
/**
 Creates and returns the inverse of the provided color. The inverse of NSColor.blackColor is NSColor.whiteColor.
 
 @param color The color for which to return the inverse color
 @return The inverse color
 */
+ (nullable NSColor *)KDI_inverseColorOfColor:(nullable NSColor *)color;
/**
 Returns [self.class KDI_inverseColorOfColor:self].
 
 @return The inverse color
 */
- (NSColor *)KDI_inverseColor;

#pragma mark Hue
/**
 Returns a color by adjusting the hue of the *color* by *delta*.
 
 @param color The color to adjust
 @param delta The amount to adjust by
 @return The new color
 */
+ (nullable NSColor *)KDI_colorByAdjustingHueOfColor:(nullable NSColor *)color delta:(CGFloat)delta;
/**
 Returns [self.class KDI_colorByAdjustingHueOfColor:self delta:delta].
 */
- (nullable NSColor *)KDI_colorByAdjustingHueBy:(CGFloat)delta;
/**
 Returns a color by adjusting the hue of the *color* by a *percent* of its current value.
 
 @param color The color to adjust
 @param percent The percentage to adjust by
 @return The new color
 */
+ (nullable NSColor *)KDI_colorByAdjustingHueOfColor:(nullable NSColor *)color percent:(CGFloat)percent;
/**
 Returns [self.class KDI_colorByAdjustingHueOfColor:self percent:percent].
 */
- (nullable NSColor *)KDI_colorByAdjustingHueByPercent:(CGFloat)percent;

#pragma mark Saturation
/**
 Returns a color by adjusting the saturation of the *color* by *delta*.
 
 @param color The color to adjust
 @param delta The amount to adjust by
 @return The new color
 */
+ (nullable NSColor *)KDI_colorByAdjustingSaturationOfColor:(nullable NSColor *)color delta:(CGFloat)delta;
/**
 Returns [self.class KDI_colorByAdjustingSaturationOfColor:self delta:delta].
 */
- (nullable NSColor *)KDI_colorByAdjustingSaturationBy:(CGFloat)delta;
/**
 Returns a color by adjusting the saturation of the *color* by a *percent* of its current value.
 
 @param color The color to adjust
 @param percent The percentage to adjust by
 @return The new color
 */
+ (nullable NSColor *)KDI_colorByAdjustingSaturationOfColor:(nullable NSColor *)color percent:(CGFloat)percent;
/**
 Returns [self.class KDI_colorByAdjustingSaturationOfColor:self percent:percent].
 */
- (nullable NSColor *)KDI_colorByAdjustingSaturationByPercent:(CGFloat)percent;

#pragma mark Brightness
/**
 Returns a color by adjusting the brightness of *color* by *delta*. Clamps the new brightness between 0.0 and 1.0.
 
 @param color The color to adjust
 @param delta The amount to adjust the brightness
 @return The new color
 */
+ (nullable NSColor *)KDI_colorByAdjustingBrightnessOfColor:(nullable NSColor *)color delta:(CGFloat)delta;
/**
 Calls `[self.class KDI_colorByAdjustingBrightnessOfColor:self delta:delta]`.
 
 @param delta The amount to adjust the brightness
 @return The new color
 */
- (nullable NSColor *)KDI_colorByAdjustingBrightnessBy:(CGFloat)delta;
/**
 Returns a color by adjusting the brightness of the *color* by a *percent* of its current value.
 
 @param color The color to adjust
 @param percent The percentage to adjust by
 @return The new color
 */
+ (nullable NSColor *)KDI_colorByAdjustingBrightnessOfColor:(nullable NSColor *)color percent:(CGFloat)percent;
/**
 Returns [self.class KDI_colorByAdjustingBrightnessOfColor:self percent:percent].
 */
- (nullable NSColor *)KDI_colorByAdjustingBrightnessByPercent:(CGFloat)percent;

@end

NS_ASSUME_NONNULL_END
