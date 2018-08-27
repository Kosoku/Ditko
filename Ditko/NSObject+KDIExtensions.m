//
//  NSObject+KDIExtensions.m
//  Ditko
//
//  Created by William Towe on 11/29/17.
//  Copyright © 2018 Kosoku Interactive, LLC. All rights reserved.
//
//  Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
//
//  1. Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
//
//  2. Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
//
//  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

#import "NSObject+KDIExtensions.h"

#import <objc/runtime.h>

@implementation NSObject (KDIExtensions)

static void const *kKDI_customConstraintsKey = &kKDI_customConstraintsKey;

@dynamic KDI_customConstraints;
- (NSArray<NSLayoutConstraint *> *)KDI_customConstraints {
    return objc_getAssociatedObject(self, kKDI_customConstraintsKey);
}
- (void)setKDI_customConstraints:(NSArray<NSLayoutConstraint *> *)KDI_customConstraints {
    NSArray *oldCustomConstraints = self.KDI_customConstraints;
    
    if (oldCustomConstraints != nil) {
        [NSLayoutConstraint deactivateConstraints:oldCustomConstraints];
    }
    
    objc_setAssociatedObject(self, kKDI_customConstraintsKey, KDI_customConstraints, OBJC_ASSOCIATION_COPY_NONATOMIC);
    
    if (KDI_customConstraints != nil) {
        [NSLayoutConstraint activateConstraints:KDI_customConstraints];
    }
}

@end
