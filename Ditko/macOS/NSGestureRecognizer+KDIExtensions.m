//
//  NSGestureRecognizer+KDIExtensions.m
//  Ditko
//
//  Created by William Towe on 5/8/17.
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

#import "NSGestureRecognizer+KDIExtensions.h"

#import <objc/runtime.h>

static void *kKDIBlockKey = &kKDIBlockKey;

@implementation NSGestureRecognizer (KDIExtensions)

@dynamic KDI_block;
- (KDINSGestureRecognizerBlock)KDI_block {
    return objc_getAssociatedObject(self, kKDIBlockKey);
}
- (void)setKDI_block:(KDINSGestureRecognizerBlock)KDI_block {
    objc_setAssociatedObject(self, kKDIBlockKey, KDI_block, OBJC_ASSOCIATION_COPY_NONATOMIC);
    
    if (KDI_block == nil) {
        [self setTarget:nil];
        [self setAction:NULL];
    }
    else {
        [self setTarget:self];
        [self setAction:@selector(_KDI_blockAction:)];
    }
}

- (IBAction)_KDI_blockAction:(NSGestureRecognizer *)sender {
    if (sender.KDI_block != nil) {
        sender.KDI_block(sender);
    }
}

@end
