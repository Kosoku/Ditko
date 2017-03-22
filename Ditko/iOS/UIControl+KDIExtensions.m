//
//  UIControl+KDIExtensions.m
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
