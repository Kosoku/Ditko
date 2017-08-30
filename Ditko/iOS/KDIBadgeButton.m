//
//  KDIBadgeButton.m
//  Ditko
//
//  Created by William Towe on 4/13/17.
//  Copyright © 2017 Kosoku Interactive, LLC. All rights reserved.
//
//  Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
//
//  1. Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
//
//  2. Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
//
//  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

#import "KDIBadgeButton.h"
#import "KDIBadgeView.h"
#import "KDIButton.h"
#import "UIControl+KDIExtensions.h"

#import <Stanley/KSTScopeMacros.h>

static void *kKDIBadgeButtonObservingContext = &kKDIBadgeButtonObservingContext;

@interface KDIBadgeButton ()
@property (readwrite,strong,nonatomic) KDIBadgeView *badgeView;
@property (readwrite,strong,nonatomic) KDIButton *button;

- (void)_KDIBadgeButtonInit;
- (CGSize)_sizeThatFits:(CGSize)size layout:(BOOL)layout;
@end

@implementation KDIBadgeButton
#pragma mark *** Subclass Overrides ***
- (void)dealloc {
    [_button removeObserver:self forKeyPath:@kstKeypath(_button,highlighted) context:kKDIBadgeButtonObservingContext];
    [_button removeObserver:self forKeyPath:@kstKeypath(_button,titleContentVerticalAlignment) context:kKDIBadgeButtonObservingContext];
    [_button removeObserver:self forKeyPath:@kstKeypath(_button,titleContentHorizontalAlignment) context:kKDIBadgeButtonObservingContext];
    [_button removeObserver:self forKeyPath:@kstKeypath(_button,imageContentVerticalAlignment) context:kKDIBadgeButtonObservingContext];
    [_button removeObserver:self forKeyPath:@kstKeypath(_button,imageContentHorizontalAlignment) context:kKDIBadgeButtonObservingContext];
    
    [_badgeView removeObserver:self forKeyPath:@kstKeypath(_badgeView,badge) context:kKDIBadgeButtonObservingContext];
    [_badgeView removeObserver:self forKeyPath:@kstKeypath(_badgeView,badgeFont) context:kKDIBadgeButtonObservingContext];
    [_badgeView removeObserver:self forKeyPath:@kstKeypath(_badgeView,badgeEdgeInsets) context:kKDIBadgeButtonObservingContext];
}
#pragma mark -
- (instancetype)initWithFrame:(CGRect)frame {
    if (!(self = [super initWithFrame:frame]))
        return nil;
    
    [self _KDIBadgeButtonInit];
    
    return self;
}
- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (!(self = [super initWithCoder:aDecoder]))
        return nil;
    
    [self _KDIBadgeButtonInit];
    
    return self;
}
#pragma mark -
- (CGSize)intrinsicContentSize {
    return [self _sizeThatFits:CGSizeZero layout:NO];
}
- (CGSize)sizeThatFits:(CGSize)size {
    return [self _sizeThatFits:size layout:NO];
}
#pragma mark -
- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self _sizeThatFits:self.bounds.size layout:YES];
}
#pragma mark -
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    UIView *retval = [super hitTest:point withEvent:event];
    
    if (retval != nil) {
        retval = self.button;
    }
    
    return retval;
}
#pragma mark KVO
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if (context == kKDIBadgeButtonObservingContext) {
        if ([keyPath isEqualToString:@kstKeypath(self.badgeView,badge)]) {
            [self.badgeView setHidden:self.badgeView.badge.length == 0];
            
            [self setNeedsLayout];
            [self invalidateIntrinsicContentSize];
        }
        else if ([keyPath isEqualToString:@kstKeypath(self.badgeView,badgeFont)] ||
                 [keyPath isEqualToString:@kstKeypath(self.badgeView,badgeEdgeInsets)] ||
                 [keyPath isEqualToString:@kstKeypath(self.button,titleContentVerticalAlignment)] ||
                 [keyPath isEqualToString:@kstKeypath(self.button,titleContentHorizontalAlignment)] ||
                 [keyPath isEqualToString:@kstKeypath(self.button,imageContentVerticalAlignment)] ||
                 [keyPath isEqualToString:@kstKeypath(self.button,imageContentHorizontalAlignment)]) {
            
            [self setNeedsLayout];
            [self invalidateIntrinsicContentSize];
        }
        else if ([keyPath isEqualToString:@kstKeypath(self.button,highlighted)]) {
            [self.badgeView setHighlighted:self.button.isHighlighted];
        }
    }
    else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}
