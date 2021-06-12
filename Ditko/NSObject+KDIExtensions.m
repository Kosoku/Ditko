//
//  NSObject+KDIExtensions.m
//  Ditko
//
//  Created by William Towe on 11/29/17.
//  Copyright © 2021 Kosoku Interactive, LLC. All rights reserved.
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
