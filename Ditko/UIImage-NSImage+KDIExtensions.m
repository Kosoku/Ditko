//
//  UIImage+KDIExtensions.m
//  Ditko
//
//  Created by William Towe on 5/18/17.
//  Copyright © 2017 Kosoku Interactive, LLC. All rights reserved.
//

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
