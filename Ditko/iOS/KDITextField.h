//
//  KDITextField.h
//  Ditko
//
//  Created by William Towe on 3/10/17.
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

#import <Ditko/KDIBorderedView.h>
#import <Ditko/KDIUIResponder.h>

NS_ASSUME_NONNULL_BEGIN

/**
 KDITextField is a UITextField subclass that adds edge inset methods to adjust the layout of the text, left, and right views respectively. It also conforms to KDIBorderedView, allowing it to display borders.
 */
@interface KDITextField : UITextField <KDIBorderedView,KDIUIResponder>

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

- (BOOL)becomeFirstResponder NS_REQUIRES_SUPER;
- (BOOL)resignFirstResponder NS_REQUIRES_SUPER;
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
