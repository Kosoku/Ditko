//
//  UIImage+KDIExtensions.h
//  Ditko
//
//  Created by William Towe on 5/18/17.
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
