//
//  NSButton+KDIExtensions.h
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

@interface NSButton (KDIExtensions)

/**
 Creates and returns an instance of the receiver with the provided title and bezelStyle and the buttonType set to NSButtonTypeMomentaryPushIn.
 
 @param title The title of the button
 @param bezelStyle The bezel style of the button
 @return The initialized receiver
 */
+ (instancetype)KDI_buttonWithTitle:(NSString *)title bezelStyle:(NSBezelStyle)bezelStyle;
/**
 Creates and returns an instance of the receiver with the provided title and the buttonType set to NSButtonTypeSwitch.
 
 @param title The title of the button
 @return The initialized receiver
 */
+ (instancetype)KDI_checkBoxWithTitle:(NSString *)title;

@end

NS_ASSUME_NONNULL_END
