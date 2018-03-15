//
//  UIFont+KDIExtensions.m
//  Ditko
//
//  Created by William Towe on 3/15/18.
//  Copyright © 2018 Kosoku Interactive, LLC. All rights reserved.
//
//  Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
//
//  1. Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
//
//  2. Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
//
//  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

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
