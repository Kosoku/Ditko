//
//  NSView+KDIExtensions.h
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
 Creates and returns an NSArray containing all the receiver's subviews recursively.
 
 For each subview of the receiver, the subview is adding to the returned array, followed by the array of the subview's recursive subviews.
 
 @return The array of recursive subviews
 */
- (NSArray<__kindof NSView *> *)KDI_recursiveSubviews;

@end

NS_ASSUME_NONNULL_END
