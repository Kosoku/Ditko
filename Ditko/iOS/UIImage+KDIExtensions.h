//
//  UIImage+KDIExtensions.h
//  Ditko
//
//  Created by William Towe on 5/18/17.
//  Copyright © 2018 Kosoku Interactive, LLC. All rights reserved.
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

@interface UIImage (KDIExtensions)

/**
 If the receiver is already an original image, returns self. Otherwise returns `[self imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]`.
 */
@property (readonly,nonatomic) UIImage *KDI_originalImage;
/**
 If the receiver is already a template image, returns self. Otherwise returns `[self imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate]`;
 */
@property (readonly,nonatomic) UIImage *KDI_templateImage;

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
