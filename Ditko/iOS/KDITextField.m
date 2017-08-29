//
//  KDITextField.m
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

#import "KDITextField.h"

@implementation KDITextField
#pragma mark *** Subclass Overrides ***
- (void)tintColorDidChange {
    [super tintColorDidChange];
    
    if (self.isFirstResponder) {
        // the selection highlight and caret mirror our tint color, but it won't refresh unless we do this
        [self resignFirstResponder];
        [self becomeFirstResponder];
    }
}
#pragma mark -
- (CGRect)textRectForBounds:(CGRect)bounds {
    CGFloat leftViewWidth = CGRectGetWidth([self leftViewRectForBounds:bounds]);
    CGFloat rightViewWidth = CGRectGetWidth([self rightViewRectForBounds:bounds]);
    CGFloat x = self.leftViewEdgeInsets.left + leftViewWidth + self.leftViewEdgeInsets.right + self.textEdgeInsets.left;
    CGFloat y = self.textEdgeInsets.top;
    CGFloat width = CGRectGetWidth(bounds) - self.leftViewEdgeInsets.left - leftViewWidth - self.leftViewEdgeInsets.right - self.textEdgeInsets.left - self.textEdgeInsets.right - self.rightViewEdgeInsets.left - rightViewWidth - self.rightViewEdgeInsets.right;
    CGFloat height = CGRectGetHeight(bounds) - self.textEdgeInsets.top - self.textEdgeInsets.bottom;
    
    return CGRectMake(x, y, width, height);
}
- (CGRect)editingRectForBounds:(CGRect)bounds {
    return [self textRectForBounds:bounds];
}
- (CGRect)leftViewRectForBounds:(CGRect)bounds {
    CGRect retval = [super leftViewRectForBounds:bounds];
    
    return CGRectMake(self.leftViewEdgeInsets.left, CGRectGetMinY(retval), CGRectGetWidth(retval), CGRectGetHeight(retval));
}
- (CGRect)rightViewRectForBounds:(CGRect)bounds {
    CGRect retval = [super rightViewRectForBounds:bounds];
    
    return CGRectMake(CGRectGetWidth(bounds) - self.rightViewEdgeInsets.right - CGRectGetWidth(retval), CGRectGetMinY(retval), CGRectGetWidth(retval), CGRectGetHeight(retval));
}
#pragma mark *** Public Methods ***
#pragma mark Properties
- (void)setTextEdgeInsets:(UIEdgeInsets)textEdgeInsets {
    _textEdgeInsets = textEdgeInsets;
    
    [self setNeedsLayout];
}
- (void)setLeftViewEdgeInsets:(UIEdgeInsets)leftViewEdgeInsets {
    _leftViewEdgeInsets = leftViewEdgeInsets;
    
    [self setNeedsLayout];
}
- (void)setRightViewEdgeInsets:(UIEdgeInsets)rightViewEdgeInsets {
    _rightViewEdgeInsets = rightViewEdgeInsets;
    
    [self setNeedsLayout];
}

@end
