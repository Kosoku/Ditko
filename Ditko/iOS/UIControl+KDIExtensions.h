//
//  UIControl+KDIExtensions.h
//  Ditko
//
//  Created by William Towe on 3/22/17.
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

/**
 A block that is invoked when the control events are executed.
 
 @param control The control that executed the control events
 @param controlEvents The control events that caused the control to execute
 */
typedef void(^KDIUIControlBlock)(__kindof UIControl *control, UIControlEvents controlEvents);

@interface UIControl (KDIExtensions)

/**
 Add a *block* to be invoked for the provided *controlEvents*.
 
 @param block The block to invoke
 @param controlEvents The control events that should cause the block to invoke
 */
- (void)KDI_addBlock:(KDIUIControlBlock)block forControlEvents:(UIControlEvents)controlEvents;
/**
 Remove all the blocks for the provided *controlEvents*.
 
 @param controlEvents The control events for which to remove all blocks
 */
- (void)KDI_removeBlocksForControlEvents:(UIControlEvents)controlEvents;
/**
 Returns whether the receiver has any added blocks for the provided *controlEvents*.
 
 @param controlEvents The control events for which to check for blocks
 @return YES if the receiver has blocks added, otherwise NO
 */
- (BOOL)KDI_hasBlocksForControlEvents:(UIControlEvents)controlEvents;

@end

NS_ASSUME_NONNULL_END
