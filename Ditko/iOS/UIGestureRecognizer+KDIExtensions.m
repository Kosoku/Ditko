//
//  UIGestureRecognizer+KDIExtensions.m
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
