//
//  UIView+KDIExtensions.h
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

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (KDIExtensions)

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
 Set and get the border color of the receiver. Calls through to the relevant layer methods.
 */
@property (strong,nonatomic,nullable) UIColor *KDI_borderColor;
/**
 Set and get the border width of the receiver. Calls through to the relevant layer methods.
 */
@property (assign,nonatomic) CGFloat KDI_borderWidth;
/**
 Set and get the corner radius of the receiver. Calls through to the relevant layer methods.
 */
@property (assign,nonatomic) CGFloat KDI_cornerRadius;

/**
 Get the enclosing scroll view of the receiver or nil if one cannot be found.
 
 @return The enclosing scroll view or nil
 */
- (nullable __kindof UIScrollView *)KDI_enclosingScrollView;

/**
 Creates and returns an NSArray containing all the receiver's subviews recursively.
 
 For each subview of the receiver, the subview is adding to the returned array, followed by the array of the subview's recursive subviews.
 
 @return The array of recursive subviews
 */
- (NSArray<__kindof UIView *> *)KDI_recursiveSubviews;

/**
 Calls `[self KDI_snapshotImageFromRect:afterScreenUpdates:]`, passing self.bounds and afterScreenUpdates respectively.
 
 @param afterScreenUpdates Whether the snapshot should contain recent changes
 @return The snapshot image
 */
- (nullable UIImage *)KDI_snapshotImageAfterScreenUpdates:(BOOL)afterScreenUpdates;
/**
 Creates and returns a snapshot image of the receiver using `drawViewHierarchyInRect:afterScreenUpdates`.
 
 @param rect The rect from which to create the snapshot image, should be in the receiver's coordinate system
 @param afterScreenUpdates Whether the snapshot should contain recent changes
 @return The snapshot image
 */
- (nullable UIImage *)KDI_snapshotImageFromRect:(CGRect)rect afterScreenUpdates:(BOOL)afterScreenUpdates;
/**
 Draws a 1pt border around the view in the color passed.
 
 @param color The color to make the debug border
 */
- (void)KDI_addDebugBorderWithColor:(UIColor *)color;

@end

NS_ASSUME_NONNULL_END
