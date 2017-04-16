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

#import <Stanley/KSTValueMacros.h>

#if (TARGET_OS_IPHONE)
@implementation UIColor (KDIExtensions)
#else
@implementation NSColor (KDIExtensions)
#endif

#if (TARGET_OS_IPHONE)
+ (UIColor *)KDI_colorRandomRGB; {
#else
+ (NSColor *)KDI_colorRandomRGB; {
#endif
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
#if (TARGET_OS_IPHONE)
+ (UIColor *)KDI_colorRandomRGBA; {
#else
+ (NSColor *)KDI_colorRandomRGBA; {
#endif
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

#if (TARGET_OS_IPHONE)
+ (UIColor *)KDI_colorWithHexadecimalString:(NSString *)hexadecimalString; {
#else
+ (NSColor *)KDI_colorWithHexadecimalString:(NSString *)hexadecimalString; {
#endif
    if (hexadecimalString.length == 0) {
        return nil;
    }
    
    hexadecimalString = [hexadecimalString stringByReplacingOccurrencesOfString:@"#" withString:@""];
    
#if (TARGET_OS_IPHONE)
    UIColor *retval = nil;
#else
    NSColor *retval = nil;
#endif
    NSScanner *scanner = [NSScanner scannerWithString:hexadecimalString];
    
    uint32_t hexadecimalColor;
    if (![scanner scanHexInt:&hexadecimalColor]) {
        return retval;
    }
    
    uint8_t red = (uint8_t)(hexadecimalColor >> 16);
    uint8_t green = (uint8_t)(hexadecimalColor >> 8);
    uint8_t blue = (uint8_t)hexadecimalColor;

#if (TARGET_OS_IPHONE)
    retval = [UIColor colorWithRed:(CGFloat)red/0xff green:(CGFloat)green/0xff blue:(CGFloat)blue/0xff alpha:1.0];
#else
    retval = [NSColor colorWithCalibratedRed:(CGFloat)red/0xff green:(CGFloat)green/0xff blue:(CGFloat)blue/0xff alpha:1.0];
#endif
    
    return retval;
}

#if (TARGET_OS_IPHONE)
+ (UIColor *)KDI_colorByAdjustingBrightnessOfColor:(UIColor *)color delta:(CGFloat)delta; {
#else
+ (NSColor *)KDI_colorByAdjustingBrightnessOfColor:(NSColor *)color delta:(CGFloat)delta; {
#endif
    
    CGFloat hue, saturation, brightness, alpha;
    
#if (TARGET_OS_IPHONE)
    if ([color getHue:&hue saturation:&saturation brightness:&brightness alpha:&alpha]) {
        brightness += delta - 1.0;
        brightness = KSTBoundedValue(brightness, 0.0, 1.0);
        
        return [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:alpha];
    }
    
    CGFloat white;
    
    if ([color getWhite:&white alpha:&alpha]) {
        white += delta - 1.0;
        white = KSTBoundedValue(white, 0.0, 1.0);
        
        return [UIColor colorWithWhite:white alpha:alpha];
    }
    
    return nil;
#else
    [color getHue:&hue saturation:&saturation brightness:&brightness alpha:&alpha];
    
    brightness += delta - 1.0;
    brightness = KSTBoundedValue(brightness, 0.0, 1.0);
    
    return [NSColor colorWithCalibratedHue:hue saturation:saturation brightness:brightness alpha:alpha];
#endif
}

#if (TARGET_OS_IPHONE)
- (UIColor *)KDI_colorByAdjustingBrightnessBy:(CGFloat)delta; {
#else
- (NSColor *)KDI_colorByAdjustingBrightnessBy:(CGFloat)delta; {
#endif
    return [self.class KDI_colorByAdjustingBrightnessOfColor:self delta:delta];
}

@end
