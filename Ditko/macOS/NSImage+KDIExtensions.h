//
//  NSImage+KDIExtensions.h
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

#import <AppKit/AppKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSImage (KDIExtensions)

/**
 If self.isTemplate is NO, returns the receiver. Otherwise creates a copy of the receiver and sets `template` to NO.
 */
@property (readonly,nonatomic) NSImage *KDI_originalImage;
/**
 If self.isTemplate is YES, returns the receiver. Otherwise creates a copy of the receiver and sets `template` to YES.
 */
@property (readonly,nonatomic) NSImage *KDI_templateImage;

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
