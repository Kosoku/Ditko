//
//  KDIBorderedView.h
//  Ditko
//
//  Created by William Towe on 8/31/17.
//  Copyright © 2019 Kosoku Interactive, LLC. All rights reserved.
//
//  Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
//
//  1. Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
//
//  2. Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
//
//  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

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
