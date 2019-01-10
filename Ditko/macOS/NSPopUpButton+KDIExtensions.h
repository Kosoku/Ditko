//
//  NSPopUpButton+KDIExtensions.h
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
