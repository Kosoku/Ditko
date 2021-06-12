//
//  UIControl+KDIExtensions.m
//  Ditko
//
//  Created by William Towe on 3/22/17.
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

#import "UIControl+KDIExtensions.h"

#import <objc/runtime.h>

@interface _KDIUIControlBlockWrapper : NSObject
@property (copy,nonatomic) KDIUIControlBlock block;
@property (weak,nonatomic) UIControl *control;
@property (assign,nonatomic) UIControlEvents controlEvents;

- (instancetype)initWithBlock:(KDIUIControlBlock)block control:(UIControl *)control controlEvents:(UIControlEvents)controlEvents;
@end

@implementation _KDIUIControlBlockWrapper

- (instancetype)initWithBlock:(KDIUIControlBlock)block control:(UIControl *)control controlEvents:(UIControlEvents)controlEvents; {
    if (!(self = [super init]))
        return nil;
    
    _block = [block copy];
    _control = control;
    _controlEvents = controlEvents;
    
    [_control addTarget:self action:@selector(_controlAction:) forControlEvents:_controlEvents];
    
    return self;
}

- (IBAction)_controlAction:(UIControl *)sender {
    self.block(sender,self.controlEvents);
}

@end

@interface UIControl (KDIPrivateExtensions)
@property (readonly,nonatomic) NSMutableDictionary<NSNumber *, NSMutableSet<_KDIUIControlBlockWrapper *> *> *_KDI_controlEventsToBlockWrappers;
@end

@implementation UIControl (KDIExtensions)

- (void)KDI_addBlock:(KDIUIControlBlock)block forControlEvents:(UIControlEvents)controlEvents; {
    NSMutableSet *wrappers = self._KDI_controlEventsToBlockWrappers[@(controlEvents)];
    
    if (wrappers == nil) {
        wrappers = [[NSMutableSet alloc] init];
        
        [self._KDI_controlEventsToBlockWrappers setObject:wrappers forKey:@(controlEvents)];
    }
    
    if (controlEvents == UIControlEventTouchUpInside &&
        UIDevice.currentDevice.userInterfaceIdiom == UIUserInterfaceIdiomTV) {
        
        controlEvents = UIControlEventPrimaryActionTriggered;
    }
    
    [wrappers addObject:[[_KDIUIControlBlockWrapper alloc] initWithBlock:block control:self controlEvents:controlEvents]];
}
- (void)KDI_removeBlocksForControlEvents:(UIControlEvents)controlEvents; {
    [self._KDI_controlEventsToBlockWrappers[@(controlEvents)] enumerateObjectsUsingBlock:^(_KDIUIControlBlockWrapper * _Nonnull obj, BOOL * _Nonnull stop) {
        [obj.control removeTarget:obj action:NULL forControlEvents:controlEvents];
    }];
    
    [self._KDI_controlEventsToBlockWrappers removeObjectForKey:@(controlEvents)];
}
- (BOOL)KDI_hasBlocksForControlEvents:(UIControlEvents)controlEvents; {
    return self._KDI_controlEventsToBlockWrappers[@(controlEvents)].count > 0;
}

@end

@implementation UIControl (KDIPrivateExtensions)

@dynamic _KDI_controlEventsToBlockWrappers;
- (NSMutableDictionary<NSNumber *,_KDIUIControlBlockWrapper *> *)_KDI_controlEventsToBlockWrappers {
    id retval = objc_getAssociatedObject(self, _cmd);
    
    if (retval == nil) {
        retval = [[NSMutableDictionary alloc] init];
        
        objc_setAssociatedObject(self, _cmd, retval, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    
    return retval;
}

@end
