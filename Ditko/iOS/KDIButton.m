//
//  KDIButton.m
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

#import "KDIButton.h"
#import "UIColor+KDIExtensions.h"

#import <Stanley/KSTGeometryFunctions.h>

static CGFloat const kTitleBrightnessAdjustment = 0.5;

@interface KDIButton ()
- (CGSize)_sizeThatFits:(CGSize)size layout:(BOOL)layout;
@end

@implementation KDIButton

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self _sizeThatFits:self.bounds.size layout:YES];
}

- (CGSize)intrinsicContentSize {
    return [self _sizeThatFits:[super intrinsicContentSize] layout:NO];
}
- (CGSize)sizeThatFits:(CGSize)size {
    return [self _sizeThatFits:[super sizeThatFits:size] layout:NO];
}

- (void)setTitleColor:(UIColor *)color forState:(UIControlState)state {
    [super setTitleColor:color forState:state];
    
    if (state == UIControlStateNormal) {
        [self setTitleColor:[color KDI_colorByAdjustingBrightnessBy:kTitleBrightnessAdjustment] forState:UIControlStateHighlighted];
    }
}
- (void)setAttributedTitle:(NSAttributedString *)title forState:(UIControlState)state {
    [super setAttributedTitle:title forState:state];
    
    if (state == UIControlStateNormal) {
        if (title.length > 0) {
            UIColor *color = [title attribute:NSForegroundColorAttributeName atIndex:0 effectiveRange:NULL];
            NSMutableAttributedString *temp = [title mutableCopy];
            
            [temp addAttribute:NSForegroundColorAttributeName value:[color KDI_colorByAdjustingBrightnessBy:kTitleBrightnessAdjustment] range:NSMakeRange(0, title.length)];
            
            [self setAttributedTitle:temp forState:UIControlStateHighlighted];
        }
    }
}

- (void)setStyle:(KDIButtonStyle)style {
    _style = style;
    
    switch (self.style) {
        case KDIButtonStyleRounded:
            [self.layer setMasksToBounds:YES];
            break;
        case KDIButtonStyleDefault:
            [self.layer setCornerRadius:0.0];
            [self.layer setMasksToBounds:NO];
            break;
        default:
            break;
    }
}

- (CGSize)_sizeThatFits:(CGSize)size layout:(BOOL)layout; {
    CGSize retval = size;
    
    if (self.titleAlignment == KDIButtonAlignmentDefault &&
        self.imageAlignment == KDIButtonAlignmentDefault) {
        
        retval.width += self.titleEdgeInsets.left + self.titleEdgeInsets.right;
        retval.width += self.imageEdgeInsets.left + self.imageEdgeInsets.right;
        retval.height += self.titleEdgeInsets.top + self.titleEdgeInsets.bottom;
        retval.height += self.imageEdgeInsets.top + self.imageEdgeInsets.bottom;
    }
    
    if (layout) {
        switch (self.style) {
            case KDIButtonStyleRounded:
                [self.layer setMasksToBounds:YES];
                [self.layer setCornerRadius:ceil(CGRectGetHeight(self.frame) * 0.5)];
                break;
            case KDIButtonStyleDefault:
                [self.layer setMasksToBounds:NO];
                [self.layer setCornerRadius:0.0];
                break;
            default:
                break;
        }
        
        CGSize titleSize = [self.titleLabel sizeThatFits:CGSizeZero];
        CGSize imageSize = [self.imageView sizeThatFits:CGSizeZero];
        
        if ((self.titleAlignment & KDIButtonAlignmentLeft) &&
            (self.imageAlignment & KDIButtonAlignmentRight)) {
            
            if (self.titleAlignment & KDIButtonAlignmentCenter) {
                [self.titleLabel setFrame:KSTCGRectCenterInRectVertically(CGRectMake(self.contentEdgeInsets.left + self.titleEdgeInsets.left, 0, titleSize.width, titleSize.height), self.bounds)];
            }
            else {
                [self.titleLabel setFrame:CGRectMake(self.contentEdgeInsets.left + self.titleEdgeInsets.left, self.contentEdgeInsets.top + self.titleEdgeInsets.top, titleSize.width, titleSize.height)];
            }
            
            if (self.imageAlignment & KDIButtonAlignmentCenter) {
                [self.imageView setFrame:KSTCGRectCenterInRectVertically(CGRectMake(CGRectGetMaxX(self.titleLabel.frame) + self.imageEdgeInsets.left, 0, imageSize.width, imageSize.height), self.bounds)];
            }
            else {
                [self.imageView setFrame:CGRectMake(CGRectGetMaxX(self.titleLabel.frame) + self.imageEdgeInsets.left, self.contentEdgeInsets.top + self.imageEdgeInsets.top, imageSize.width, imageSize.height)];
            }
        }
    }
    
    return retval;
}

@end
