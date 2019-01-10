//
//  NSPopUpButton+KDIExtensions.h
//  Ditko
//
//  Created by William Towe on 4/6/17.
//  Copyright © 2019 Kosoku Interactive, LLC. All rights reserved.
//
//  Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
//
//  1. Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
//
//  2. Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
//
//  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

#import <AppKit/AppKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSPopUpButton (KDIExtensions)

/**
 Creates and returns an instance of the receiver configured to be an action button.
 
 @param bordered Whether the receiver should be bordered
 @return The initialized receiver
 */
+ (instancetype)KDI_actionPopUpButtonBordered:(BOOL)bordered;
/**
 Creates and returns an instance of the receiver with the provided title and sets the pullsDown property to pullsDown.
 
 @param title The title of the initial menu item
 @param pullsDown Whether the receiver pulls down
 @return The initialized receiver
 */
+ (instancetype)KDI_popUpButtonWithInitialMenuItemTitle:(NSString *)title pullsDown:(BOOL)pullsDown;

@end

NS_ASSUME_NONNULL_END
