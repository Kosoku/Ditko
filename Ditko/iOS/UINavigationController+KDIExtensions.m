//
//  UINavigationController+KDIExtensions.m
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
