//
//  KDILabel.h
//  Ditko
//
//  Created by William Towe on 3/10/17.
//  Copyright © 2018 Kosoku Interactive, LLC. All rights reserved.
//
//  Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
//
//  1. Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
//
//  2. Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
//
//  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

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
