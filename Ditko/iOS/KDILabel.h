//
//  KDILabel.h
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

#import <Ditko/KDIBorderedView.h>

NS_ASSUME_NONNULL_BEGIN

/**
 KDILabel is a UILabel subclass adds an edgeInsets property to add padding around its text. It also conforms to KDIBorderedView, allowing it to display borders.
 */
@interface KDILabel : UILabel <KDIBorderedView>

/**
 Set and get whether the receiver can copy the value of its text property to the pasteboard. If YES, when the receiver is long pressed on, it will show the edit menu via UIMenuController with the Copy item.
 
 The default is NO.
 */
#if (TARGET_OS_IOS)
@property (assign,nonatomic,getter=isCopyable) BOOL copyable;
#endif

/**
 Set and get the edge insets of the receiver. They affect how text is drawn using drawTextInRect:.
 
 The default is UIEdgeInsetsZero.
 */
@property (assign,nonatomic) UIEdgeInsets edgeInsets UI_APPEARANCE_SELECTOR;

- (void)layoutSubviews NS_REQUIRES_SUPER;
- (CGSize)intrinsicContentSize NS_REQUIRES_SUPER;
- (CGSize)sizeThatFits:(CGSize)size NS_REQUIRES_SUPER;
- (void)drawTextInRect:(CGRect)rect NS_REQUIRES_SUPER;

@end

NS_ASSUME_NONNULL_END
