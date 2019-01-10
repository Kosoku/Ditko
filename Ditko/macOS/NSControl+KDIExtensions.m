//
//  NSControl+KDIExtensions.m
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
