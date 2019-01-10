//
//  UIGestureRecognizer+KDIExtensions.h
//  Ditko
//
//  Created by William Towe on 5/8/17.
//  Copyright © 2019 Kosoku Interactive, LLC. All rights reserved.
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
