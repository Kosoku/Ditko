//
//  NSViewController+KDIExtensions.m
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

#import "NSViewController+KDIExtensions.h"

@implementation NSViewController (KDIExtensions)

+ (NSViewController *)KDI_viewControllerForPresenting; {
    return [[[NSApplication sharedApplication].keyWindow.windowController contentViewController] KDI_viewControllerForPresenting];
}
- (NSViewController *)KDI_viewControllerForPresenting; {
    NSViewController *retval = self;
    
    while (retval.presentedViewControllers.count > 0) {
        retval = retval.presentedViewControllers.lastObject;
    }
    
    return retval;
}

@end
