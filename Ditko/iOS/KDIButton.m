//
//  KDIButton.m
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

#import "KDIButton.h"
#import "UIColor+KDIExtensions.h"
#import "UIView+KDIExtensions.h"
#import "KDIBorderedViewImpl.h"

#import <Stanley/Stanley.h>
#import <Loki/Loki.h>

static CGFloat const kTitleColorBrightnessAdjustment = 0.5;
static CGFloat const kTitleColorAlphaAdjustment = 0.5;

@interface KDIButton ()
@property (strong,nonatomic) UIActivityIndicatorView *activityIndicatorView;

@property (strong,nonatomic) KDIBorderedViewImpl *borderedViewImpl;

@property (strong,nonatomic) UIColor *originalBackgroundColor;
@property (strong,nonatomic) UIImage *originalNormalImage;

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
- (id)forwardingTargetForSelector:(SEL)aSelector {
    if ([self.borderedViewImpl respondsToSelector:aSelector]) {
        return self.borderedViewImpl;
    }
    return [super forwardingTargetForSelector:aSelector];
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
    
    self.activityIndicatorView.color = self.tintColor;
    
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
#pragma mark KDIBorderedView
@dynamic borderOptions;
@dynamic borderWidth;
@dynamic borderWidthRespectsScreenScale;
@dynamic borderEdgeInsets;
@dynamic borderColor;
- (void)setBorderColor:(UIColor *)borderColor animated:(BOOL)animated {
    [self.borderedViewImpl setBorderColor:borderColor animated:animated];
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
        [self setNeedsLayout];
    }
    else {
        [self.layer setMask:nil];
    }
}
- (void)setRoundedRelativeToImageAndTitle:(BOOL)roundedRelativeToImageAndTitle {
    if (_roundedRelativeToImageAndTitle == roundedRelativeToImageAndTitle) {
        return;
    }
    
    _roundedRelativeToImageAndTitle = roundedRelativeToImageAndTitle;
    
    [self setNeedsLayout];
}
@dynamic loading;
- (BOOL)isLoading {
    return self.activityIndicatorView.isAnimating;
}
- (void)setLoading:(BOOL)loading {
    [UIView animateWithDuration:0.2 delay:0.0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
        self.titleLabel.alpha = loading ? 0.0 : 1.0;
        self.imageView.alpha = loading ? 0.0 : 1.0;
        self.activityIndicatorView.alpha = loading ? 1.0 : 0.0;
    } completion:nil];
    
    if (loading) {
        [self.activityIndicatorView startAnimating];
    }
    else {
        [self.activityIndicatorView stopAnimating];
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
    _activityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    _activityIndicatorView.hidesWhenStopped = NO;
    _activityIndicatorView.alpha = 0.0;
    _activityIndicatorView.color = self.tintColor;
    
    [self addSubview:_activityIndicatorView];
    
    _borderedViewImpl = [[KDIBorderedViewImpl alloc] initWithView:self];
    
    _roundedRelativeToImageAndTitle = YES;
    
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
        if (self.originalNormalImage == nil ||
            self.originalBackgroundColor == nil) {
            
            [self setOriginalBackgroundColor:self.backgroundColor ?: UIColor.clearColor];
            [self setOriginalNormalImage:[[self imageForState:UIControlStateNormal] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate]];
        }
        
        [self setBackgroundColor:self.tintColor];
        
        UIColor *contrastingColor = [self.tintColor KDI_contrastingColor];
        
        self.activityIndicatorView.color = contrastingColor;
        [self setTitleColor:contrastingColor forState:UIControlStateNormal];
        [self setImage:[self.originalNormalImage KLO_imageByTintingWithColor:contrastingColor] forState:UIControlStateNormal];
    }
    else {
        [self setBackgroundColor:self.originalBackgroundColor];
        [self setTitleColor:nil forState:UIControlStateNormal];
        [self setImage:self.originalNormalImage forState:UIControlStateNormal];
        [self setOriginalNormalImage:nil];
        [self setOriginalBackgroundColor:nil];
    }
}
- (CGSize)_sizeThatFits:(CGSize)size layout:(BOOL)layout; {
    CGSize retval = size;
    BOOL superDoesLayout = (self.titleContentVerticalAlignment == KDIButtonContentVerticalAlignmentDefault ||
                            self.titleContentHorizontalAlignment == KDIButtonContentHorizontalAlignmentDefault ||
                            self.imageContentVerticalAlignment == KDIButtonContentVerticalAlignmentDefault ||
                            self.imageContentHorizontalAlignment == KDIButtonContentHorizontalAlignmentDefault);
    
    if (superDoesLayout) {
        retval.width += self.titleEdgeInsets.left + self.titleEdgeInsets.right;
        retval.width += self.imageEdgeInsets.left + self.imageEdgeInsets.right;
        
        retval.height += MAX(self.titleEdgeInsets.top, self.imageEdgeInsets.top);
        retval.height += MAX(self.titleEdgeInsets.bottom, self.imageEdgeInsets.bottom);
    }
    else {
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
        [self.borderedViewImpl layoutSubviews];
        
        CGSize activityIndicatorSize = [self.activityIndicatorView sizeThatFits:CGSizeZero];
        
        self.activityIndicatorView.frame = KSTCGRectCenterInRect(CGRectMake(0, 0, activityIndicatorSize.width, activityIndicatorSize.height), self.bounds);
        
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
                titleRect.size.width = MIN(titleSize.width, CGRectGetWidth(self.bounds) - self.contentEdgeInsets.left - self.titleEdgeInsets.left - self.titleEdgeInsets.right - self.contentEdgeInsets.right);
                imageRect.origin.x = self.contentEdgeInsets.left + self.imageEdgeInsets.left;
                imageRect.origin.y = CGRectGetMaxY(titleRect) + self.titleEdgeInsets.bottom + self.imageEdgeInsets.top;
            }
            // title on bottom, image on top
            else if (self.titleContentVerticalAlignment == KDIButtonContentVerticalAlignmentBottom && self.imageContentVerticalAlignment == KDIButtonContentVerticalAlignmentTop) {
                imageRect.origin.x = self.contentEdgeInsets.left + self.imageEdgeInsets.left;
                imageRect.origin.y = self.contentEdgeInsets.top + self.imageEdgeInsets.top;
                titleRect.origin.x = self.contentEdgeInsets.left + self.titleEdgeInsets.left;
                titleRect.origin.y = CGRectGetMaxY(imageRect) + self.imageEdgeInsets.bottom + self.titleEdgeInsets.top;
                titleRect.size.width = MIN(titleSize.width, CGRectGetWidth(self.bounds) - self.contentEdgeInsets.left - self.titleEdgeInsets.left - self.titleEdgeInsets.right - self.contentEdgeInsets.right);
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
        
        if (self.isRounded) {
            if (self.roundedRelativeToImageAndTitle) {
                UIEdgeInsets insets = self.contentEdgeInsets;
                
                if ((self.titleContentHorizontalAlignment == KDIButtonContentHorizontalAlignmentLeft && self.imageContentHorizontalAlignment == KDIButtonContentHorizontalAlignmentRight) || (self.titleContentHorizontalAlignment == KDIButtonContentHorizontalAlignmentRight && self.imageContentHorizontalAlignment == KDIButtonContentHorizontalAlignmentLeft)) {
                    insets.top += MAX(self.titleEdgeInsets.top, self.imageEdgeInsets.top);
                    insets.bottom += MAX(self.titleEdgeInsets.bottom, self.imageEdgeInsets.bottom);
                    insets.left += self.titleContentHorizontalAlignment == KDIButtonContentHorizontalAlignmentLeft ? self.titleEdgeInsets.left : self.imageEdgeInsets.left;
                    insets.right += self.titleContentHorizontalAlignment == KDIButtonContentHorizontalAlignmentLeft ? self.imageEdgeInsets.right : self.titleEdgeInsets.right;
                }
                else if ((self.titleContentVerticalAlignment == KDIButtonContentVerticalAlignmentTop && self.imageContentVerticalAlignment == KDIButtonContentVerticalAlignmentBottom) || (self.titleContentVerticalAlignment == KDIButtonContentVerticalAlignmentBottom && self.imageContentVerticalAlignment == KDIButtonContentVerticalAlignmentTop)) {
                    insets.left += MAX(self.titleEdgeInsets.left, self.imageEdgeInsets.left);
                    insets.right += MAX(self.titleEdgeInsets.right, self.imageEdgeInsets.right);
                    insets.top += self.titleContentVerticalAlignment == KDIButtonContentVerticalAlignmentTop ? self.titleEdgeInsets.top : self.imageEdgeInsets.top;
                    insets.bottom += self.titleContentVerticalAlignment == KDIButtonContentVerticalAlignmentTop ? self.imageEdgeInsets.bottom : self.titleEdgeInsets.bottom;
                }
                
                insets.top *= -1.0;
                insets.left *= -1.0;
                insets.bottom *= -1.0;
                insets.right *= -1.0;
                
                CAShapeLayer *mask = [CAShapeLayer layer];
                CGRect rect = CGRectIsEmpty(self.imageView.frame) ? self.titleLabel.frame : CGRectIsEmpty(self.titleLabel.frame) ? self.imageView.frame : CGRectUnion(self.titleLabel.frame, self.imageView.frame);
                CGFloat radius = self.layer.cornerRadius > 0 ? self.layer.cornerRadius : ceil(MIN(CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds)) * 0.5);
                
                [mask setPath:[UIBezierPath bezierPathWithRoundedRect:UIEdgeInsetsInsetRect(rect, insets) cornerRadius:radius].CGPath];
                
                [self.layer setMask:mask];
            }
            else {
                CAShapeLayer *mask = [CAShapeLayer layer];
                CGFloat radius = self.layer.cornerRadius > 0 ? self.layer.cornerRadius : ceil(MIN(CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds)) * 0.5);
                
                [mask setPath:[UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:radius].CGPath];
                
                [self.layer setMask:mask];
            }
        }
    }
    
    return retval;
}

@end
