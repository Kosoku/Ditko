//
//  KDIFunctions.m
//  Ditko
//
//  Created by William Towe on 3/8/17.
//  Copyright © 2017 Kosoku Interactive, LLC. All rights reserved.
//
//  Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
//
//  1. Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
//
//  2. Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
//
//  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

#import "KDIFunctions.h"

CGSize KDICGSizeAdjustedForMainScreenScale(CGSize size) {
    return KDICGSizeAdjustedForScreenScale(size, nil);
}
#if (TARGET_OS_WATCH)
CGSize KDICGSizeAdjustedForScreenScale(CGSize size, WKInterfaceDevice *screen) {
    if (screen == nil) {
        screen = [WKInterfaceDevice currentDevice];
    }
    
    return CGSizeMake(size.width * screen.screenScale, size.height * screen.screenScale);
}
#elif (TARGET_OS_IOS || TARGET_OS_TV)
CGSize KDICGSizeAdjustedForScreenScale(CGSize size, UIScreen *screen) {
    if (screen == nil) {
        screen = [UIScreen mainScreen];
    }
    
    return CGSizeMake(size.width * screen.scale, size.height * screen.scale);
}
#else
CGSize KDICGSizeAdjustedForScreenScale(CGSize size, NSScreen *screen) {
    if (screen == nil) {
        screen = [NSScreen mainScreen];
    }
    
    return CGSizeMake(size.width * screen.backingScaleFactor, size.height * screen.backingScaleFactor);
}
#endif
