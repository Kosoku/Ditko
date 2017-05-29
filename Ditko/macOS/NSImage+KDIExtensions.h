//
//  NSImage+KDIExtensions.h
//  Ditko
//
//  Created by William Towe on 5/18/17.
//  Copyright © 2017 Kosoku Interactive, LLC. All rights reserved.
//

#import <AppKit/AppKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSImage (KDIExtensions)

/**
 Extracts and returns the dominant color from *image*.
 
 @param image the image to evaluate
 @return The dominant color
 */
+ (NSColor *)KDI_dominantColorForImage:(NSImage *)image;
/**
 Extracts and returns the dominant color from the receiver.
 
 @return The dominant color
 */
- (NSColor *)KDI_dominantColor;

@end

NS_ASSUME_NONNULL_END
