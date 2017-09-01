//
//  KDIBorderedViewImpl.m
//  Ditko
//
//  Created by William Towe on 8/31/17.
//  Copyright © 2017 Kosoku Interactive, LLC. All rights reserved.
//
//  Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
//
//  1. Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
//
//  2. Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
//
//  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

#import "KDIBorderedViewImpl.h"

#import <Stanley/KSTScopeMacros.h>

@interface KDIBorderedViewImpl ()
@property (weak,nonatomic) KDIViewClass *view;
@property (strong,nonatomic) CALayer *topBorderLayer, *leftBorderLayer, *bottomBorderLayer, *rightBorderLayer;

- (void)_configureBorderLayer:(CALayer *)layer;
+ (UIColor *)_defaultBorderColor;
@end

@implementation KDIBorderedViewImpl

@synthesize borderOptions=_borderOptions;
- (void)setBorderOptions:(KDIBorderOptions)borderOptions {
    _borderOptions = borderOptions;
    
    if (_borderOptions & KDIBorderOptionsTop) {
        if (self.topBorderLayer == nil) {
            [self setTopBorderLayer:[CALayer layer]];
            [self _configureBorderLayer:self.topBorderLayer];
            [self.view.layer addSublayer:self.topBorderLayer];
        }
    }
    else {
        [self.topBorderLayer removeFromSuperlayer];
        [self setTopBorderLayer:nil];
    }
    
    if (_borderOptions & KDIBorderOptionsLeft) {
        if (self.leftBorderLayer == nil) {
            [self setLeftBorderLayer:[CALayer layer]];
            [self _configureBorderLayer:self.leftBorderLayer];
            [self.view.layer addSublayer:self.leftBorderLayer];
        }
    }
    else {
        [self.leftBorderLayer removeFromSuperlayer];
        [self setLeftBorderLayer:nil];
    }
    
    if (_borderOptions & KDIBorderOptionsBottom) {
        if (self.bottomBorderLayer == nil) {
            [self setBottomBorderLayer:[CALayer layer]];
            [self _configureBorderLayer:self.bottomBorderLayer];
            [self.view.layer addSublayer:self.bottomBorderLayer];
        }
    }
    else {
        [self.bottomBorderLayer removeFromSuperlayer];
        [self setBottomBorderLayer:nil];
    }
    
    if (_borderOptions & KDIBorderOptionsRight) {
        if (self.rightBorderLayer == nil) {
            [self setRightBorderLayer:[CALayer layer]];
            [self _configureBorderLayer:self.rightBorderLayer];
            [self.view.layer addSublayer:self.rightBorderLayer];
        }
    }
    else {
        [self.rightBorderLayer removeFromSuperlayer];
        [self setRightBorderLayer:nil];
    }
}
@synthesize borderWidth=_borderWidth;
- (void)setBorderWidth:(CGFloat)borderWidth {
    _borderWidth = borderWidth;
    
    [self.view setNeedsLayout];
}
@synthesize borderWidthRespectsScreenScale=_borderWidthRespectsScreenScale;
- (void)setBorderWidthRespectsScreenScale:(BOOL)borderWidthRespectsScreenScale {
    _borderWidthRespectsScreenScale = borderWidthRespectsScreenScale;
    
    [self.view setNeedsLayout];
}
@synthesize borderEdgeInsets=_borderEdgeInsets;
- (void)setBorderEdgeInsets:(UIEdgeInsets)borderEdgeInsets {
    _borderEdgeInsets = borderEdgeInsets;
    
    [self.view setNeedsLayout];
}
@synthesize borderColor=_borderColor;
- (void)setBorderColor:(UIColor *)borderColor {
    [self setBorderColor:borderColor animated:NO];
}
- (void)setBorderColor:(UIColor *)borderColor animated:(BOOL)animated {
    [self willChangeValueForKey:@kstKeypath(self,borderColor)];
    
    _borderColor = borderColor ?: [self.class _defaultBorderColor];
    
    [self didChangeValueForKey:@kstKeypath(self,borderColor)];
    
    [CATransaction begin];
    [CATransaction setDisableActions:!animated];
    
    [self.topBorderLayer setBackgroundColor:_borderColor.CGColor];
    [self.leftBorderLayer setBackgroundColor:_borderColor.CGColor];
    [self.bottomBorderLayer setBackgroundColor:_borderColor.CGColor];
    [self.rightBorderLayer setBackgroundColor:_borderColor.CGColor];
    
    [CATransaction commit];
}