#pragma mark *** Public Methods ***
#pragma mark Properties
- (void)setBadgePosition:(KDIBadgeButtonBadgePosition)badgePosition {
    _badgePosition = badgePosition;
    
    [self setNeedsLayout];
    [self invalidateIntrinsicContentSize];
}
- (void)setBadgePositionOffset:(CGPoint)badgePositionOffset {
    _badgePositionOffset = badgePositionOffset;
    
    [self setNeedsLayout];
    [self invalidateIntrinsicContentSize];
}
- (void)setBadgeSizeOffset:(CGPoint)badgeSizeOffset {
    _badgeSizeOffset = badgeSizeOffset;
    
    [self setNeedsLayout];
    [self invalidateIntrinsicContentSize];
}
#pragma mark *** Private Methods ***
- (void)_KDIBadgeButtonInit; {
    _badgePosition = KDIBadgeButtonBadgePositionRelativeToBounds;
    _badgePositionOffset = CGPointMake(1.0, 0.0);
    _badgeSizeOffset = CGPointMake(-0.25, -0.25);
    
    _button = [KDIButton buttonWithType:UIButtonTypeSystem];
    [_button addObserver:self forKeyPath:@kstKeypath(_button,highlighted) options:0 context:kKDIBadgeButtonObservingContext];
    [_button addObserver:self forKeyPath:@kstKeypath(_button,titleContentVerticalAlignment) options:0 context:kKDIBadgeButtonObservingContext];
    [_button addObserver:self forKeyPath:@kstKeypath(_button,titleContentHorizontalAlignment) options:0 context:kKDIBadgeButtonObservingContext];
    [_button addObserver:self forKeyPath:@kstKeypath(_button,imageContentVerticalAlignment) options:0 context:kKDIBadgeButtonObservingContext];
    [_button addObserver:self forKeyPath:@kstKeypath(_button,imageContentHorizontalAlignment) options:0 context:kKDIBadgeButtonObservingContext];
    [self addSubview:_button];
    
    _badgeView = [[KDIBadgeView alloc] initWithFrame:CGRectZero];
    [_badgeView setUserInteractionEnabled:NO];
    [_badgeView setBadgeFont:[UIFont preferredFontForTextStyle:UIFontTextStyleCaption2]];
    [_badgeView setBadgeForegroundColor:UIColor.whiteColor];
    [_badgeView setBadgeBackgroundColor:UIColor.redColor];
    [_badgeView setBadgeHighlightedForegroundColor:[_badgeView.badgeForegroundColor colorWithAlphaComponent:0.5]];
    [_badgeView setBadgeHighlightedBackgroundColor:[_badgeView.badgeBackgroundColor colorWithAlphaComponent:0.5]];
    [_badgeView addObserver:self forKeyPath:@kstKeypath(_badgeView,badge) options:0 context:kKDIBadgeButtonObservingContext];
    [_badgeView addObserver:self forKeyPath:@kstKeypath(_badgeView,badgeFont) options:0 context:kKDIBadgeButtonObservingContext];
    [_badgeView addObserver:self forKeyPath:@kstKeypath(_badgeView,badgeEdgeInsets) options:0 context:kKDIBadgeButtonObservingContext];
    [self addSubview:_badgeView];
}
#pragma mark -
- (CGSize)_sizeThatFits:(CGSize)size layout:(BOOL)layout; {
    CGSize retval = size;
    CGSize buttonSize = [self.button sizeThatFits:CGSizeZero];
    CGSize badgeViewSize = [self.badgeView sizeThatFits:CGSizeZero];
    CGRect buttonFrame = CGRectMake(0, 0, buttonSize.width, buttonSize.height);
    CGRect badgeViewFrame = CGRectMake(0, 0, badgeViewSize.width, badgeViewSize.height);
    
    switch (self.badgePosition) {
        case KDIBadgeButtonBadgePositionRelativeToBounds:
            badgeViewFrame.origin = buttonFrame.origin;
            badgeViewFrame.origin.x += ceil(CGRectGetWidth(buttonFrame) * self.badgePositionOffset.x);
            badgeViewFrame.origin.y += ceil(CGRectGetHeight(buttonFrame) * self.badgePositionOffset.y);
            break;
        case KDIBadgeButtonBadgePositionRelativeToImage:
            [self.button setNeedsLayout];
            [self.button layoutIfNeeded];
            
            badgeViewFrame.origin = [self convertRect:self.button.imageView.frame fromView:self.button].origin;
            badgeViewFrame.origin.x += ceil(CGRectGetWidth(self.button.imageView.frame) * self.badgePositionOffset.x);
            badgeViewFrame.origin.y += ceil(CGRectGetHeight(self.button.imageView.frame) * self.badgePositionOffset.y);
            break;
        case KDIBadgeButtonBadgePositionRelativeToTitle:
            [self.button setNeedsLayout];
            [self.button layoutIfNeeded];
            
            badgeViewFrame.origin = [self convertRect:self.button.titleLabel.frame fromView:self.button].origin;
            badgeViewFrame.origin.x += ceil(CGRectGetWidth(self.button.titleLabel.frame) * self.badgePositionOffset.x);
            badgeViewFrame.origin.y += ceil(CGRectGetHeight(self.button.titleLabel.frame) * self.badgePositionOffset.y);
            break;
    }
    
    badgeViewFrame.origin.x += ceil(CGRectGetWidth(badgeViewFrame) * self.badgeSizeOffset.x);
    badgeViewFrame.origin.y += ceil(CGRectGetHeight(badgeViewFrame) * self.badgeSizeOffset.y);
    
    if (CGRectGetMinX(buttonFrame) < 0.0) {
        CGFloat delta = ABS(CGRectGetMinX(buttonFrame));
        
        buttonFrame.origin.x += delta;
        badgeViewFrame.origin.x += delta;
    }
    if (CGRectGetMinX(badgeViewFrame) < 0.0) {
        CGFloat delta = ABS(CGRectGetMinX(badgeViewFrame));
        
        buttonFrame.origin.x += delta;
        badgeViewFrame.origin.x += delta;
    }
    if (CGRectGetMinY(buttonFrame) < 0.0) {
        CGFloat delta = ABS(CGRectGetMinY(buttonFrame));
        
        buttonFrame.origin.y += delta;
        badgeViewFrame.origin.y += delta;
    }
    if (CGRectGetMinY(badgeViewFrame) < 0.0) {
        CGFloat delta = ABS(CGRectGetMinY(badgeViewFrame));
        
        buttonFrame.origin.y += delta;
        badgeViewFrame.origin.y += delta;
    }
    
    retval = CGRectUnion(buttonFrame, badgeViewFrame).size;
    
    if (layout) {
        switch (self.badgePosition) {
            case KDIBadgeButtonBadgePositionRelativeToBounds:
                if (CGRectGetMaxX(badgeViewFrame) > CGRectGetWidth(self.bounds)) {
                    CGFloat delta = CGRectGetMaxX(badgeViewFrame) - CGRectGetWidth(self.bounds);
                    
                    badgeViewFrame.origin.x -= delta;
                    buttonFrame.size.width -= delta;
                }
                if (CGRectGetMaxX(buttonFrame) > CGRectGetWidth(self.bounds)) {
                    CGFloat delta = CGRectGetMaxX(buttonFrame) - CGRectGetWidth(self.bounds);
                    
                    buttonFrame.size.width -= delta;
                }
                break;
            case KDIBadgeButtonBadgePositionRelativeToImage:
                if (CGRectGetMaxX(buttonFrame) > CGRectGetWidth(self.bounds)) {
                    CGFloat delta = CGRectGetMaxX(buttonFrame) - CGRectGetWidth(self.bounds);
                    
                    buttonFrame.size.width -= delta;
                }
                break;
            case KDIBadgeButtonBadgePositionRelativeToTitle:
                if (CGRectGetMaxX(buttonFrame) > CGRectGetWidth(self.bounds)) {
                    CGFloat delta = CGRectGetMaxX(buttonFrame) - CGRectGetWidth(self.bounds);
                    
                    buttonFrame.size.width -= delta;
                }
                break;
            default:
                break;
        }
        
        [self.button setFrame:buttonFrame];
        [self.badgeView setFrame:badgeViewFrame];
    }
    
    return retval;
}

@end
