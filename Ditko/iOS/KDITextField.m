//
//  KDITextField.m
//  Ditko
//
//  Created by William Towe on 3/10/17.
//  Copyright © 2019 Kosoku Interactive, LLC. All rights reserved.
//
//  Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
//
//  1. Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
//
//  2. Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
//
//  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

#import "KDITextField.h"
#import "KDIBorderedViewImpl.h"

#import <Stanley/KSTScopeMacros.h>

@interface KDITextField ()
@property (strong,nonatomic) KDIBorderedViewImpl *borderedViewImpl;

- (void)_KDITextFieldInit;
- (CGSize)_sizeThatFits:(CGSize)size layout:(BOOL)layout;
@end

@implementation KDITextField
#pragma mark *** Subclass Overrides ***
- (instancetype)initWithFrame:(CGRect)frame {
    if (!(self = [super initWithFrame:frame]))
        return nil;
    
    [self _KDITextFieldInit];
    
    return self;
}
- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (!(self = [super initWithCoder:aDecoder]))
        return nil;
    
    [self _KDITextFieldInit];
    
    return self;
}
#pragma mark -
- (id)forwardingTargetForSelector:(SEL)aSelector {
    if ([self.borderedViewImpl respondsToSelector:aSelector]) {
        return self.borderedViewImpl;
    }
    return [super forwardingTargetForSelector:aSelector];
}
#pragma mark -
- (BOOL)becomeFirstResponder {
    [self willChangeValueForKey:@kstKeypath(self,isFirstResponder)];
    
    BOOL retval = [super becomeFirstResponder];
    
    [self didChangeValueForKey:@kstKeypath(self,isFirstResponder)];
    
    [self firstResponderDidChange];
    
    [NSNotificationCenter.defaultCenter postNotificationName:KDIUIResponderNotificationDidBecomeFirstResponder object:self];
    
    return retval;
}
- (BOOL)resignFirstResponder {
    [self willChangeValueForKey:@kstKeypath(self,isFirstResponder)];
    
    BOOL retval = [super resignFirstResponder];
    
    [self didChangeValueForKey:@kstKeypath(self,isFirstResponder)];
    
    [self firstResponderDidChange];
    
    [NSNotificationCenter.defaultCenter postNotificationName:KDIUIResponderNotificationDidResignFirstResponder object:self];
    
    return retval;
}
#pragma mark -
- (void)tintColorDidChange {
    [super tintColorDidChange];
    
    if (self.isFirstResponder) {
        // the selection highlight and caret mirror our tint color, but it won't refresh unless we do this
        [self resignFirstResponder];
        [self becomeFirstResponder];
    }
}
#pragma mark -
- (CGSize)intrinsicContentSize {
    return [self _sizeThatFits:[super intrinsicContentSize] layout:NO];
}
- (CGSize)sizeThatFits:(CGSize)size {
    return [self _sizeThatFits:[super sizeThatFits:size] layout:NO];
}
#pragma mark -
- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self _sizeThatFits:self.bounds.size layout:YES];
}
#pragma mark -
- (CGRect)textRectForBounds:(CGRect)bounds {
    BOOL leftViewVisible = self.leftViewMode == UITextFieldViewModeAlways || (self.isEditing && self.leftViewMode == UITextFieldViewModeWhileEditing) || (!self.isEditing && self.leftViewMode == UITextFieldViewModeUnlessEditing);
    BOOL rightViewVisible = self.rightViewMode == UITextFieldViewModeAlways || (self.isEditing && self.rightViewMode == UITextFieldViewModeWhileEditing) || (!self.isEditing && self.rightViewMode == UITextFieldViewModeUnlessEditing);
    CGFloat leftViewWidth = CGRectGetWidth([self leftViewRectForBounds:bounds]);
    CGFloat rightViewWidth = CGRectGetWidth([self rightViewRectForBounds:bounds]);
    CGFloat x = self.textEdgeInsets.left;
    
    if (leftViewVisible) {
        x += self.leftViewEdgeInsets.left + leftViewWidth + self.leftViewEdgeInsets.right;
    }
    
    CGFloat y = self.textEdgeInsets.top;
    CGFloat width = CGRectGetWidth(bounds) - self.textEdgeInsets.left - self.textEdgeInsets.right;
    
    if (leftViewVisible) {
        width -= self.leftViewEdgeInsets.left + leftViewWidth + self.leftViewEdgeInsets.right;
    }
    if (rightViewVisible) {
        width -= self.rightViewEdgeInsets.left + rightViewWidth + self.rightViewEdgeInsets.right;
    }
    
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
#pragma mark KDIBorderedView
@dynamic borderOptions;
@dynamic borderWidth;
@dynamic borderWidthRespectsScreenScale;
@dynamic borderEdgeInsets;
@dynamic borderColor;
- (void)setBorderColor:(UIColor *)borderColor animated:(BOOL)animated {
    [self.borderedViewImpl setBorderColor:borderColor animated:animated];
}
#pragma mark KDIUIResponder
- (void)firstResponderDidChange; {
    
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
#pragma mark *** Private Methods ***
- (void)_KDITextFieldInit; {
    _borderedViewImpl = [[KDIBorderedViewImpl alloc] initWithView:self];
}
#pragma mark -
- (CGSize)_sizeThatFits:(CGSize)size layout:(BOOL)layout; {
    CGSize retval = size;
    CGFloat leftViewHeight = self.leftViewEdgeInsets.top + CGRectGetHeight(self.leftView.frame) + self.leftViewEdgeInsets.bottom;
    CGFloat textHeight = size.height;
    CGFloat rightViewHeight = self.rightViewEdgeInsets.top + CGRectGetHeight(self.rightView.frame) + self.rightViewEdgeInsets.bottom;
    
    retval.height = MAX(textHeight, MAX(leftViewHeight, rightViewHeight));
    
    if (layout) {
        [self.borderedViewImpl layoutSubviews];
    }
    
    return retval;
}

@end
