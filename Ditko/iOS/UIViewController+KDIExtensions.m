//
//  UIViewController+KDIExtensions.m
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

+ (UIViewController *)KDI_viewControllerForPresenting; {
    for (UIScene *scene in UIApplication.sharedApplication.connectedScenes) {
        if (![scene isKindOfClass:UIWindowScene.class]) {
            continue;
        }
        
        for (UIWindow *window in [(UIWindowScene *)scene windows]) {
            if (!window.isKeyWindow) {
                continue;
            }
            
            return window.rootViewController.KDI_viewControllerForPresenting;
        }
    }
    
    return nil;
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
    
    if ([barButtonItem isKindOfClass:UIBarButtonItem.class]) {
        [popoverPresentationController setBarButtonItem:barButtonItem];
    }
    else if ([sourceView isKindOfClass:UIView.class]) {
        [popoverPresentationController setSourceView:sourceView];
        [popoverPresentationController setSourceRect:CGRectIsEmpty(sourceRect) ? sourceView.bounds : sourceRect];
    }
    else {
        sourceView = [UIViewController KDI_viewControllerForPresenting].view;
        sourceRect = sourceView.bounds;
        
        [popoverPresentationController setSourceView:sourceView];
        [popoverPresentationController setSourceRect:sourceRect];
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
