//
//  UIViewController+KDIExtensions.h
//  Ditko
//
//  Created by William Towe on 3/10/17.
//  Copyright © 2019 Kosoku Interactive, LLC. All rights reserved.
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
