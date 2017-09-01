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
#import <Ditko/KDIBorderedView.h>

NS_ASSUME_NONNULL_BEGIN

/**
 KDITextField is a UITextField subclass that adds a variety of additional methods. It can display borders (using CALayer sublayers) and inset its text, left, and right views using edge insets.
 */
@interface KDITextField : UITextField <KDIBorderedView>

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
- (CGSize)intrinsicContentSize NS_REQUIRES_SUPER;
- (CGSize)sizeThatFits:(CGSize)size NS_REQUIRES_SUPER;
- (void)layoutSubviews NS_REQUIRES_SUPER;
- (CGRect)textRectForBounds:(CGRect)bounds NS_REQUIRES_SUPER;
- (CGRect)editingRectForBounds:(CGRect)bounds NS_REQUIRES_SUPER;
- (CGRect)leftViewRectForBounds:(CGRect)bounds NS_REQUIRES_SUPER;
- (CGRect)rightViewRectForBounds:(CGRect)bounds NS_REQUIRES_SUPER;

@end

NS_ASSUME_NONNULL_END
