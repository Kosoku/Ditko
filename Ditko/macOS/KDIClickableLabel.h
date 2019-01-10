//
//  KDIClickableLabel.h
//  Ditko
//
//  Created by William Towe on 4/7/17.
//  Copyright © 2019 Kosoku Interactive, LLC. All rights reserved.
//
//  Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
//
//  1. Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
//
//  2. Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
//
//  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

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
