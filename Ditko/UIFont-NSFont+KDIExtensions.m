//
//  UIFont+KDIExtensions.m
//  Ditko
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

#import <TargetConditionals.h>
#if (TARGET_OS_IPHONE)
#import "UIFont+KDIExtensions.h"
#else
#import "NSFont+KDIExtensions.h"
#endif
#import "KDIDefines.h"

#import <CoreText/CoreText.h>

@implementation KDIFont (KDIExtensions)

- (NSCharacterSet *)KDI_characterSet {
    NSCharacterSet *retval = (__bridge_transfer NSCharacterSet *)CTFontCopyCharacterSet((__bridge CTFontRef)self);
    
    return retval;
}

+ (BOOL)KDI_registerFontsForURL:(NSURL *)URL error:(NSError **)error; {
    CFErrorRef outErrorRef;
    if (!CTFontManagerRegisterFontsForURL((__bridge CFURLRef)URL, kCTFontManagerScopeProcess, &outErrorRef)) {
        if (outErrorRef != NULL) {
            NSError *outError = (__bridge_transfer NSError *)outErrorRef;
            
            if (error != NULL) {
                *error = outError;
            }
        }
        return NO;
    }
    return YES;
}

@end
