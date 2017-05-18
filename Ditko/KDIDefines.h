//
//  KDIDefines.h
//  Ditko
//
//  Created by William Towe on 3/10/17.
//  Copyright © 2017 Kosoku Interactive, LLC. All rights reserved.
//
//  Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
//
//  1. Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
//
//  2. Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
//
//  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

#ifndef __KDI_DEFINES__
#define __KDI_DEFINES__

#import <TargetConditionals.h>

#if (TARGET_OS_IPHONE)
#import <UIKit/UIKit.h>

#define KDIColor UIColor
#define KDIFont UIFont
#define KDIImage UIImage
#define KDIRect CGRect
#define KDIRectZero CGRectZero
#define KDISize CGSize
#define KDISizeZero CGSizeZero
#define KDIPoint CGPoint
#define KDIEdgeInsets UIEdgeInsets

#define KDIEdgeInsetsMake(top,left,bottom,right) (UIEdgeInsetsMake(top,left,bottom,right))
#define KDICGImageFromImage(theImage) (theImage.CGImage)
#else
#import <AppKit/AppKit.h>

#define KDIColor NSColor
#define KDIFont NSFont
#define KDIImage NSImage
#define KDIRect NSRect
#define KDIRectZero NSZeroRect
#define KDISize NSSize
#define KDISizeZero NSZeroSize
#define KDIPoint NSPoint
#define KDIEdgeInsets NSEdgeInsets

#define KDIEdgeInsetsMake(top,left,bottom,right) (NSEdgeInsetsMake(top,left,bottom,right))
#define KDICGImageFromImage(theImage) ([theImage CGImageForProposedRect:NULL context:nil hints:nil])
#endif

#endif
