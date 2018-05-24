//
//  NSColor-UIColor+KDIExtensions.m
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

#import <TargetConditionals.h>

#if (TARGET_OS_IPHONE)
#import "UIColor+KDIExtensions.h"
#else
#import "NSColor+KDIExtensions.h"
#endif
#import "KDIDefines.h"

#import <Stanley/Stanley.h>

// https://www.w3.org/TR/AERT#color-contrast
static inline CGFloat KDIPerceivedBrightnessForRedGreenAndBlue(CGFloat red, CGFloat green, CGFloat blue) {
    return (1.0 - (red * 0.299 + green * 0.587 + blue * 0.114));
}

@implementation KDIColor (KDIExtensions)

+ (KDIColor *)KDI_colorRandomRGB; {
    u_int32_t max = 255;
    u_int32_t red = arc4random_uniform(max);
    u_int32_t green = arc4random_uniform(max);
    u_int32_t blue = arc4random_uniform(max);

#if (TARGET_OS_IPHONE)
    return [UIColor colorWithRed:red/255.0 green:green/255.0 blue:blue/255.0 alpha:1.0];
#else
    return [NSColor colorWithCalibratedRed:red/255.0 green:green/255.0 blue:blue/255.0 alpha:1.0];
#endif
}
+ (KDIColor *)KDI_colorRandomRGBA; {
    u_int32_t max = 255;
    u_int32_t red = arc4random_uniform(max);
    u_int32_t green = arc4random_uniform(max);
    u_int32_t blue = arc4random_uniform(max);
    u_int32_t alpha = arc4random_uniform(max);
    
#if (TARGET_OS_IPHONE)
    return [UIColor colorWithRed:red/255.0 green:green/255.0 blue:blue/255.0 alpha:alpha/255.0];
#else
    return [NSColor colorWithCalibratedRed:red/255.0 green:green/255.0 blue:blue/255.0 alpha:alpha/255.0];
#endif
}
    
+ (KDIColor *)KDI_colorRandomHSB; {
    u_int32_t max = 240;
    u_int32_t hue = arc4random_uniform(max);
    u_int32_t saturation = arc4random_uniform(max);
    u_int32_t brightness = arc4random_uniform(max);
    
#if (TARGET_OS_IPHONE)
    return [UIColor colorWithRed:hue/(CGFloat)max green:saturation/(CGFloat)max blue:brightness/(CGFloat)max alpha:1.0];
#else
    return [NSColor colorWithCalibratedHue:hue/(CGFloat)max saturation:saturation/(CGFloat)max brightness:brightness/(CGFloat)max alpha:1.0];
#endif
}
+ (KDIColor *)KDI_colorRandomHSBA; {
    u_int32_t max = 240;
    u_int32_t hue = arc4random_uniform(max);
    u_int32_t saturation = arc4random_uniform(max);
    u_int32_t brightness = arc4random_uniform(max);
    u_int32_t alpha = arc4random_uniform(255);
    
#if (TARGET_OS_IPHONE)
    return [UIColor colorWithRed:hue/(CGFloat)max green:saturation/(CGFloat)max blue:brightness/(CGFloat)max alpha:alpha/255.0];
#else
    return [NSColor colorWithCalibratedHue:hue/(CGFloat)max saturation:saturation/(CGFloat)max brightness:brightness/(CGFloat)max alpha:alpha/255.0];
#endif
}

+ (KDIColor *)KDI_colorWithHexadecimalString:(NSString *)hexadecimalString; {
    if (hexadecimalString.length == 0) {
        return nil;
    }
    
    hexadecimalString = [hexadecimalString stringByReplacingOccurrencesOfString:@"#" withString:@""];
    
    if ([hexadecimalString hasPrefix:@"0x"]) {
        hexadecimalString = [hexadecimalString stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"0x"]];
    }
    
    KDIColor *retval = nil;
    NSScanner *scanner = [NSScanner scannerWithString:hexadecimalString];
    
    uint32_t hexadecimalColor;
    if (![scanner scanHexInt:&hexadecimalColor]) {
        return retval;
    }
    
    uint8_t red = (uint8_t)(hexadecimalColor >> 16);
    uint8_t green = (uint8_t)(hexadecimalColor >> 8);
    uint8_t blue = (uint8_t)hexadecimalColor;
    CGFloat alpha = hexadecimalColor > 0xFFFFFF ? ((CGFloat)((hexadecimalColor >> 24) & 0xFF)) / ((CGFloat)0xFF) : 1.0;
    
