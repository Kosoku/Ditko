//
//  UIImage+KDIExtensions.m
//  Ditko
//
//  Created by William Towe on 5/18/17.
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
#import "UIImage+KDIExtensions.h"
#else
#import "NSImage+KDIExtensions.h"
#endif
#import "KDIDefines.h"

#if (TARGET_OS_IPHONE)
@implementation UIImage (KDIExtensions)
#else
@implementation NSImage (KDIExtensions)
#endif

+ (KDIColor *)KDI_dominantColorForImage:(KDIImage *)image; {
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    unsigned char rgba[4];
    CGContextRef context = CGBitmapContextCreate(rgba, 1, 1, 8, 4, colorSpace, kCGImageAlphaPremultipliedLast | kCGBitmapByteOrder32Big);
        
    CGContextDrawImage(context, CGRectMake(0, 0, 1, 1), KDICGImageFromImage(image));
    CGColorSpaceRelease(colorSpace);
    CGContextRelease(context);
        
    if (rgba[3] == 0) {
        CGFloat imageAlpha = ((CGFloat)rgba[3])/255.0;
        CGFloat multiplier = imageAlpha/255.0;
#if (TARGET_OS_IPHONE)
        UIColor *retval = [UIColor colorWithRed:((CGFloat)rgba[0])*multiplier green:((CGFloat)rgba[1])*multiplier blue:((CGFloat)rgba[2])*multiplier alpha:imageAlpha];
            
        return retval;
    }
    
    UIColor *retval = [UIColor colorWithRed:((CGFloat)rgba[0])/255.0 green:((CGFloat)rgba[1])/255.0 blue:((CGFloat)rgba[2])/255.0 alpha:1.0];
#else
        NSColor *retval = [NSColor colorWithRed:((CGFloat)rgba[0])*multiplier green:((CGFloat)rgba[1])*multiplier blue:((CGFloat)rgba[2])*multiplier alpha:imageAlpha];
    
        return retval;
    }
        
    NSColor *retval = [NSColor colorWithRed:((CGFloat)rgba[0])/255.0 green:((CGFloat)rgba[1])/255.0 blue:((CGFloat)rgba[2])/255.0 alpha:1.0];
#endif
    return retval;
}
- (KDIColor *)KDI_dominantColor {
    return [self.class KDI_dominantColorForImage:self];
}

@end
