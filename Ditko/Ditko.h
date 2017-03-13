//
//  Ditko.h
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

#import <TargetConditionals.h>

#if (TARGET_OS_IPHONE)
#import <UIKit/UIKit.h>
#else
#import <AppKit/AppKit.h>
#endif

//! Project version number for Ditko.
FOUNDATION_EXPORT double DitkoVersionNumber;

//! Project version string for Ditko.
FOUNDATION_EXPORT const unsigned char DitkoVersionString[];

// In this header, you should import all the public headers of your framework using statements like #import <Ditko/PublicHeader.h>

#import <Ditko/KDIColorMacros.h>

#import <Ditko/KDIFunctions.h>

#import <Ditko/NSURL+KDIExtensions.h>
#import <Ditko/NSParagraphStyle+KDIExtensions.h>
#if (TARGET_OS_IOS || TARGET_OS_TV || TARGET_OS_WATCH)
#import <Ditko/UIBezierPath+KDIExtensions.h>
#endif
#if (TARGET_OS_IOS || TARGET_OS_TV)
#import <Ditko/UIBarButtonItem+KDIExtensions.h>
#import <Ditko/UIDevice+KDIExtensions.h>
#import <Ditko/UINavigationController+KDIExtensions.h>
#import <Ditko/UIView+KDIExtensions.h>
#import <Ditko/UIViewController+KDIExtensions.h>
#import <Ditko/UIAlertController+KDIExtensions.h>
#endif
#if (TARGET_OS_OSX)
#import <Ditko/NSView+KDIExtensions.h>
#import <Ditko/NSViewController+KDIExtensions.h>
#import <Ditko/NSWindow+KDIExtensions.h>
#import <Ditko/NSBezierPath+KDIExtensions.h>
#import <Ditko/NSAlert+KDIExtensions.h>
#endif

#if (TARGET_OS_IOS || TARGET_OS_TV || TARGET_OS_OSX)
#import <Ditko/KDIView.h>
#import <Ditko/KDIGradientView.h>
#import <Ditko/KDIBadgeView.h>
#endif
#if (TARGET_OS_IOS || TARGET_OS_TV)
#import <Ditko/KDILabel.h>
#import <Ditko/KDITextField.h>
#import <Ditko/KDITextView.h>
#import <Ditko/KDIProgressNavigationBar.h>
#import <Ditko/KDIButton.h>
#endif
#if (TARGET_OS_IOS)
#import <Ditko/KDIProgressSlider.h>
#import <Ditko/KDIPickerViewButton.h>
#import <Ditko/KDIDatePickerButton.h>
#endif