- (instancetype)initWithView:(KDIViewClass<KDIBorderedView> *)view {
    if (!(self = [super init]))
        return nil;
    
    _view = view;
    _borderColor = [self.class _defaultBorderColor];
    _borderWidth = 1.0;
    
    return self;
}

- (void)layoutSubviews {
    if (self.view.window.screen != nil) {
        CGFloat borderWidth = self.borderWidthRespectsScreenScale ? self.borderWidth : self.borderWidth / self.view.window.screen.scale;
        
        [CATransaction begin];
        [CATransaction setDisableActions:YES];
        
        if ([self.view isKindOfClass:UIScrollView.class]) {
            UIScrollView *scrollView = (UIScrollView *)self.view;
            
            [self.topBorderLayer setFrame:CGRectMake(scrollView.contentOffset.x + self.borderEdgeInsets.left, scrollView.contentOffset.y + self.borderEdgeInsets.top, CGRectGetWidth(self.view.bounds) - self.borderEdgeInsets.left - self.borderEdgeInsets.right, borderWidth)];
            [self.leftBorderLayer setFrame:CGRectMake(scrollView.contentOffset.x + self.borderEdgeInsets.left, scrollView.contentOffset.y + self.borderEdgeInsets.top, borderWidth, CGRectGetHeight(self.view.bounds) - self.borderEdgeInsets.top - self.borderEdgeInsets.bottom)];
            [self.bottomBorderLayer setFrame:CGRectMake(scrollView.contentOffset.x + self.borderEdgeInsets.left, scrollView.contentOffset.y + CGRectGetHeight(self.view.bounds) - self.borderEdgeInsets.bottom - borderWidth, CGRectGetWidth(self.view.bounds) - self.borderEdgeInsets.left - self.borderEdgeInsets.right, borderWidth)];
            [self.rightBorderLayer setFrame:CGRectMake(scrollView.contentOffset.x + CGRectGetWidth(self.view.bounds) - self.borderEdgeInsets.right - borderWidth, scrollView.contentOffset.y + self.borderEdgeInsets.top, borderWidth, CGRectGetHeight(self.view.bounds) - self.borderEdgeInsets.top - self.borderEdgeInsets.bottom)];
        }
        else {
            [self.topBorderLayer setFrame:CGRectMake(self.borderEdgeInsets.left, self.borderEdgeInsets.top, CGRectGetWidth(self.view.bounds) - self.borderEdgeInsets.left - self.borderEdgeInsets.right, borderWidth)];
            [self.leftBorderLayer setFrame:CGRectMake(self.borderEdgeInsets.left, self.borderEdgeInsets.top, borderWidth, CGRectGetHeight(self.view.bounds) - self.borderEdgeInsets.top - self.borderEdgeInsets.bottom)];
            [self.bottomBorderLayer setFrame:CGRectMake(self.borderEdgeInsets.left, CGRectGetHeight(self.view.bounds) - self.borderEdgeInsets.bottom - borderWidth, CGRectGetWidth(self.view.bounds) - self.borderEdgeInsets.left - self.borderEdgeInsets.right, borderWidth)];
            [self.rightBorderLayer setFrame:CGRectMake(CGRectGetWidth(self.view.bounds) - self.borderEdgeInsets.right - borderWidth, self.borderEdgeInsets.top, borderWidth, CGRectGetHeight(self.view.bounds) - self.borderEdgeInsets.top - self.borderEdgeInsets.bottom)];
        }
        
        [CATransaction commit];
    }
}

- (void)_configureBorderLayer:(CALayer *)layer; {
    [layer setBackgroundColor:self.borderColor.CGColor];
}
#pragma mark -
+ (UIColor *)_defaultBorderColor; {
    return UIColor.blackColor;
}

@end
