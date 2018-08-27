//
//  UINavigationController+KDIExtensions.h
//  Ditko
//
//  Created by William Towe on 3/10/17.
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

NS_ASSUME_NONNULL_BEGIN

@interface UINavigationController (KDIExtensions)

/**
 Calls through to setViewControllers:animated: and invokes the provided completion block when the animation is complete. If *completion* is nil, simply calls through to setViewControllers:animated:.
 
 @param viewControllers The array of view controllers to set
 @param animated Whether to animate the transition
 @param completion The completion block to invoke when the animation is complete
 */
- (void)KDI_setViewControllers:(NSArray<UIViewController *> *)viewControllers animated:(BOOL)animated completion:(nullable dispatch_block_t)completion;

/**
 Calls through to pushViewController:animated: and invokes the provided completion block when the animation is complete. If completion is nil, simply calls through to pushViewController:animated:.
 
 @param viewController The view controller to push
 @param animated Whether or not to animate the transition
 @param completion The completion block to invoke when the animation is complete
 */
- (void)KDI_pushViewController:(UIViewController *)viewController animated:(BOOL)animated completion:(nullable dispatch_block_t)completion;
/**
 Calls through to KDI_setViewControllers:animated:completion: passing an array created by appending *viewControllers* to the receiver's existing viewControllers array.
 
 @param viewControllers The array of view controllers to push
 @param animated Whether to animate the push
 @param completion The completion block to invoke when the push is complete
 */
- (void)KDI_pushViewControllers:(NSArray<UIViewController *> *)viewControllers animated:(BOOL)animated completion:(nullable dispatch_block_t)completion;

/**
 Calls through to popToRootViewControllerAnimated: and invokes the provided completion block when the animation is complete. If completion is nil, simply calls through to popToRootViewControllerAnimated:.
 
 @param animated Whether or not to animate the transition
 @param completion The completion block to invoke when the animation is complete
 @return The array of popped view controllers
 */
- (nullable NSArray<__kindof UIViewController *> *)KDI_popToRootViewControllerAnimated:(BOOL)animated completion:(nullable dispatch_block_t)completion;
/**
 Calls through to popToViewController:animated: and invokes the provided completion block when the animation is complete. If completion is nil, simply calls through to popToViewController:animated:.
 
 @param viewController The view controller to pop to
 @param animated Whether or not to animate the transition
 @param completion The completion block to invoke when the animation is complete
 @return The array of popped view controllers
 */
- (nullable NSArray<__kindof UIViewController *> *)KDI_popToViewController:(UIViewController *)viewController animated:(BOOL)animated completion:(nullable dispatch_block_t)completion;
/**
 Calls through to popViewControllerAnimated: and invokes the provided completion block when the animation is complete. If completion is nil, simply calls through to popViewControllerAnimated:.
 
 @param animated Whether or not to animate the transition
 @param completion The completion block to invoke when the animation is complete
 @return The popped view controller
 */
- (nullable __kindof UIViewController *)KDI_popViewControllerAnimated:(BOOL)animated completion:(nullable dispatch_block_t)completion;

@end

NS_ASSUME_NONNULL_END
