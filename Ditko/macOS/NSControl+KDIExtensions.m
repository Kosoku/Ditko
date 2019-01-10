//
//  NSControl+KDIExtensions.m
//  Ditko
//
//  Created by William Towe on 4/5/17.
//  Copyright © 2019 Kosoku Interactive, LLC. All rights reserved.
//
//  Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
//
//  1. Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
//
//  2. Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
//
//  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

#import "NSControl+KDIExtensions.h"

#import <Stanley/KSTLoggingMacros.h>

#import <objc/runtime.h>

static void const *kKDIBlockKey = &kKDIBlockKey;

@interface NSControl (KDIPrivateExtensions)
- (IBAction)_KDI_blockAction:(NSControl *)sender;
@end

@implementation NSControl (KDIExtensions)

@dynamic KDI_block;
- (KDINSControlBlock)KDI_block {
    return objc_getAssociatedObject(self, kKDIBlockKey);
}
- (void)setKDI_block:(KDINSControlBlock)KDI_block {
    if (KDI_block == nil) {
        [self setTarget:nil];
        [self setAction:NULL];
    }
    else {
        if (self.target != nil ||
            self.action != NULL) {
            
            KSTLog(@"non-nil target or non-null action on control %@ while setting block!",self);
        }
        
        [self setTarget:self];
        [self setAction:@selector(_KDI_blockAction:)];
    }
    
    objc_setAssociatedObject(self, kKDIBlockKey, KDI_block, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

@end

@implementation NSControl (KDIPrivateExtensions)

- (IBAction)_KDI_blockAction:(NSControl *)sender; {
    KDINSControlBlock block = sender.KDI_block;
    
    if (block != nil) {
        block(sender);
    }
}

@end
