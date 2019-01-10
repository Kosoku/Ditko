//
//  NSControl+KDIExtensions.h
//  Ditko
//
//  Created by William Towe on 4/5/17.
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

#import <AppKit/AppKit.h>

NS_ASSUME_NONNULL_BEGIN

/**
 A block that is invoked when the control's action is triggered. The control is sent as the only parameter.
 
 @param control The control whose action was triggered
 */
typedef void(^KDINSControlBlock)(__kindof NSControl *control);

@interface NSControl (KDIExtensions)

/**
 Get and set the block that will be invoked when the receiver's action is triggered. Setting this to a non-nil value will override the receiver's target and action.
 */
@property (copy,nonatomic,nullable) KDINSControlBlock KDI_block;

@end

NS_ASSUME_NONNULL_END
