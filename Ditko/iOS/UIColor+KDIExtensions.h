//
//  UIColor+KDIExtensions.h
//  Ditko
//
//  Created by William Towe on 3/7/17.
//  Copyright © 2017 Kosoku Interactive, LLC. All rights reserved.
//
//  Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
//
//  1. Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
//
//  2. Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
//
//  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (KDIExtensions)

/**
 Creates and returns a UIColor in the RGB color space with random values between 0 and 255 for R, G, and B respectively. Alpha is always 1.0.
 
 @return The random UIColor
 */
+ (UIColor *)KDI_colorRandomRGB;
/**
 Creates and returns a UIColor in the RGB color space with random values between 0 and 255 for R, G, B, and A respectively.
 
 @return The random UIColor
 */
+ (UIColor *)KDI_colorRandomRGBA;

/**
 Creates and returns a contrasting color for the provided *color*, which will either be UIColor.blackColor or UIColor.whiteColor depending on the perceived brightness of *color*. The perceived brightness is calculated using https://www.w3.org/TR/AERT#color-contrast as a reference. If the contrasting color cannot be computed, *color* is returned.
 
 @param color The color for which to compute the contrasting color
 @return The contrasting color
 */
+ (UIColor *)KDI_contrastingColorOfColor:(UIColor *)color;
/**
 Returns [self.class KDI_contrastingColorOfColor:self].
 
 @return The contrasting color
 */
- (UIColor *)KDI_contrastingColor;

/**
 Creates and returns the inverse of the provided color. The inverse of UIColor.blackColor is UIColor.whiteColor.
 
 @param color The color for which to return the inverse color
 @return The inverse color
 */
+ (UIColor *)KDI_inverseColorOfColor:(UIColor *)color;
/**
 Returns [self.class KDI_inverseColorOfColor:self].
 
 @return The inverse color
 */
- (UIColor *)KDI_inverseColor;
/**
 Tells where the the color has enough luminance compared to the backgroundColor at stated tolerance (luminance level to surpass).
 
 @param backgroundColor the color of the background
 @param tolerance the luminance level tolerance
 @return BOOL
 */
- (BOOL)KDI_colorVisibleOverBackgroundColor:(UIColor *)backgroundColor tolerance:(CGFloat)tolerance;

/**
 Creates and returns an UIColor by parsing *hexadecimalString*. See http://www.karelia.com/cocoa_legacy/Foundation_Categories/NSColor__Instantiat.m for implementation reference.
 
 @param hexadecimalString The string to parse
 @return The UIColor created from *hexadecimalString*
 */
+ (nullable UIColor *)KDI_colorWithHexadecimalString:(nullable NSString *)hexadecimalString;

/**
 Creates and returns a new color by adjusting the bright of color by *delta*. Clamps the new brightness between 0.0 and 1.0.
 
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

@end

NS_ASSUME_NONNULL_END
