//
//  UIViewController+KDIExtensions.m
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

#import "UIViewController+KDIExtensions.h"

@implementation UIViewController (KDIExtensions)

- (NSArray *)KDI_recursiveChildViewControllers; {
    NSMutableOrderedSet *retval = [[NSMutableOrderedSet alloc] init];
    
    for (UIViewController *viewController in self.childViewControllers) {
        [retval addObject:viewController];
        [retval addObjectsFromArray:[viewController KDI_recursiveChildViewControllers]];
    }
    
    return retval.array;
}

+ (nullable UIViewController *)KDI_viewControllerForPresenting; {
    return [[UIApplication sharedApplication].keyWindow.rootViewController KDI_viewControllerForPresenting];
}
- (UIViewController *)KDI_viewControllerForPresenting {
    UIViewController *retval = self;
    
    while (retval.presentedViewController) {
        retval = retval.presentedViewController;
    }
    
    return retval;
}

#if (TARGET_OS_IOS)
- (void)KDI_presentViewControllerAsPopover:(UIViewController *)viewController barButtonItem:(UIBarButtonItem *)barButtonItem sourceView:(UIView *)sourceView sourceRect:(CGRect)sourceRect permittedArrowDirections:(UIPopoverArrowDirection)permittedArrowDirections animated:(BOOL)animated completion:(dispatch_block_t)completion {
    [viewController setModalPresentationStyle:UIModalPresentationPopover];
    
    UIPopoverPresentationController *popoverPresentationController = viewController.popoverPresentationController;
    
    [popoverPresentationController setPermittedArrowDirections:permittedArrowDirections];
    
    if (barButtonItem != nil) {
        [popoverPresentationController setBarButtonItem:barButtonItem];
    }
    else if (sourceView != nil) {
        [popoverPresentationController setSourceView:sourceView];
        [popoverPresentationController setSourceRect:CGRectIsEmpty(sourceRect) ? sourceView.bounds : sourceRect];
    }
    
    [self presentViewController:viewController animated:animated completion:completion];
}
#endif

- (void)KDI_recursivelyDismissViewControllerAnimated:(BOOL)animated completion:(void(^ _Nullable)(void))completion; {
    /**
     Track the view controller that is presenting something.
     */
    __block UIViewController *viewController = self.presentedViewController == nil ? self.presentingViewController : self;
    /**
     This reference is needed to avoid a retain cycle. Both __block and __weak are required.
     */
    __block __weak void(^weakBlock)(void) = nil;
    /**
     The original block reference.
     */
    void(^block)(void) = ^{
        /**
         If there is nothing left to dismiss, invoke the completion block if non-nil.
         */
        if (viewController == nil) {
            if (completion != nil) {
                completion();
            }
        }
        /**
         Otherwise recurse, make a strong reference to weakBlock so it won't be deallocated during the dismiss animation, update the reference to viewController after the dismiss animation and invoke strongBlock within the completion block.
         */
        else {
            void(^strongBlock)(void) = weakBlock;
            
            [viewController dismissViewControllerAnimated:animated completion:^{
                viewController = viewController.presentingViewController;
                
                strongBlock();
            }];
        }
    };
    /**
     Assign to weakBlock, which we reference within the original declaration of block to avoid retain cycle.
     */
    weakBlock = block;
    /**
     Invoke the original block the first time.
     */
    block();
}



@end
