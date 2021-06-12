//
//  NSFont+KDIExtensions.h
//  Ditko-macOS
//
//  Created by William Towe on 3/15/18.
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

#import <Cocoa/Cocoa.h>

@interface NSFont (KDIExtensions)

/**
 Returns a character set containing all characters in the receiver.
 */
@property (readonly,nonatomic) NSCharacterSet *KDI_characterSet;

/**
 Attempts to register fonts from the specified URL, returning YES if successful, otherwise NO and an error by reference.
 
 @param URL The URL for which to register fonts
 @error The error to return by reference
 @return YES if the fonts were registered, otherwise NO
 */
+ (BOOL)KDI_registerFontsForURL:(NSURL *)URL error:(NSError **)error;

@end
