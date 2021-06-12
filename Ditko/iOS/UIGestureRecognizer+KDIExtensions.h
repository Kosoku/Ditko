//
//  UIGestureRecognizer+KDIExtensions.h
//  Ditko
//
//  Created by William Towe on 5/8/17.
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
 A block that is invoked when the gesture recognizer triggers an action.
 
 @param gestureRecognizer The gesture recognizer that executed the action
 */
typedef void(^KDIUIGestureRecognizerBlock)(__kindof UIGestureRecognizer *gestureRecognizer);

@interface UIGestureRecognizer (KDIExtensions)

/**
 Add a block to the gesture recognizer that will be invoked when the gesture recognizer triggers an action.
 
 @param block The block to invoke
 */
- (void)KDI_addBlock:(KDIUIGestureRecognizerBlock)block;
/**
 Remove all the block associated with the receiver.
 */
- (void)KDI_removeBlocks;
/**
 Returns YES if the receiver has any blocks associated with it, otherwise NO.
 
 @return YES if there are blocks, otherwise NO
 */
- (BOOL)KDI_hasBlocks;

@end

NS_ASSUME_NONNULL_END
