//
//  UITableView+KDIExtensions.m
//  Ditko
//
//  Created by William Towe on 4/4/18.
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

#import "UITableView+KDIExtensions.h"

@implementation UITableView (KDIExtensions)

- (void)KDI_reloadHeightAnimated:(BOOL)animated; {
    [self KDI_reloadHeightAnimated:animated block:nil];
}
- (void)KDI_reloadHeightAnimated:(BOOL)animated block:(dispatch_block_t)block; {
    [self KDI_reloadHeightAnimated:animated block:block completion:nil];
}
- (void)KDI_reloadHeightAnimated:(BOOL)animated block:(dispatch_block_t)block completion:(dispatch_block_t)completion {
    void(^reload)(void) = ^{
        [CATransaction begin];
        [CATransaction setCompletionBlock:completion];
        
        [self beginUpdates];
        
        if (block != nil) {
            block();
        }
        
        [self endUpdates];
        
        [CATransaction commit];
    };
    
    if (animated) {
        reload();
    }
    else {
        [UIView performWithoutAnimation:reload];
    }
}

@end
