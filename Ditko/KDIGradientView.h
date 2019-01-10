//
//  KDIGradientView.h
//  Ditko
//
//  Created by William Towe on 3/8/17.
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

#import <Ditko/KDIDefines.h>

NS_ASSUME_NONNULL_BEGIN

/**
 KDIGradientView is a UIView/NSView subclass that manages a CAGradientLayer and provides convenience methods to access the layer's properties.
 */
#if (TARGET_OS_IPHONE)
@interface KDIGradientView : UIView
#else
@interface KDIGradientView : NSView
#endif

/**
 Set and get the colors of the underlying CAGradientLayer.
 
 The array should contain either UIColor or NSColor instances.
 */
@property (copy,nonatomic,nullable) NSArray<KDIColor *> *colors;

/**
 Set and get the locations of the underlying CAGradientLayer.
 
 The gradient stops are specified as values between 0 and 1. The values must be monotonically increasing. If nil, the stops are spread uniformly across the range. Defaults to nil.
 */
@property (copy,nonatomic,nullable) NSArray<NSNumber *> *locations;

/**
 The start point of the underlying CAGradientLayer.
 
 The point is defined in unit coordinate space.
 */
@property (assign,nonatomic) KDIPoint startPoint;

/**
 The end point of the underlying CAGradientLayer.
 
 The point is defined in the unit coordinate space.
 */
@property (assign,nonatomic) KDIPoint endPoint;

@end

NS_ASSUME_NONNULL_END
