//
//  KDIDefines.h
//  Ditko
//
//  Created by William Towe on 3/10/17.
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
#define KDIViewClass UIView

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
#define KDIViewClass NSView

#define KDIEdgeInsetsMake(top,left,bottom,right) (NSEdgeInsetsMake(top,left,bottom,right))
#define KDICGImageFromImage(theImage) ([theImage CGImageForProposedRect:NULL context:nil hints:nil])
#endif

#endif
