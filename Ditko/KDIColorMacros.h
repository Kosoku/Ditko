//
//  KDIColorMacros.h
//  Ditko
//
//  Created by William Towe on 3/8/17.
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

#ifndef __KDI_COLOR_MACROS__
#define __KDI_COLOR_MACROS__

#import <TargetConditionals.h>

#if (TARGET_OS_IPHONE)
#import <Ditko/UIColor+KDIExtensions.h>
#else
#import <Ditko/NSColor+KDIExtensions.h>
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
 Alias for `+[UIColor KDI_colorRandomHSB]` or `+[NSColor KDI_colorRandomHSB]`.
 */
#if (TARGET_OS_IPHONE)
#define KDIColorRandomHSB() [UIColor KDI_colorRandomHSB]
#else
#define KDIColorRandomHSB() [NSColor KDI_colorRandomHSB]
#endif
/**
 Alias for `+[UIColor KDI_colorRandomHSBA]` or `+[NSColor KDI_colorRandomHSBA]`.
 */
#if (TARGET_OS_IPHONE)
#define KDIColorRandomHSBA() [UIColor KDI_colorRandomHSBA]
#else
#define KDIColorRandomHSBA() [NSColor KDI_colorRandomHSBA]
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