#if (TARGET_OS_IPHONE)
    retval = [UIColor colorWithRed:(CGFloat)red/0xff green:(CGFloat)green/0xff blue:(CGFloat)blue/0xff alpha:alpha];
#else
    retval = [NSColor colorWithCalibratedRed:(CGFloat)red/0xff green:(CGFloat)green/0xff blue:(CGFloat)blue/0xff alpha:alpha];
#endif
    
    return retval;
}

+ (nullable NSString *)KDI_hexadecimalStringFromColor:(KDIColor *)color; {
    CGFloat red, green, blue, alpha;
#if (TARGET_OS_IPHONE)
    if (![color getRed:&red green:&green blue:&blue alpha:&alpha]) {
        [color getWhite:&red alpha:&alpha];
        green = red;
        blue = red;
    }
#else
    [color getRed:&red green:&green blue:&blue alpha:&alpha];
#endif
    
    red = round(red * 255.f);
    green = round(green * 255.f);
    blue = round(blue * 255.f);
    alpha = round(alpha * 255.f);
    
    uint32_t hex = ((uint32_t)alpha << 24) | ((uint32_t)red << 16) | ((uint32_t)green << 8) | ((uint32_t)blue);
    
    return [NSString stringWithFormat:@"%08x",hex];
}
- (nullable NSString *)KDI_hexadecimalString; {
    return [self.class KDI_hexadecimalStringFromColor:self];
}

- (BOOL)KDI_colorVisibleOverBackgroundColor:(KDIColor *)backgroundColor tolerance:(CGFloat)tolerance; {
    CGFloat foregroundLuminance;
    CGFloat fRed = 0.0, fGreen = 0.0, fBlue = 0.0, fAlpha = 0.0;
    
    [self getRed:&fRed green:&fGreen blue:&fBlue alpha:&fAlpha];
    
    fRed *= 0.2126f;
    fGreen *= 0.7152f;
    fBlue *= 0.0722f;
    foregroundLuminance = fRed + fGreen + fBlue;
    
    CGFloat backgroundLuminance;
    CGFloat bRed = 0.0, bGreen = 0.0, bBlue = 0.0, bAlpha = 0.0;
    
    [backgroundColor getRed:&bRed green:&bGreen blue:&bBlue alpha:&bAlpha];
    
    bRed *= 0.2126f;
    bGreen *= 0.7152f;
    bBlue *= 0.0722f;
    backgroundLuminance = bRed + bGreen + bBlue;
    
    if (backgroundLuminance < tolerance) {
        return foregroundLuminance > backgroundLuminance;
    } else {
        return foregroundLuminance < backgroundLuminance;
    }
}
    
+ (KDIColor *)KDI_contrastingColorOfColor:(KDIColor *)color; {
#if (TARGET_OS_IPHONE)
    CGFloat red, green, blue;
    if ([color getRed:&red green:&green blue:&blue alpha:NULL]) {
        if (KDIPerceivedBrightnessForRedGreenAndBlue(red,green,blue) < 0.5) {
            return UIColor.blackColor;
        }
        else {
            return UIColor.whiteColor;
        }
    }
    CGFloat white;
    if ([color getWhite:&white alpha:NULL]) {
        if (white < 0.5) {
            return UIColor.whiteColor;
        }
        else {
            return UIColor.blackColor;
        }
    }
    return color;
#else
    if (color.colorSpace.colorSpaceModel != NSColorSpaceModelRGB) {
        NSColor *temp = [color colorUsingColorSpace:NSColorSpace.deviceRGBColorSpace];
        
        if (temp != nil) {
            color = temp;
        }
    }
    if (color.colorSpace.colorSpaceModel == NSColorSpaceModelRGB) {
        CGFloat red, green, blue;
        [color getRed:&red green:&green blue:&blue alpha:NULL];
        
        if (KDIPerceivedBrightnessForRedGreenAndBlue(red,green,blue) < 0.5) {
            return NSColor.blackColor;
        }
        else {
            return NSColor.whiteColor;
        }
    }
    return color;
#endif
}
- (KDIColor *)KDI_contrastingColor; {
    return [KDIColor KDI_contrastingColorOfColor:self];
}
#if (TARGET_OS_IOS)
+ (UIStatusBarStyle)KDI_contrastingStatusBarStyleForColor:(nullable UIColor *)color; {
    if (color == nil) {
        return UIStatusBarStyleDefault;
    }
    else {
        UIColor *contrastColor = [color KDI_contrastingColor];
        
        if ([contrastColor isEqual:UIColor.blackColor]) {
            return UIStatusBarStyleDefault;
        }
        else {
            return UIStatusBarStyleLightContent;
        }
    }
}
- (UIStatusBarStyle)KDI_contrastingStatusBarStyle; {
    return [self.class KDI_contrastingStatusBarStyleForColor:self];
}
#endif

