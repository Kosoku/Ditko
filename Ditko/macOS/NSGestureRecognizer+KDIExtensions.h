//
//  NSGestureRecognizer+KDIExtensions.h
//  Ditko
//
//  Created by William Towe on 5/8/17.
//  Copyright © 2017 Kosoku Interactive, LLC. All rights reserved.
//
//  Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
//
//  1. Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
//
//  2. Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
//
//  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

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
