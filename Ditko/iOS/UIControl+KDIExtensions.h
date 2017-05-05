//
//  UIControl+KDIExtensions.h
//  Ditko
//
//  Created by William Towe on 3/22/17.
//  Copyright © 2017 Kosoku Interactive, LLC. All rights reserved.
//
//  Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
//
//  1. Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
//
//  2. Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
//
//  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

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
