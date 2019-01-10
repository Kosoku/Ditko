//
//  UIScrollView+KDIExtensions.h
//  Ditko
//
//  Created by William Towe on 3/6/18.
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

@interface UIScrollView (KDIExtensions)

/**
 Returns YES if the receiver is at the top, taking into account the content insets of the receiver.
 */
@property (readonly,nonatomic) BOOL KDI_isAtTop;
/**
 Returns YES if the receiver is at the bottom, taking into account the content insets of the receiver.
 */
@property (readonly,nonatomic) BOOL KDI_isAtBottom;
/**
 Returns the visible rect of the receiver.
 */
@property (readonly,nonatomic) CGRect KDI_visibleRect;

/**
 Scrolls the receiver to the top, optionally *animated*.
 
 @param animated Whether to animate the scroll
 */
- (void)KDI_scrollToTopAnimated:(BOOL)animated;
/**
 Scrolls the receiver to the bottom, optionally *animated*.
 
 @param animated Whether to animate the scroll
 */
- (void)KDI_scrollToBottomAnimated:(BOOL)animated;

@end
