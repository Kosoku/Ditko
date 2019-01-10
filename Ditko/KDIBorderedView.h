//
//  KDIBorderedView.h
//  Ditko
//
//  Created by William Towe on 8/31/17.
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
 Typedef for possible mask options describing the border options of the receiver.
 */
typedef NS_OPTIONS(NSUInteger, KDIBorderOptions) {
    /**
     No borders are displayed.
     */
    KDIBorderOptionsNone = 0,
    /**
     The top border is displayed.
     */
    KDIBorderOptionsTop = 1 << 0,
    /**
     The left border is displayed.
     */
    KDIBorderOptionsLeft = 1 << 1,
    /**
     The bottom border is displayed.
     */
    KDIBorderOptionsBottom = 1 << 2,
    /**
     The right border is displayed.
     */
    KDIBorderOptionsRight = 1 << 3,
    /**
     Top and bottom borders are displayed.
     */
    KDIBorderOptionsTopAndBottom = KDIBorderOptionsTop|KDIBorderOptionsBottom,
    /**
     Left and right borders are displayed.
     */
    KDIBorderOptionsLeftAndRight = KDIBorderOptionsLeft|KDIBorderOptionsRight,
    /**
     All borders are displayed.
     */
    KDIBorderOptionsAll = KDIBorderOptionsTop|KDIBorderOptionsLeft|KDIBorderOptionsBottom|KDIBorderOptionsRight
};

/**
 KDIBorderedView is a protocol that describes a view that can display borders around its content. On iOS, CALayer sublayers are used to display the borders in conforming classes (KDIView, KDITextField, KDITextView, KDIButton, KDILabel). On macOS, drawRect: is overriden to display the borders in conforming classes (KDIView).
 */
@protocol KDIBorderedView <NSObject>
@required
/**
 Set and get the border options of the receiver.
 
 The default is KDIBorderOptionsNone.
 
 @see KDIBorderOptions
 @warning Changes to this property do not affect the intrinsicContentSize of the receiver
 */
@property (assign,nonatomic) KDIBorderOptions borderOptions;
/**
 Set and get the border width of the receiver. This describes the width of vertical borders and the height of horizontal borders. This is distinct from the underlying CALayer borderWidth property.
 
 The default is 1.0.
 
 @warning Changes to this property do not affect the intrinsicContentSize of the receiver
 */
#if (TARGET_OS_IPHONE)
@property (assign,nonatomic) CGFloat borderWidth UI_APPEARANCE_SELECTOR;
#else
@property (assign,nonatomic) CGFloat borderWidth;
#endif
/**
 Set and get whether the borderWidth of the receiver respects the screen scale of the receiver. If YES, this borderWidth will scale appropriately on retina screens. For example, a borderWidth of 1.0 would display as 2.0 on a retina screen.
 
 The default is NO.
 
 @warning Changes to this property do not affect the intrinsicContentSize of the receiver
 */
@property (assign,nonatomic) BOOL borderWidthRespectsScreenScale;
/**
 Set and get the border edge insets of the receiver. This affects how the borders are displayed. They are inset according to this value.
 
 The default is UIEdgeInsetsZero.
 
 @warning Changes to this property do not affect the intrinsicContentSize of the receiver
 */
#if (TARGET_OS_IPHONE)
@property (assign,nonatomic) UIEdgeInsets borderEdgeInsets UI_APPEARANCE_SELECTOR;
#else
@property (assign,nonatomic) NSEdgeInsets borderEdgeInsets;
#endif
/**
 Set and get the border color of the receiver. This affects how the borders are displayed. This is distinct from the underlying CALayer borderColor property.
 
 The default is UIColor.blackColor.
 */
#if (TARGET_OS_IPHONE)
@property (strong,nonatomic,null_resettable) UIColor *borderColor UI_APPEARANCE_SELECTOR;
#else
@property (strong,nonatomic,null_resettable) NSColor *borderColor;
#endif
/**
 Set the border color and optionally animate the change. This animates the underlying CALayer instances that are used to represent the borders.
 
 This is only available on iOS.
 
 @param borderColor The new border color, setting to nil will reset to the default border color
 @param animated Whether to animate the change
 */
#if (TARGET_OS_IPHONE)
- (void)setBorderColor:(nullable UIColor *)borderColor animated:(BOOL)animated;
#endif
@end

NS_ASSUME_NONNULL_END
