//
//  UIScrollView+KDIExtensions.h
//  Ditko
//
//  Created by William Towe on 3/6/18.
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
