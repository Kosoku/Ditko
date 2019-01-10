//
//  UIViewController+KDIExtensions.h
//  Ditko
//
//  Created by William Towe on 3/10/17.
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

@interface UIViewController (KDIExtensions)

/**
 Creates and returns an array of the receiver's child view controllers recursively.
 
 For each child view controller in the receiver, the child view controller is added to the return array followed by the array of recursive child view controllers.
 
 @return The array of recursive child view controllers
 */
- (NSArray<__kindof UIViewController *> *)KDI_recursiveChildViewControllers;

/**
 Calls `[[UIApplication sharedApplication].keyWindow.rootViewController KDI_viewControllerForPresenting]`.
 
 @return The view controller
 */
+ (nullable __kindof UIViewController *)KDI_viewControllerForPresenting;
/**
 Returns the view controller that should be used for modal presentation.
 
 @return The view controller
 */
- (__kindof UIViewController *)KDI_viewControllerForPresenting;

#if (TARGET_OS_IOS)
/**
 Presents *viewController* as a popover (on iPad) or fullscreen (on iPhone) from *barButtonItem* or *sourceView* relative to *sourceRect* optionally *animated* and invoking *completion* when the presentation completes.
 
 @param viewController The view controller to present
 @param barButtonItem The bar button item to present from
 @param sourceView The source view to present from
 @param sourceRect The source rect relative to *sourceView* to present from
 @param permittedArrowDirections The permitted popover arrow directions
 @param animated Whether to animate the presentation
 @param completion The block to invoke when the presentation completes
 */
- (void)KDI_presentViewControllerAsPopover:(UIViewController *)viewController barButtonItem:(nullable UIBarButtonItem *)barButtonItem sourceView:(nullable UIView *)sourceView sourceRect:(CGRect)sourceRect permittedArrowDirections:(UIPopoverArrowDirection)permittedArrowDirections animated:(BOOL)animated completion:(nullable dispatch_block_t)completion;
#endif

/**
 Recursively dismisses the presented view controller until there are no view controllers being presented, with optional animation. If non-nil, the provided completion block is invoked after the final view controller is dismissed.
 
 @param animated Whether to animate the recursive dismissal
 @param completion The completion block to invoke after the final view controller is dismissed
 */
- (void)KDI_recursivelyDismissViewControllerAnimated:(BOOL)animated completion:(nullable dispatch_block_t)completion;

@end

NS_ASSUME_NONNULL_END