+ (KDIColor *)KDI_inverseColorOfColor:(KDIColor *)color {
#if (TARGET_OS_IPHONE)
    CGFloat white;
    if ([color getWhite:&white alpha:NULL]) {
        return [UIColor colorWithWhite:1.0-white alpha:1.0];
    }
    CGFloat hue, saturation, brightness;
    if ([color getHue:&hue saturation:&saturation brightness:&brightness alpha:NULL]) {
        return [UIColor colorWithHue:1.0-hue saturation:1.0-saturation brightness:1.0-brightness alpha:1.0];
    }
    CGFloat red, green, blue;
    if ([color getRed:&red green:&green blue:&blue alpha:NULL]) {
        return [UIColor colorWithRed:1.0-red green:1.0-green blue:1.0-blue alpha:1.0];
    }
    return color;
#else
    if (color.colorSpace.colorSpaceModel == NSColorSpaceModelGray) {
        CGFloat white;
        [color getWhite:&white alpha:NULL];
        
        return [NSColor colorWithCalibratedWhite:1.0-white alpha:1.0];
    }
    else if (color.colorSpace.colorSpaceModel == NSColorSpaceModelRGB) {
        CGFloat red, green, blue;
        [color getRed:&red green:&green blue:&blue alpha:NULL];
        
        return [NSColor colorWithCalibratedRed:1.0-red green:1.0-green blue:1.0-blue alpha:1.0];
    }
    else if (color.colorSpace.colorSpaceModel == NSColorSpaceModelCMYK) {
        CGFloat cyan, magenta, yellow, black;
        [color getCyan:&cyan magenta:&magenta yellow:&yellow black:&black alpha:NULL];
        
        return [NSColor colorWithDeviceCyan:1.0-cyan magenta:1.0-magenta yellow:1.0-yellow black:1.0-black alpha:1.0];
    }
    return color;
#endif
}
- (KDIColor *)KDI_inverseColor {
    return [KDIColor KDI_inverseColorOfColor:self];
}

+ (KDIColor *)KDI_colorByAdjustingBrightnessOfColor:(KDIColor *)color delta:(CGFloat)delta; {
    CGFloat hue, saturation, brightness, alpha;
    
#if (TARGET_OS_IPHONE)
    if ([color getHue:&hue saturation:&saturation brightness:&brightness alpha:&alpha]) {
        brightness += delta;
        brightness = KSTBoundedValue(brightness, 0.0, 1.0);
        
        return [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:alpha];
    }
    
    CGFloat white;
    
    if ([color getWhite:&white alpha:&alpha]) {
        white += delta;
        white = KSTBoundedValue(white, 0.0, 1.0);
        
        return [UIColor colorWithWhite:white alpha:alpha];
    }
    
    return nil;
#else
    [color getHue:&hue saturation:&saturation brightness:&brightness alpha:&alpha];
    
    brightness += delta;
    brightness = KSTBoundedValue(brightness, 0.0, 1.0);
    
    return [NSColor colorWithCalibratedHue:hue saturation:saturation brightness:brightness alpha:alpha];
#endif
}

- (KDIColor *)KDI_colorByAdjustingBrightnessBy:(CGFloat)delta; {
    return [self.class KDI_colorByAdjustingBrightnessOfColor:self delta:delta];
}
    
