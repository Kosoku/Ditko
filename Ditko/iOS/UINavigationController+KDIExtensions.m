//
//  UINavigationController+KDIExtensions.m
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

#import "UINavigationController+KDIExtensions.h"

@implementation UINavigationController (KDIExtensions)

- (void)KDI_setViewControllers:(NSArray<UIViewController *> *)viewControllers animated:(BOOL)animated completion:(dispatch_block_t)completion {
    if (completion == nil) {
        [self setViewControllers:viewControllers animated:animated];
    }
    else {
        [CATransaction begin];
        [CATransaction setCompletionBlock:completion];
        
        [self setViewControllers:viewControllers animated:animated];
        
        [CATransaction commit];
    }
}

- (void)KDI_pushViewController:(UIViewController *)viewController animated:(BOOL)animated completion:(dispatch_block_t)completion; {
    if (completion == nil) {
        [self pushViewController:viewController animated:animated];
    }
    else {
        [CATransaction begin];
        [CATransaction setCompletionBlock:completion];
        
        [self pushViewController:viewController animated:animated];
        
        [CATransaction commit];
    }
}
- (void)KDI_pushViewControllers:(NSArray<UIViewController *> *)viewControllers animated:(BOOL)animated completion:(dispatch_block_t)completion {
    NSMutableArray *temp = [NSMutableArray arrayWithArray:self.viewControllers];
    
    [temp addObjectsFromArray:viewControllers];
    
    [self KDI_setViewControllers:temp animated:animated completion:completion];
}

- (nullable NSArray<__kindof UIViewController *> *)KDI_popToRootViewControllerAnimated:(BOOL)animated completion:(dispatch_block_t)completion; {
    if (completion == nil) {
        return [self popToRootViewControllerAnimated:animated];
    }
    else {
        [CATransaction begin];
        [CATransaction setCompletionBlock:completion];
        
        NSArray *retval = [self popToRootViewControllerAnimated:animated];
        
        [CATransaction commit];
        
        return retval;
    }
}
- (nullable NSArray<__kindof UIViewController *> *)KDI_popToViewController:(UIViewController *)viewController animated:(BOOL)animated completion:(dispatch_block_t)completion; {
    if (completion == nil) {
        return [self popToViewController:viewController animated:animated];
    }
    else {
        [CATransaction begin];
        [CATransaction setCompletionBlock:completion];
        
        NSArray *retval = [self popToViewController:viewController animated:animated];
        
        [CATransaction commit];
        
        return retval;
    }
}
- (nullable UIViewController *)KDI_popViewControllerAnimated:(BOOL)animated completion:(dispatch_block_t)completion; {
    if (completion == nil) {
        return [self popViewControllerAnimated:animated];
    }
    else {
        [CATransaction begin];
        [CATransaction setCompletionBlock:completion];
        
        UIViewController *retval = [self popViewControllerAnimated:animated];
        
        [CATransaction commit];
        
        return retval;
    }
}

@end
