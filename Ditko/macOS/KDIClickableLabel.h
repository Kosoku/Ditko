//
//  KDIClickableLabel.h
//  Ditko
//
//  Created by William Towe on 4/7/17.
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

@class KDIClickableLabel;

/**
 Block that is invoked when the clickable label is clicked.
 
 @param label The label that was clicked
 */
typedef void(^KDIClickableLabelBlock)(__kindof KDIClickableLabel *label);

/**
 KDIClickableLabel is a NSTextField subclass that configures itself as a label, meaning it is not editable nor selectable. It can be configured to apply additional attributes to its text when the mouse enters its visible rect as well as change the cursor to indicate the user can click it.
 */
@interface KDIClickableLabel : NSTextField

/**
 Set and get the text attributes to apply when the mouse enters the visible rect of the receiver. The attributes are removed when the mouse leaves the visiable rect of the receiver.
 
 The default is @{NSForegroundColorAttributeName: [NSColor blueColor],
                  NSUnderlineColorAttributeName: [NSColor blueColor],
                  NSUnderlineStyleAttributeName: @(NSUnderlineStyleSingle|NSUnderlinePatternSolid)}.
 */
@property (copy,nonatomic,null_resettable) NSDictionary<NSString *, id> *clickableTextAttributes;
/**
 Set and get the cursor to display when the mouse enters the visible rect of the receiver. The cursor is reset when the mouse leaves the visible rect of the receiver.
 
 The default is [NSCursor pointingHandCursor].
 */
@property (strong,nonatomic,null_resettable) NSCursor *clickableCursor;

/**
 Set and get the block that is executed when the user clicks on the receiver, specifically when the instance receives a mouseUp: event.
 
 @see KDIClickableLabelBlock
 */
@property (copy,nonatomic,nullable) KDIClickableLabelBlock block;

@end

NS_ASSUME_NONNULL_END
