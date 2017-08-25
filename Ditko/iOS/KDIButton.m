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

- (void)tintColorDidChange {
    [super tintColorDidChange];
    
    if (self.isInverted) {
        [self _updateAfterInvertedChange];
    }
}

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
- (void)setTitleAlignment:(KDIButtonAlignment)titleAlignment {
    _titleAlignment = titleAlignment;
    
    [self invalidateIntrinsicContentSize];
}
- (void)setImageAlignment:(KDIButtonAlignment)imageAlignment {
    _imageAlignment = imageAlignment;
    
    [self invalidateIntrinsicContentSize];
}
#pragma mark *** Private Methods ***
- (void)_KDIButtonInit; {
    if (self.buttonType == UIButtonTypeCustom) {
        _adjustsTitleColorWhenHighlighted = YES;
    }
}
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
    CGSize retval = CGSizeZero;
    
    if (self.titleAlignment == KDIButtonAlignmentDefault &&
        self.imageAlignment == KDIButtonAlignmentDefault) {
        
        retval = size;
        retval.width += self.titleEdgeInsets.left + self.titleEdgeInsets.right;
        retval.width += self.imageEdgeInsets.left + self.imageEdgeInsets.right;
        retval.height += self.titleEdgeInsets.top + self.titleEdgeInsets.bottom;
        retval.height += self.imageEdgeInsets.top + self.imageEdgeInsets.bottom;
    }
    else {
        CGSize titleSize = [self.titleLabel sizeThatFits:CGSizeZero];
        CGSize imageSize = [self.imageView sizeThatFits:CGSizeZero];
        
        if (((self.titleAlignment & KDIButtonAlignmentTop) &&
            (self.imageAlignment & KDIButtonAlignmentBottom)) ||
            ((self.imageAlignment & KDIButtonAlignmentTop) &&
             (self.titleAlignment & KDIButtonAlignmentBottom))) {
                
                retval.width = MAX(titleSize.width, imageSize.width);
                retval.width += self.contentEdgeInsets.left + self.contentEdgeInsets.right;
                retval.width += MAX(self.titleEdgeInsets.left, self.imageEdgeInsets.left) + MAX(self.imageEdgeInsets.right, self.imageEdgeInsets.right);
                retval.height = titleSize.height + imageSize.height;
                retval.height += self.contentEdgeInsets.top + self.titleEdgeInsets.top + self.imageEdgeInsets.top + self.imageEdgeInsets.bottom + self.titleEdgeInsets.bottom + self.contentEdgeInsets.bottom;
        }
        else {
            retval.width = titleSize.width + imageSize.width;
            retval.width += self.contentEdgeInsets.left + self.titleEdgeInsets.left + self.imageEdgeInsets.left + self.imageEdgeInsets.right + self.titleEdgeInsets.right + self.contentEdgeInsets.right;
            retval.height = MAX(titleSize.height, imageSize.height);
            retval.height += self.contentEdgeInsets.top + self.contentEdgeInsets.bottom;
            retval.height += MAX(self.titleEdgeInsets.top, self.imageEdgeInsets.top) + MAX(self.titleEdgeInsets.bottom, self.imageEdgeInsets.bottom);
        }
    }
    
    if (layout) {
        if (self.isRounded) {
            [self.layer setCornerRadius:ceil(MIN(CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds)) * 0.5)];
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
                [self.imageView setFrame:KSTCGRectCenterInRectVertically(CGRectMake(CGRectGetWidth(self.bounds) - imageSize.width - self.imageEdgeInsets.right - self.contentEdgeInsets.right, 0, imageSize.width, imageSize.height), self.bounds)];
            }
            else {
                [self.imageView setFrame:CGRectMake(CGRectGetWidth(self.bounds) - imageSize.width - self.imageEdgeInsets.right - self.contentEdgeInsets.right, self.contentEdgeInsets.top + self.imageEdgeInsets.top, imageSize.width, imageSize.height)];
            }
        }
        else if ((self.titleAlignment & KDIButtonAlignmentRight) &&
                 (self.imageAlignment & KDIButtonAlignmentLeft)) {
            
            if (self.imageAlignment & KDIButtonAlignmentCenter) {
                [self.imageView setFrame:KSTCGRectCenterInRectVertically(CGRectMake(self.contentEdgeInsets.left + self.imageEdgeInsets.left, 0, imageSize.width, imageSize.height), self.bounds)];
            }
            else {
                [self.imageView setFrame:CGRectMake(self.contentEdgeInsets.left + self.imageEdgeInsets.left, self.contentEdgeInsets.top + self.imageEdgeInsets.top, imageSize.width, imageSize.height)];
            }
            
            if (self.titleAlignment & KDIButtonAlignmentCenter) {
                [self.titleLabel setFrame:KSTCGRectCenterInRectVertically(CGRectMake(CGRectGetWidth(self.bounds) - titleSize.width - self.titleEdgeInsets.right - self.contentEdgeInsets.right, 0, titleSize.width, titleSize.height), self.bounds)];
            }
            else {
                [self.titleLabel setFrame:CGRectMake(CGRectGetWidth(self.bounds) - titleSize.width - self.titleEdgeInsets.right - self.contentEdgeInsets.right, self.contentEdgeInsets.top + self.titleEdgeInsets.top, titleSize.width, titleSize.height)];
            }
        }
        else if ((self.titleAlignment & KDIButtonAlignmentTop) &&
                 (self.imageAlignment & KDIButtonAlignmentBottom)) {
            
            if (self.titleAlignment & KDIButtonAlignmentCenter) {
                [self.titleLabel setFrame:KSTCGRectCenterInRectHorizontally(CGRectMake(0, self.contentEdgeInsets.top + self.titleEdgeInsets.top, titleSize.width, titleSize.height), self.bounds)];
            }
            else {
                [self.titleLabel setFrame:CGRectMake(self.contentEdgeInsets.left + self.titleEdgeInsets.left, self.contentEdgeInsets.top + self.titleEdgeInsets.top, titleSize.width, titleSize.height)];
            }
            
            if (self.imageAlignment & KDIButtonAlignmentCenter) {
                [self.imageView setFrame:KSTCGRectCenterInRectHorizontally(CGRectMake(0, CGRectGetMaxY(self.titleLabel.frame) + self.titleEdgeInsets.bottom + self.imageEdgeInsets.top, imageSize.width, imageSize.height), self.bounds)];
            }
            else {
                [self.imageView setFrame:CGRectMake(self.contentEdgeInsets.left + self.imageEdgeInsets.left, CGRectGetMaxY(self.titleLabel.frame) + self.imageEdgeInsets.bottom + self.imageEdgeInsets.top, imageSize.width, imageSize.height)];
            }
        }
        else if ((self.titleAlignment & KDIButtonAlignmentBottom) &&
                 (self.imageAlignment & KDIButtonAlignmentTop)) {
            
            if (self.imageAlignment & KDIButtonAlignmentCenter) {
                [self.imageView setFrame:KSTCGRectCenterInRectHorizontally(CGRectMake(0, self.contentEdgeInsets.top + self.imageEdgeInsets.top, imageSize.width, imageSize.height), self.bounds)];
            }
            else {
                [self.imageView setFrame:CGRectMake(self.contentEdgeInsets.left + self.imageEdgeInsets.left, self.contentEdgeInsets.top + self.imageEdgeInsets.top, imageSize.width, imageSize.height)];
            }
            
            if (self.titleAlignment & KDIButtonAlignmentCenter) {
                [self.titleLabel setFrame:KSTCGRectCenterInRectHorizontally(CGRectMake(0, CGRectGetMaxY(self.imageView.frame) + self.imageEdgeInsets.bottom + self.titleEdgeInsets.top, titleSize.width, titleSize.height), self.bounds)];
            }
            else {
                [self.titleLabel setFrame:CGRectMake(self.contentEdgeInsets.left + self.titleEdgeInsets.left, CGRectGetMaxY(self.imageView.frame) + self.imageEdgeInsets.bottom + self.titleEdgeInsets.top, titleSize.width, titleSize.height)];
            }
        }
        else {
            [self.imageView setFrame:CGRectMake(self.contentEdgeInsets.left + self.imageEdgeInsets.left, self.contentEdgeInsets.top + self.imageEdgeInsets.top, imageSize.width, imageSize.height)];
            [self.titleLabel setFrame:CGRectMake(CGRectGetMaxX(self.imageView.frame) + self.titleEdgeInsets.left, self.contentEdgeInsets.top + self.titleEdgeInsets.top, titleSize.width, titleSize.height)];
        }
    }
    
    return retval;
}

@end
