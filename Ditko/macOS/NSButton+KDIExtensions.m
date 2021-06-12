//
//  NSButton+KDIExtensions.m
//  Ditko
//
//  Created by William Towe on 4/6/17.
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

#import "NSButton+KDIExtensions.h"

@implementation NSButton (KDIExtensions)

+ (instancetype)KDI_buttonWithTitle:(NSString *)title bezelStyle:(NSBezelStyle)bezelStyle; {
    NSButton *retval = [[self alloc] initWithFrame:NSZeroRect];
    
    [retval setTitle:title];
    [retval setBezelStyle:bezelStyle];
    [retval setButtonType:NSButtonTypeMomentaryPushIn];
    [retval setFont:[NSFont messageFontOfSize:0.0]];
    
    return retval;
}
+ (instancetype)KDI_checkBoxWithTitle:(NSString *)title; {
    NSButton *retval = [[self alloc] initWithFrame:NSZeroRect];
    
    [retval setTitle:title];
    [retval setButtonType:NSButtonTypeSwitch];
    [retval setFont:[NSFont messageFontOfSize:0.0]];
    
    return retval;
}

@end
