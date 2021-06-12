//
//  UITableView+KDIExtensions.h
//  Ditko
//
//  Created by William Towe on 4/4/18.
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

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITableView (KDIExtensions)

/**
 Calls KDI_reloadHeightAnimated:block:, passing *animated* and nil respectively.
 */
- (void)KDI_reloadHeightAnimated:(BOOL)animated;
/**
 Reloads the height of the table view, not its cells, using beingUpdates and endUpdates. Optionally executes *block* in between the beginUpdates and endUpdates calls.
 
 @param animated Whether to animate the height changes
 @param block The block to execute between the height change method calls
 */
- (void)KDI_reloadHeightAnimated:(BOOL)animated block:(nullable dispatch_block_t)block;
/**
 Reloads the height of the table view, not its cells, using beingUpdates and endUpdates. Optionally executes *block* in between the beginUpdates and endUpdates calls.
 
 @param animated Whether to animate the height changes
 @param block The block to execute between the height change method calls
 @param completion The block to execute after the height as been reloaded
 */
- (void)KDI_reloadHeightAnimated:(BOOL)animated block:(nullable dispatch_block_t)block completion:(nullable dispatch_block_t)completion;

@end

NS_ASSUME_NONNULL_END
