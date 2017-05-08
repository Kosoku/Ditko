//
//  UIGestureRecognizer+KDIExtensions.m
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

#import "UIGestureRecognizer+KDIExtensions.h"

#import <objc/runtime.h>

@interface KDIUIGestureRecognizerBlockWrapper : NSObject
@property (copy,nonatomic) KDIUIGestureRecognizerBlock block;
@property (weak,nonatomic) UIGestureRecognizer *gestureRecognizer;

- (instancetype)initWithBlock:(KDIUIGestureRecognizerBlock)block gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer;
@end

@implementation KDIUIGestureRecognizerBlockWrapper

- (instancetype)initWithBlock:(KDIUIGestureRecognizerBlock)block gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer; {
    if (!(self = [super init]))
        return nil;
    
    _block = [block copy];
    _gestureRecognizer = gestureRecognizer;
    
    [_gestureRecognizer addTarget:self action:@selector(_gestureRecognizerAction:)];
    
    return self;
}

- (IBAction)_gestureRecognizerAction:(UIGestureRecognizer *)sender {
    self.block(sender);
}

@end

@interface UIGestureRecognizer (KDIPrivateExtensions)
@property (readonly,nonatomic) NSMutableSet<KDIUIGestureRecognizerBlockWrapper *> *_KDI_gestureRecognizerBlockWrappers;
@end

@implementation UIGestureRecognizer (KDIExtensions)

- (void)KDI_addBlock:(KDIUIGestureRecognizerBlock)block; {
    NSParameterAssert(block != nil);
    
    KDIUIGestureRecognizerBlockWrapper *wrapper = [[KDIUIGestureRecognizerBlockWrapper alloc] initWithBlock:block gestureRecognizer:self];
    
    [self._KDI_gestureRecognizerBlockWrappers addObject:wrapper];
}
- (void)KDI_removeBlocks; {
    [self._KDI_gestureRecognizerBlockWrappers removeAllObjects];
}
- (BOOL)KDI_hasBlocks; {
    return self._KDI_gestureRecognizerBlockWrappers.count > 0;
}

@end

@implementation UIGestureRecognizer (KDIPrivateExtensions)

- (NSMutableSet<KDIUIGestureRecognizerBlockWrapper *> *)_KDI_gestureRecognizerBlockWrappers {
    NSMutableSet *retval = objc_getAssociatedObject(self, _cmd);
    
    if (retval == nil) {
        retval = [[NSMutableSet alloc] init];
        
        objc_setAssociatedObject(self, _cmd, retval, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    
    return retval;
}

@end
