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
#import "UIView+KDIExtensions.h"

#import <Stanley/KSTGeometryFunctions.h>
#import <Loki/UIImage+KLOExtensions.h>

static CGFloat const kTitleColorBrightnessAdjustment = 0.5;
static CGFloat const kTitleColorAlphaAdjustment = 0.5;

@interface KDIButton ()
- (void)_KDIButtonInit;
- (void)_updateAfterInvertedChange;
- (CGSize)_sizeThatFits:(CGSize)size layout:(BOOL)layout;
@end

@implementation KDIButton
#pragma mark *** Subclass Overrides ***
- (instancetype)initWithFrame:(CGRect)frame {
    if (!(self = [super initWithFrame:frame]))
        return nil;
    
    [self _KDIButtonInit];
    
    return self;
}
- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (!(self = [super initWithCoder:aDecoder]))
        return nil;
    
    [self _KDIButtonInit];
    
    return self;
}
#pragma mark -
- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self _sizeThatFits:self.bounds.size layout:YES];
}
#pragma mark -
- (CGSize)intrinsicContentSize {
    return [self _sizeThatFits:[super intrinsicContentSize] layout:NO];
}
- (CGSize)sizeThatFits:(CGSize)size {
    return [self _sizeThatFits:[super sizeThatFits:size] layout:NO];
}
#pragma mark -
- (void)tintColorDidChange {
    [super tintColorDidChange];
    
    if (self.borderColorMatchesTintColor) {
        [self setKDI_borderColor:self.tintColor];
    }
    
    if (self.isInverted) {
        [self _updateAfterInvertedChange];
    }
}
#pragma mark -
- (void)setTitleColor:(UIColor *)color forState:(UIControlState)state {
    [super setTitleColor:color forState:state];
    
    if (state == UIControlStateNormal &&
        self.adjustsTitleColorWhenHighlighted) {
        
        CGFloat h, s, b;
        if ([color getHue:&h saturation:&s brightness:&b alpha:NULL]) {
            if (b < 0.5) {
                color = [color colorWithAlphaComponent:kTitleColorAlphaAdjustment];
            }
            else {
                color = [color KDI_colorByAdjustingBrightnessBy:kTitleColorBrightnessAdjustment];
            }
        }
        else {
            color = [color colorWithAlphaComponent:kTitleColorAlphaAdjustment];
        }
        
        [self setTitleColor:color forState:UIControlStateHighlighted];
    }
}
- (void)setAttributedTitle:(NSAttributedString *)title forState:(UIControlState)state {
    [super setAttributedTitle:title forState:state];
    
    if (state == UIControlStateNormal &&
        self.adjustsTitleColorWhenHighlighted) {
        
        if (title.length > 0 &&
            [title attribute:NSForegroundColorAttributeName atIndex:0 effectiveRange:NULL] != nil) {
            
            UIColor *color = [title attribute:NSForegroundColorAttributeName atIndex:0 effectiveRange:NULL];
            
            CGFloat h, s, b;
            if ([color getHue:&h saturation:&s brightness:&b alpha:NULL]) {
                if (b < 0.5) {
                    color = [color colorWithAlphaComponent:kTitleColorAlphaAdjustment];
                }
                else {
                    color = [color KDI_colorByAdjustingBrightnessBy:kTitleColorBrightnessAdjustment];
                }
            }
            else {
                color = [color colorWithAlphaComponent:kTitleColorAlphaAdjustment];
            }
            
            NSMutableAttributedString *temp = [title mutableCopy];
            
            [temp addAttribute:NSForegroundColorAttributeName value:color range:NSMakeRange(0, title.length)];
            
            [self setAttributedTitle:temp forState:UIControlStateHighlighted];
        }
    }
}
#pragma mark *** Public Methods ***
#pragma mark Properties
- (void)setBorderColorMatchesTintColor:(BOOL)borderColorMatchesTintColor {
    _borderColorMatchesTintColor = borderColorMatchesTintColor;
    
    if (_borderColorMatchesTintColor) {
        [self setKDI_borderColor:self.tintColor];
    }
}
- (void)setInverted:(BOOL)inverted {
    if (_inverted == inverted) {
        return;
    }
    
    _inverted = inverted;
    
    [self _updateAfterInvertedChange];
}
- (void)setRounded:(BOOL)rounded {
    if (_rounded == rounded) {
        return;
    }
    
    _rounded = rounded;
    
    if (_rounded) {
        [self.layer setMasksToBounds:YES];
    }
    else {
        [self.layer setCornerRadius:0.0];
        [self.layer setMasksToBounds:NO];
    }
}
#pragma mark -
- (void)setTitleContentVerticalAlignment:(KDIButtonContentVerticalAlignment)titleContentVerticalAlignment {
    _titleContentVerticalAlignment = titleContentVerticalAlignment;
    
    [self setNeedsLayout];
    [self invalidateIntrinsicContentSize];
}
- (void)setTitleContentHorizontalAlignment:(KDIButtonContentHorizontalAlignment)titleContentHorizontalAlignment {
    _titleContentHorizontalAlignment = titleContentHorizontalAlignment;
    
    [self setNeedsLayout];
    [self invalidateIntrinsicContentSize];
}
- (void)setImageContentVerticalAlignment:(KDIButtonContentVerticalAlignment)imageContentVerticalAlignment {
    _imageContentVerticalAlignment = imageContentVerticalAlignment;
    
    [self setNeedsLayout];
    [self invalidateIntrinsicContentSize];
}
- (void)setImageContentHorizontalAlignment:(KDIButtonContentHorizontalAlignment)imageContentHorizontalAlignment {
    _imageContentHorizontalAlignment = imageContentHorizontalAlignment;
    
    [self setNeedsLayout];
    [self invalidateIntrinsicContentSize];
}
#pragma mark *** Private Methods ***
- (void)_KDIButtonInit; {
    _titleContentVerticalAlignment = KDIButtonContentVerticalAlignmentDefault;
    _titleContentHorizontalAlignment = KDIButtonContentHorizontalAlignmentDefault;
    _imageContentVerticalAlignment = KDIButtonContentVerticalAlignmentDefault;
    _imageContentHorizontalAlignment = KDIButtonContentHorizontalAlignmentDefault;
    
    if (self.buttonType == UIButtonTypeCustom) {
        _adjustsTitleColorWhenHighlighted = YES;
    }
}
#pragma mark -
- (void)_updateAfterInvertedChange; {
    if (self.isInverted) {
        [self setBackgroundColor:self.tintColor];
        
        UIColor *tintColor = [self.tintColor KDI_contrastingColor];
        
        [self setTitleColor:tintColor forState:UIControlStateNormal];
        [self setImage:[[self imageForState:UIControlStateNormal] KLO_imageByTintingWithColor:tintColor] forState:UIControlStateNormal];
    }
    else {
        [self setBackgroundColor:UIColor.clearColor];
        [self setTitleColor:self.tintColor forState:UIControlStateNormal];
    }
}
- (CGSize)_sizeThatFits:(CGSize)size layout:(BOOL)layout; {
    CGSize retval = size;
    BOOL superDoesLayout = (self.titleContentVerticalAlignment == KDIButtonContentVerticalAlignmentDefault ||
                            self.titleContentHorizontalAlignment == KDIButtonContentHorizontalAlignmentDefault ||
                            self.imageContentVerticalAlignment == KDIButtonContentVerticalAlignmentDefault ||
                            self.imageContentHorizontalAlignment == KDIButtonContentHorizontalAlignmentDefault);
    
    if (!superDoesLayout) {
        CGSize titleSize = [self.titleLabel sizeThatFits:CGSizeZero];
        CGSize imageSize = [self.imageView sizeThatFits:CGSizeZero];
        
        // left/right layout
        if ((self.titleContentHorizontalAlignment == KDIButtonContentHorizontalAlignmentLeft && self.imageContentHorizontalAlignment == KDIButtonContentHorizontalAlignmentRight) || (self.titleContentHorizontalAlignment == KDIButtonContentHorizontalAlignmentRight && self.imageContentHorizontalAlignment == KDIButtonContentHorizontalAlignmentLeft)) {
            retval.width = titleSize.width + imageSize.width;
            retval.width += self.contentEdgeInsets.left + self.contentEdgeInsets.right;
            retval.width += self.titleEdgeInsets.left + self.titleEdgeInsets.right;
            retval.width += self.imageEdgeInsets.left + self.imageEdgeInsets.right;
            
            retval.height = MAX(titleSize.height, imageSize.height);
            retval.height += self.contentEdgeInsets.top + self.contentEdgeInsets.bottom;
            retval.height += MAX(self.titleEdgeInsets.top, self.imageEdgeInsets.top);
            retval.height += MAX(self.titleEdgeInsets.bottom, self.imageEdgeInsets.bottom);
        }
        // top/bottom layout
        else if ((self.titleContentVerticalAlignment == KDIButtonContentVerticalAlignmentTop && self.imageContentVerticalAlignment == KDIButtonContentVerticalAlignmentBottom) || (self.titleContentVerticalAlignment == KDIButtonContentVerticalAlignmentBottom && self.imageContentVerticalAlignment == KDIButtonContentVerticalAlignmentTop)) {
            retval.width = MAX(titleSize.width, imageSize.width);
            retval.width += self.contentEdgeInsets.left + self.contentEdgeInsets.right;
            retval.width += MAX(self.titleEdgeInsets.left, self.imageEdgeInsets.left);
            retval.width += MAX(self.titleEdgeInsets.right, self.imageEdgeInsets.right);
            
            retval.height = titleSize.height + imageSize.height;
            retval.height += self.contentEdgeInsets.top + self.contentEdgeInsets.bottom;
            retval.height += self.titleEdgeInsets.top + self.titleEdgeInsets.bottom;
            retval.height += self.imageEdgeInsets.top + self.imageEdgeInsets.bottom;
        }
    }
    
    if (layout) {
        if (self.isRounded) {
            [self.layer setCornerRadius:ceil(MIN(CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds)) * 0.5)];
        }
        
        if (!superDoesLayout) {
            CGSize titleSize = [self.titleLabel sizeThatFits:CGSizeZero];
            CGSize imageSize = [self.imageView sizeThatFits:CGSizeZero];
            CGRect titleRect = CGRectMake(0, 0, titleSize.width, titleSize.height);
            CGRect imageRect = CGRectMake(0, 0, imageSize.width, imageSize.height);
            
            // title on left, image on right
            if (self.titleContentHorizontalAlignment == KDIButtonContentHorizontalAlignmentLeft && self.imageContentHorizontalAlignment == KDIButtonContentHorizontalAlignmentRight) {
                imageRect.origin.x = CGRectGetWidth(self.bounds) - self.contentEdgeInsets.right - self.imageEdgeInsets.right - CGRectGetWidth(imageRect);
                imageRect.origin.y = self.contentEdgeInsets.top + self.imageEdgeInsets.top;
                titleRect.origin.x = self.contentEdgeInsets.left + self.titleEdgeInsets.left;
                titleRect.origin.y = self.contentEdgeInsets.top + self.titleEdgeInsets.top;
                titleRect.size.width = CGRectGetMinX(imageRect) - CGRectGetMinX(titleRect) - self.titleEdgeInsets.right - self.imageEdgeInsets.left;
            }
            // title on right, image on left
            else if (self.titleContentHorizontalAlignment == KDIButtonContentHorizontalAlignmentRight && self.imageContentHorizontalAlignment == KDIButtonContentHorizontalAlignmentLeft) {
                imageRect.origin.x = self.contentEdgeInsets.left + self.imageEdgeInsets.left;
                imageRect.origin.y = self.contentEdgeInsets.top + self.imageEdgeInsets.top;
                titleRect.origin.x = CGRectGetMaxX(imageRect) + self.imageEdgeInsets.right + self.titleEdgeInsets.left;
                titleRect.origin.y = self.contentEdgeInsets.top + self.titleEdgeInsets.top;
                titleRect.size.width = CGRectGetWidth(self.bounds) - CGRectGetMinX(titleRect) - self.titleEdgeInsets.right - self.contentEdgeInsets.right;
            }
            // title on top, image on bottom
            else if (self.titleContentVerticalAlignment == KDIButtonContentVerticalAlignmentTop && self.imageContentVerticalAlignment == KDIButtonContentVerticalAlignmentBottom) {
                titleRect.origin.x = self.contentEdgeInsets.left + self.titleEdgeInsets.left;
                titleRect.origin.y = self.contentEdgeInsets.top + self.titleEdgeInsets.top;
                titleRect.size.width = CGRectGetWidth(self.bounds) - self.contentEdgeInsets.left - self.titleEdgeInsets.left - self.titleEdgeInsets.right - self.contentEdgeInsets.right;
                imageRect.origin.x = self.contentEdgeInsets.left + self.imageEdgeInsets.left;
                imageRect.origin.y = CGRectGetMaxY(titleRect) + self.titleEdgeInsets.bottom + self.imageEdgeInsets.top;
            }
            // title on bottom, image on top
            else if (self.titleContentVerticalAlignment == KDIButtonContentVerticalAlignmentBottom && self.imageContentVerticalAlignment == KDIButtonContentVerticalAlignmentTop) {
                imageRect.origin.x = self.contentEdgeInsets.left + self.imageEdgeInsets.left;
                imageRect.origin.y = self.contentEdgeInsets.top + self.imageEdgeInsets.top;
                titleRect.origin.x = self.contentEdgeInsets.left + self.titleEdgeInsets.left;
                titleRect.origin.y = CGRectGetMaxY(imageRect) + self.imageEdgeInsets.bottom + self.titleEdgeInsets.top;
                titleRect.size.width = CGRectGetWidth(self.bounds) - self.contentEdgeInsets.left - self.titleEdgeInsets.left - self.titleEdgeInsets.right - self.contentEdgeInsets.right;
            }
            
            if (self.titleContentVerticalAlignment == KDIButtonContentVerticalAlignmentCenter) {
                titleRect = KSTCGRectCenterInRectVertically(titleRect, self.bounds);
            }
            if (self.titleContentHorizontalAlignment == KDIButtonContentHorizontalAlignmentCenter) {
                titleRect = KSTCGRectCenterInRectHorizontally(titleRect, self.bounds);
            }
            if (self.imageContentVerticalAlignment == KDIButtonContentVerticalAlignmentCenter) {
                imageRect = KSTCGRectCenterInRectVertically(imageRect, self.bounds);
            }
            if (self.imageContentHorizontalAlignment == KDIButtonContentHorizontalAlignmentCenter) {
                imageRect = KSTCGRectCenterInRectHorizontally(imageRect, self.bounds);
            }
            
            [self.titleLabel setFrame:titleRect];
            [self.imageView setFrame:imageRect];
        }
    }
    
    return retval;
}

@end