+ (KDIColor *)KDI_colorByAdjustingBrightnessOfColor:(KDIColor *)color percent:(CGFloat)percent; {
    CGFloat brightness;
#if (TARGET_OS_IPHONE)
    if ([color getHue:NULL saturation:NULL brightness:&brightness alpha:NULL]) {
        return [self KDI_colorByAdjustingBrightnessOfColor:color delta:brightness * percent];
    }
#else
    [color getHue:NULL saturation:NULL brightness:&brightness alpha:NULL];
    
    return [self KDI_colorByAdjustingBrightnessOfColor:color delta:brightness * percent];
#endif
    return color;
}
- (KDIColor *)KDI_colorByAdjustingBrightnessByPercent:(CGFloat)percent; {
    return [self.class KDI_colorByAdjustingBrightnessOfColor:self percent:percent];
}

+ (KDIColor *)KDI_colorByAdjustingHueOfColor:(KDIColor *)color delta:(CGFloat)delta; {
    CGFloat hue, saturation, brightness, alpha;
#if (TARGET_OS_IPHONE)
    if ([color getHue:&hue saturation:&saturation brightness:&brightness alpha:&alpha]) {
        hue += delta;
        hue = KSTBoundedValue(hue, 0.0, 1.0);
        
        return [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:alpha];
    }
#else
    [color getHue:&hue saturation:&saturation brightness:&brightness alpha:&alpha];
    
    hue += delta;
    hue = KSTBoundedValue(hue, 0.0, 1.0);
    
    return [NSColor colorWithCalibratedHue:hue saturation:saturation brightness:brightness alpha:alpha];
#endif
    return color;
}
- (KDIColor *)KDI_colorByAdjustingHueBy:(CGFloat)delta {
    return [self.class KDI_colorByAdjustingHueOfColor:self delta:delta];
}
    
+ (KDIColor *)KDI_colorByAdjustingHueOfColor:(KDIColor *)color percent:(CGFloat)percent; {
    CGFloat hue;
#if (TARGET_OS_IPHONE)
    if ([color getHue:&hue saturation:NULL brightness:NULL alpha:NULL]) {
        return [self KDI_colorByAdjustingHueOfColor:color delta:hue * percent];
    }
#else
    [color getHue:&hue saturation:NULL brightness:NULL alpha:NULL];
    
    return [self KDI_colorByAdjustingHueOfColor:color delta:hue * percent];
#endif
    return color;
}
- (KDIColor *)KDI_colorByAdjustingHueByPercent:(CGFloat)percent; {
    return [self.class KDI_colorByAdjustingHueOfColor:self percent:percent];
}
    
+ (KDIColor *)KDI_colorByAdjustingSaturationOfColor:(KDIColor *)color delta:(CGFloat)delta; {
    CGFloat hue, saturation, brightness, alpha;
#if (TARGET_OS_IPHONE)
    if ([color getHue:&hue saturation:&saturation brightness:&brightness alpha:&alpha]) {
        saturation += delta;
        saturation = KSTBoundedValue(saturation, 0.0, 1.0);
        
        return [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:alpha];
    }
#else
    [color getHue:&hue saturation:&saturation brightness:&brightness alpha:&alpha];
    
    saturation += delta;
    saturation = KSTBoundedValue(saturation, 0.0, 1.0);
    
    return [NSColor colorWithCalibratedHue:hue saturation:saturation brightness:brightness alpha:alpha];
#endif
    return color;
}
- (KDIColor *)KDI_colorByAdjustingSaturationBy:(CGFloat)delta; {
    return [self.class KDI_colorByAdjustingSaturationOfColor:self delta:delta];
}

+ (KDIColor *)KDI_colorByAdjustingSaturationOfColor:(KDIColor *)color percent:(CGFloat)percent; {
    CGFloat saturation;
#if (TARGET_OS_IPHONE)
    if ([color getHue:NULL saturation:&saturation brightness:NULL alpha:NULL]) {
        return [self KDI_colorByAdjustingSaturationOfColor:color delta:saturation * percent];
    }
#else
    [color getHue:NULL saturation:&saturation brightness:NULL alpha:NULL];
    
    return [self KDI_colorByAdjustingSaturationOfColor:color delta:saturation * percent];
#endif
    return color;
}
- (KDIColor *)KDI_colorByAdjustingSaturationByPercent:(CGFloat)percent; {
    return [self.class KDI_colorByAdjustingSaturationOfColor:self percent:percent];
}

@end
