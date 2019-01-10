//
//  UINavigationController+KDIExtensions.h
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
