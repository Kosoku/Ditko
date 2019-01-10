//
//  NSPopUpButton+KDIExtensions.m
//  Ditko
//
//  Created by William Towe on 4/6/17.
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

#import "NSPopUpButton+KDIExtensions.h"

@implementation NSPopUpButton (KDIExtensions)

+ (instancetype)KDI_actionPopUpButtonBordered:(BOOL)bordered; {
    NSPopUpButton *retval = [[self alloc] initWithFrame:NSZeroRect pullsDown:YES];
    
    [retval setBordered:bordered];
    
    if (!retval.bordered) {
        [retval.cell setBackgroundStyle:NSBackgroundStyleRaised];
    }
    
    NSMenuItem *item = [[NSMenuItem alloc] initWithTitle:@"" action:NULL keyEquivalent:@""];
    NSImage *image = [NSImage imageNamed:NSImageNameActionTemplate];
    
    [image setSize:NSMakeSize(16, 16)];
    [item setImage:image];
    
    [(NSPopUpButtonCell *)retval.cell setUsesItemFromMenu:NO];
    [(NSPopUpButtonCell *)retval.cell setMenuItem:item];
    
    [retval.menu addItemWithTitle:@"" action:NULL keyEquivalent:@""];
    
    return retval;
}
+ (instancetype)KDI_popUpButtonWithInitialMenuItemTitle:(NSString *)title pullsDown:(BOOL)pullsDown; {
    NSPopUpButton *retval = [[self alloc] initWithFrame:NSZeroRect pullsDown:pullsDown];
    
    if (title.length > 0) {
        [(NSPopUpButtonCell *)retval.cell setMenuItem:[[NSMenuItem alloc] initWithTitle:title action:NULL keyEquivalent:@""]];
    }
    
    return retval;
}

@end
