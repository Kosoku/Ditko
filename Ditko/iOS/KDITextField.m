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

@interface KDITextField ()
@property (strong,nonatomic) CALayer *topBorderLayer, *leftBorderLayer, *bottomBorderLayer, *rightBorderLayer;

- (void)_KDITextFieldInit;
- (void)_configureBorderLayer:(CALayer *)layer;

+ (UIColor *)_defaultBorderColor;
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
- (void)tintColorDidChange {
    [super tintColorDidChange];
    
    if (self.isFirstResponder) {
        // the selection highlight and caret mirror our tint color, but it won't refresh unless we do this
        [self resignFirstResponder];
        [self becomeFirstResponder];
    }
}
- (void)layoutSubviews {
    [super layoutSubviews];
    
    if (self.window.screen == nil) {
        return;
    }
    
    CGFloat borderWidth = self.borderWidthRespectsScreenScale ? self.borderWidth : self.borderWidth / self.window.screen.scale;
    
    [CATransaction begin];
    [CATransaction setDisableActions:YES];
    
    [self.topBorderLayer setFrame:CGRectMake(self.borderEdgeInsets.left, self.borderEdgeInsets.top, CGRectGetWidth(self.bounds) - self.borderEdgeInsets.left - self.borderEdgeInsets.right, borderWidth)];
    [self.leftBorderLayer setFrame:CGRectMake(self.borderEdgeInsets.left, self.borderEdgeInsets.top, borderWidth, CGRectGetHeight(self.bounds) - self.borderEdgeInsets.top - self.borderEdgeInsets.bottom)];
    [self.bottomBorderLayer setFrame:CGRectMake(self.borderEdgeInsets.left, CGRectGetHeight(self.bounds) - self.borderEdgeInsets.bottom - borderWidth, CGRectGetWidth(self.bounds) - self.borderEdgeInsets.left - self.borderEdgeInsets.right, borderWidth)];
    [self.rightBorderLayer setFrame:CGRectMake(CGRectGetWidth(self.bounds) - self.borderEdgeInsets.right - borderWidth, self.borderEdgeInsets.top, borderWidth, CGRectGetHeight(self.bounds) - self.borderEdgeInsets.top - self.borderEdgeInsets.bottom)];
    
    [CATransaction commit];
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
- (void)setBorderOptions:(KDITextFieldBorderOptions)borderOptions {
    _borderOptions = borderOptions;
    
    if (_borderOptions & KDITextFieldBorderOptionsTop) {
        if (self.topBorderLayer == nil) {
            [self setTopBorderLayer:[CALayer layer]];
            [self _configureBorderLayer:self.topBorderLayer];
            [self.layer addSublayer:self.topBorderLayer];
        }
    }
    else {
        [self.topBorderLayer removeFromSuperlayer];
        [self setTopBorderLayer:nil];
    }
    
    if (_borderOptions & KDITextFieldBorderOptionsLeft) {
        if (self.leftBorderLayer == nil) {
            [self setLeftBorderLayer:[CALayer layer]];
            [self _configureBorderLayer:self.leftBorderLayer];
            [self.layer addSublayer:self.leftBorderLayer];
        }
    }
    else {
        [self.leftBorderLayer removeFromSuperlayer];
        [self setLeftBorderLayer:nil];
    }
    
    if (_borderOptions & KDITextFieldBorderOptionsBottom) {
        if (self.bottomBorderLayer == nil) {
            [self setBottomBorderLayer:[CALayer layer]];
            [self _configureBorderLayer:self.bottomBorderLayer];
            [self.layer addSublayer:self.bottomBorderLayer];
        }
    }
    else {
        [self.bottomBorderLayer removeFromSuperlayer];
        [self setBottomBorderLayer:nil];
    }
    
    if (_borderOptions & KDITextFieldBorderOptionsRight) {
        if (self.rightBorderLayer == nil) {
            [self setRightBorderLayer:[CALayer layer]];
            [self _configureBorderLayer:self.rightBorderLayer];
            [self.layer addSublayer:self.rightBorderLayer];
        }
    }
    else {
        [self.rightBorderLayer removeFromSuperlayer];
        [self setRightBorderLayer:nil];
    }
}
- (void)setBorderWidth:(CGFloat)borderWidth {
    _borderWidth = borderWidth;
    
    [self setNeedsLayout];
}
- (void)setBorderWidthRespectsScreenScale:(BOOL)borderWidthRespectsScreenScale {
    _borderWidthRespectsScreenScale = borderWidthRespectsScreenScale;
    
    [self setNeedsLayout];
}
- (void)setBorderEdgeInsets:(UIEdgeInsets)borderEdgeInsets {
    _borderEdgeInsets = borderEdgeInsets;
    
    [self setNeedsLayout];
}
- (void)setBorderColor:(UIColor *)borderColor {
    _borderColor = borderColor ?: [self.class _defaultBorderColor];
    
    [CATransaction begin];
    [CATransaction setDisableActions:YES];
    
    for (CALayer *layer in @[self.topBorderLayer,self.leftBorderLayer,self.bottomBorderLayer,self.rightBorderLayer]) {
        [layer setBackgroundColor:_borderColor.CGColor];
    }
    
    [CATransaction commit];
}
#pragma mark -
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
    _borderColor = [self.class _defaultBorderColor];
    _borderWidth = 1.0;
}
#pragma mark -
- (void)_configureBorderLayer:(CALayer *)layer; {
    [layer setBackgroundColor:self.borderColor.CGColor];
}
#pragma mark -
+ (UIColor *)_defaultBorderColor; {
    return UIColor.blackColor;
}

@end
