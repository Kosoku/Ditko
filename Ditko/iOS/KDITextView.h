//
//  KDITextView.h
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
 KDITextView is a UITextView subclass that provides placeholder functionality like UITextField. It also conforms to KDIBorderedView, allowing it to display borders.
 */
@interface KDITextView : UITextView <KDIBorderedView,KDIUIResponder>

/**
 Set and get whether the placeholder is allowed to wrap to multiple lines.
 
 The default is YES.
 */
@property (assign,nonatomic) BOOL allowsMultilinePlaceholder;
/**
 Set and get text view's placeholder text.
 
 The default is nil.
 */
@property (copy,nonatomic,nullable) NSString *placeholder;
/**
 Set and get text view's attributed placeholder text.
 
 The default is nil.
 */
@property (copy,nonatomic,nullable) NSAttributedString *attributedPlaceholder;

/**
 Set and get the placeholder text color, which is used when setting the placeholder via `setPlaceholder:`.
 
 The default is UIColor.lightGrayColor.
 */
@property (strong,nonatomic,null_resettable) UIColor *placeholderTextColor UI_APPEARANCE_SELECTOR;

/**
 Set and get the minimum height of the receiver.
 
 The default is 0.0.
 */
@property (assign,nonatomic) CGFloat minimumHeight;
/**
 Set and get the maximum height of the receiver.
 
 The default is 0.0.
 */
@property (assign,nonatomic) CGFloat maximumHeight;

/**
 Set and get the minimum number of lines that should be displayed in the receiver.
 
 The default is 0.
 */
@property (assign,nonatomic) NSUInteger minimumNumberOfLines;
/**
 Set and get the maximum number of lines that should be displayed in the receiver.
 
 The default is 0.
 */
@property (assign,nonatomic) NSUInteger maximumNumberOfLines;

- (BOOL)becomeFirstResponder NS_REQUIRES_SUPER;
- (BOOL)resignFirstResponder NS_REQUIRES_SUPER;
- (void)tintColorDidChange NS_REQUIRES_SUPER;
- (void)didAddSubview:(UIView *)subview NS_REQUIRES_SUPER;
- (void)layoutSubviews NS_REQUIRES_SUPER;

@end

NS_ASSUME_NONNULL_END
