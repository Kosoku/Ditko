//
//  UIImage+KDIExtensions.h
//  Ditko
//
//  Created by William Towe on 5/18/17.
//  Copyright © 2017 Kosoku Interactive, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (KDIExtensions)

/**
 Extracts and returns the dominant color from *image*.
 
 @param image the image to evaluate
 @return The dominant color
 */
+ (UIColor *)KDI_dominantColorForImage:(UIImage *)image;
/**
 Extracts and returns the dominant color from the receiver.
 
 @return The dominant color
 */
- (UIColor *)KDI_dominantColor;

@end

NS_ASSUME_NONNULL_END
