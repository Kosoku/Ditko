//
//  NSViewController+KDIExtensions.h
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

#import <AppKit/AppKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSViewController (KDIExtensions)

/**
 Calls `[[[NSApplication sharedApplication].keyWindow.windowController contentViewController] KDI_viewControllerForPresenting]`.
 
 @return The view controller
 */
+ (NSViewController *)KDI_viewControllerForPresenting;
/**
 Returns the view controller that should be used for modal presentation.
 
 @return The view controller
 */
- (NSViewController *)KDI_viewControllerForPresenting;

@end

NS_ASSUME_NONNULL_END
