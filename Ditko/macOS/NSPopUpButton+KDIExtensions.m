//
//  NSPopUpButton+KDIExtensions.m
//  Ditko
//
//  Created by William Towe on 4/6/17.
//  Copyright © 2018 Kosoku Interactive, LLC. All rights reserved.
//
//  Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
//
//  1. Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
//
//  2. Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
//
//  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

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
