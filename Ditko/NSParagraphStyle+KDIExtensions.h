//
//  NSParagraphStyle+KDIExtensions.h
//  Ditko
//
//  Created by William Towe on 3/10/17.
//  Copyright © 2021 Kosoku Interactive, LLC. All rights reserved.
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

#import <TargetConditionals.h>

#if (TARGET_OS_IPHONE)
#import <UIKit/UIKit.h>
#else
#import <AppKit/AppKit.h>
#endif

NS_ASSUME_NONNULL_BEGIN

@interface NSParagraphStyle (KDIExtensions)

/**
 Calls `[self KDI_paragraphStyleWithTextAlignment:]`, passing NSTextAlignmentCenter.
 
 @return The paragraph style with center text alignment
 */
+ (NSParagraphStyle *)KDI_paragraphStyleWithCenterTextAlignment;
/**
 Calls `[self KDI_paragraphStyleWithTextAlignment:]`, passing NSTextAlignmentRight.
 
 @return The paragraph style with right text alignment
 */
+ (NSParagraphStyle *)KDI_paragraphStyleWithRightTextAlignment;
/**
 Returns a paragraph style with provided text alignment.
 
 @param textAlignment The desired text alignment of the paragraph style
 @return The paragraph style
 */
+ (NSParagraphStyle *)KDI_paragraphStyleWithTextAlignment:(NSTextAlignment)textAlignment;

@end

NS_ASSUME_NONNULL_END
