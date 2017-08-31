//
//  KDITextField.h
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

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/**
 Typedef for possible mask options describing the border options of the receiver.
 */
typedef NS_OPTIONS(NSUInteger, KDITextFieldBorderOptions) {
    /**
     No borders are displayed.
     */
    KDITextFieldBorderOptionsNone = 0,
    /**
     The top border is displayed.
     */
    KDITextFieldBorderOptionsTop = 1 << 0,
    /**
     The left border is displayed.
     */
    KDITextFieldBorderOptionsLeft = 1 << 1,
    /**
     The bottom border is displayed.
     */
    KDITextFieldBorderOptionsBottom = 1 << 2,
    /**
     The right border is displayed.
     */
    KDITextFieldBorderOptionsRight = 1 << 3,
    /**
     Top and bottom borders are displayed.
     */
    KDITextFieldBorderOptionsTopAndBottom = KDITextFieldBorderOptionsTop|KDITextFieldBorderOptionsBottom,
    /**
     Left and right borders are displayed.
     */
    KDITextFieldBorderOptionsLeftAndRight = KDITextFieldBorderOptionsLeft|KDITextFieldBorderOptionsRight,
    /**
     All borders are displayed.
     */
    KDITextFieldBorderOptionsAll = KDITextFieldBorderOptionsTop|KDITextFieldBorderOptionsLeft|KDITextFieldBorderOptionsBottom|KDITextFieldBorderOptionsRight
};

/**
 KDITextField is a UITextField subclass that adds edge insets related methods to control the placement of text. This eliminates the need to use padding views as the left and right views of the receiver.
 */
@interface KDITextField : UITextField

/**
 Set and get the border options of the receiver.
 
 The default is KDITextFieldBorderOptionsNone.
 
 @see KDITextFieldBorderOptions
 */
@property (assign,nonatomic) KDITextFieldBorderOptions borderOptions;
/**
 Set and get the border width of the receiver. This describes the width of vertical borders and the height of horizontal borders. This is distinct from the underlying CALayer borderWidth property.
 
 The default is 1.0.
 */
@property (assign,nonatomic) CGFloat borderWidth UI_APPEARANCE_SELECTOR;
/**
 Set and get whether the borderWidth of the receiver respects the screen scale of the receiver. If YES, this borderWidth will scale appropriately on retina screens. For example, a borderWidth of 1.0 would display as 2.0 on a retina screen.
 
 The default is NO.
 */
@property (assign,nonatomic) BOOL borderWidthRespectsScreenScale;
/**
 Set and get the border edge insets of the receiver. This affects how the borders are displayed. They are inset according to this value.
 
 The default is UIEdgeInsetsZero.
 */
@property (assign,nonatomic) UIEdgeInsets borderEdgeInsets UI_APPEARANCE_SELECTOR;
/**
 Set and get the border color of the receiver. This affects how the borders are displayed. This is distinct from the underlying CALayer borderColor property.
 
 The default is UIColor.blackColor.
 */
@property (strong,nonatomic,null_resettable) UIColor *borderColor UI_APPEARANCE_SELECTOR;

/**
 Set and get the text edge insets of the receiver. This value affects the return values of textRectForBounds: and editingRectForBounds:.
 
 The default is UIEdgeInsetsZero.
 */
@property (assign,nonatomic) UIEdgeInsets textEdgeInsets UI_APPEARANCE_SELECTOR;

/**
 Set and get the left view edge insets of the receiver. This value affects the return value of leftViewRectForBounds:.
 
 The default is UIEdgeInsetsZero.
 */
@property (assign,nonatomic) UIEdgeInsets leftViewEdgeInsets UI_APPEARANCE_SELECTOR;
/**
 Set and get the right view edge insets of the receiver. This value affects the return value of rightViewRectForBounds:.
 
 The default is UIEdgeInsetsZero.
 */
@property (assign,nonatomic) UIEdgeInsets rightViewEdgeInsets UI_APPEARANCE_SELECTOR;

- (void)tintColorDidChange NS_REQUIRES_SUPER;
- (void)layoutSubviews NS_REQUIRES_SUPER;
- (CGRect)textRectForBounds:(CGRect)bounds NS_REQUIRES_SUPER;
- (CGRect)leftViewRectForBounds:(CGRect)bounds NS_REQUIRES_SUPER;
- (CGRect)rightViewRectForBounds:(CGRect)bounds NS_REQUIRES_SUPER;

@end

NS_ASSUME_NONNULL_END
