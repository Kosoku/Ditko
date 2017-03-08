//
//  KDIColorMacros.h
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

#ifndef __KDI_COLOR_MACROS__
#define __KDI_COLOR_MACROS__

#import <TargetConditionals.h>

#if (TARGET_OS_IPHONE)
#import "UIColor+KDIExtensions.h"
#else
#import "NSColor+KDIExtensions.h"
#endif

/**
 Alias for KDIColorWA(), passing *w* and 1.0 respectively.
 */
#define KDIColorW(w) KDIColorWA((w),1.0)
/**
 Alias for `+[UIColor colorWithWhite:alpha:]` or `+[NSColor colorWithCalibratedWhite:alpha:]`, passing *w* and *a* respectively.
 */
#if (TARGET_OS_IPHONE)
#define KDIColorWA(w,a) [UIColor colorWithWhite:(w) alpha:(a)]
#else
#define KDIColorWA(w,a) [NSColor colorWithCalibratedWhite:(w) alpha:(a)]
#endif

/**
 Alias for KDIColorRGBA(), passing *r*, *g*, *b*, and 1.0 respectively.
 */
#define KDIColorRGB(r,g,b) KDIColorRGBA((r),(g),(b),1.0)
/**
 Alias for `+[UIColor colorWithRed:green:blue:alpha:]` or `+[NSColor colorWithCalibratedRed:green:blue:alpha:]`, passing *r*, *g*, *b*, and *a* respectively.
 */
#if (TARGET_OS_IPHONE)
#define KDIColorRGBA(r,g,b,a) [UIColor colorWithRed:(r) green:(g) blue:(b) alpha:(a)]
#else
#define KDIColorRGBA(r,g,b,a) [NSColor colorWithCalibratedRed:(r) green:(g) blue:(b) alpha:(a)]
#endif

/**
 Alias for `+[UIColor KDI_colorRandomRGB]` or `+[NSColor KDI_colorRandomRGB]`.
 */
#if (TARGET_OS_IPHONE)
#define KDIColorRandomRGB() [UIColor KDI_colorRandomRGB]
#else
#define KDIColorRandomRGB() [NSColor KDI_colorRandomRGB]
#endif
/**
 Alias for `+[UIColor KDI_colorRandomRGBA]` or `+[NSColor KDI_colorRandomRGBA]`.
 */
#if (TARGET_OS_IPHONE)
#define KDIColorRandomRGBA() [UIColor KDI_colorRandomRGBA]
#else
#define KDIColorRandomRGBA() [NSColor KDI_colorRandomRGBA]
#endif

/**
 Alias for KDIColorHSBA(), passing *h*, *s*, *b*, and 1.0 respectively.
 */
#define KDIColorHSB(h,s,b) KDIColorHSBA((h),(s),(b),1.0)
/**
 Alias for `+[UIColor colorWithHue:saturation:brightness:alpha:]` or `+[NSColor colorWithCalibratedHue:saturation:brightness:alpha:]`, passing *h*, *s*, *b*, and *a* respectively.
 */
#if (TARGET_OS_IPHONE)
#define KDIColorHSBA(h,s,b,a) [UIColor colorWithHue:(h) saturation:(s) brightness:(b) alpha:(a)]
#else
#define KDIColorHSBA(h,s,b,a) [NSColor colorWithCalibratedHue:(h) saturation:(s) brightness:(b) alpha:(a)]
#endif

/**
 Alias for `+[UIColor KDI_colorWithHexadecimalString:]` or `+[NSColor KDI_colorWithHexadecimalString:]`, passing *s*.
 */
#if (TARGET_OS_IPHONE)
#define KDIColorHexadecimal(s) [UIColor KDI_colorWithHexadecimalString:(s)]
#else
#define KDIColorHexadecimal(s) [NSColor KDI_colorWithHexadecimalString:(s)]
#endif

#endif
