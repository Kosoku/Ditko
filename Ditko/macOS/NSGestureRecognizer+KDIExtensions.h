//
//  NSGestureRecognizer+KDIExtensions.h
//  Ditko
//
//  Created by William Towe on 5/8/17.
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

#import <Cocoa/Cocoa.h>

NS_ASSUME_NONNULL_BEGIN

/**
 A block that is invoked when the gesture recognizer triggers an action.
 
 @param gestureRecognizer The gesture recognizer that executed the action
 */
typedef void(^KDINSGestureRecognizerBlock)(__kindof NSGestureRecognizer *gestureRecognizer);

@interface NSGestureRecognizer (KDIExtensions)

/**
 Set and get the block associated with the receiver which will be invoked when the receiver triggers an action. Setting this to non-nil will override the target and action properties of the receiver.
 */
@property (copy,nonatomic,nullable) KDINSGestureRecognizerBlock KDI_block;

@end

NS_ASSUME_NONNULL_END
