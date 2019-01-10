//
//  KDITextField.m
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
