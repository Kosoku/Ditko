//
//  NSView+KDIExtensions.h
//  Ditko
//
//  Created by William Towe on 3/10/17.
//  Copyright © 2017 Kosoku Interactive, LLC. All rights reserved.
//
//  Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
//
//  1. Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
//
//  2. Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
//
//  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

#import <AppKit/AppKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSView (KDIExtensions)

/**
 Set and get the minimum X member of the receiver's frame.
 */
@property (assign,nonatomic) CGFloat KDI_frameMinimumX;
/**
 Set and get the maximum X member of the receiver's frame.
 */
@property (assign,nonatomic) CGFloat KDI_frameMaximumX;
/**
 Set and get the minimum Y member of the receiver's frame.
 */
@property (assign,nonatomic) CGFloat KDI_frameMinimumY;
/**
 Set and get the maximum Y member of the receiver's frame.
 */
@property (assign,nonatomic) CGFloat KDI_frameMaximumY;
/**
 Set and get the width member of the receiver's frame.
 */
@property (assign,nonatomic) CGFloat KDI_frameWidth;
/**
 Set and get the height member of the receiver's frame.
 */
@property (assign,nonatomic) CGFloat KDI_frameHeight;

/**
 Convenience property to set and get the custom constraints managed by the receiver. Setting this will deactivate the old custom constraints and active the new custom constraints.
 */
@property (copy,nonatomic,nullable) NSArray<NSLayoutConstraint *> *KDI_customConstraints;

/**
 Creates and returns an NSArray containing all the receiver's subviews recursively.
 
 For each subview of the receiver, the subview is adding to the returned array, followed by the array of the subview's recursive subviews.
 
 @return The array of recursive subviews
 */
- (NSArray<__kindof NSView *> *)KDI_recursiveSubviews;

@end

NS_ASSUME_NONNULL_END
