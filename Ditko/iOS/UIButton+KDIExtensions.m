//
//  UIButton+KDIExtensions.m
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

#import "UIButton+KDIExtensions.h"

#import <objc/runtime.h>

static void const *kKDIBlockKey = &kKDIBlockKey;

@interface UIButton (KDIPrivateExtensions)
- (IBAction)_KDI_blockAction:(UIButton *)sender;
@end

@implementation UIButton (KDIExtensions)

@dynamic KDI_block;
- (KDIUIButtonBlock)KDI_block {
    return objc_getAssociatedObject(self, kKDIBlockKey);
}
- (void)setKDI_block:(KDIUIButtonBlock)KDI_block {
    objc_setAssociatedObject(self, kKDIBlockKey, KDI_block, OBJC_ASSOCIATION_COPY_NONATOMIC);
    
    if (KDI_block == nil) {
        [self removeTarget:self action:@selector(_KDI_blockAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    else {
        [self addTarget:self action:@selector(_KDI_blockAction:) forControlEvents:UIControlEventTouchUpInside];
    }
}

@end

@implementation UIButton (KDIPrivateExtensions)

- (IBAction)_KDI_blockAction:(UIButton *)sender; {
    KDIUIButtonBlock block = sender.KDI_block;
    
    if (block != nil) {
        block(sender);
    }
}

@end
