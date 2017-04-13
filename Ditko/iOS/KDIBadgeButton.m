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

#import <Stanley/KSTScopeMacros.h>

static void *kKDIBadgeButtonObservingContext = &kKDIBadgeButtonObservingContext;

@interface KDIBadgeButton ()
@property (readwrite,strong,nonatomic) KDIBadgeView *badgeView;

- (void)_KDIBadgeButtonInit;
@end

@implementation KDIBadgeButton

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

- (void)didAddSubview:(UIView *)subview {
    [super didAddSubview:subview];
    
    [self bringSubviewToFront:self.badgeView];
}
- (void)layoutSubviews {
    [super layoutSubviews];
    
    if (self.badgeView.isHidden) {
        return;
    }
    
    CGSize badgeViewSize = [self.badgeView sizeThatFits:CGSizeZero];
    
    switch (self.badgePosition) {
        case KDIBadgeButtonBadgePositionTopLeft:
            [self.badgeView setFrame:CGRectMake(CGRectGetMinX(self.imageView.frame) - floor(badgeViewSize.width * 0.5), CGRectGetMinY(self.imageView.frame) - floor(badgeViewSize.height * 0.5), badgeViewSize.width, badgeViewSize.height)];
            break;
        case KDIBadgeButtonBadgePositionTopRight:
            [self.badgeView setFrame:CGRectMake(CGRectGetMaxX(self.imageView.frame) - floor(badgeViewSize.width * 0.5), CGRectGetMinY(self.imageView.frame) - floor(badgeViewSize.height * 0.5), badgeViewSize.width, badgeViewSize.height)];
            break;
        case KDIBadgeButtonBadgePositionBottomLeft:
            [self.badgeView setFrame:CGRectMake(CGRectGetMinX(self.imageView.frame) - floor(badgeViewSize.width * 0.5), CGRectGetMaxY(self.imageView.frame) - floor(badgeViewSize.height * 0.5), badgeViewSize.width, badgeViewSize.height)];
            break;
        case KDIBadgeButtonBadgePositionBottomRight:
            [self.badgeView setFrame:CGRectMake(CGRectGetMaxX(self.imageView.frame) - floor(badgeViewSize.width * 0.5), CGRectGetMaxY(self.imageView.frame) - floor(badgeViewSize.height * 0.5), badgeViewSize.width, badgeViewSize.height)];
            break;
        default:
            break;
    }
}

- (CGSize)intrinsicContentSize {
    CGSize retval = [super intrinsicContentSize];
    
    if (!self.badgeView.isHidden) {
        CGSize badgeViewSize = [self.badgeView sizeThatFits:CGSizeZero];
        
        retval.width += badgeViewSize.width;
        retval.height += badgeViewSize.height;
    }
    
    return retval;
}
- (CGSize)sizeThatFits:(CGSize)size {
    CGSize retval = [super sizeThatFits:size];
    
    if (!self.badgeView.isHidden) {
        CGSize badgeViewSize = [self.badgeView sizeThatFits:CGSizeZero];
        
        retval.width += badgeViewSize.width;
        retval.height += badgeViewSize.height;
    }
    
    return retval;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if (context == kKDIBadgeButtonObservingContext) {
        if ([keyPath isEqualToString:@kstKeypath(self.badgeView,badge)]) {
            [self.badgeView setHidden:self.badgeView.badge.length == 0];
            
            [self setNeedsLayout];
            [self invalidateIntrinsicContentSize];
        }
        else if ([keyPath isEqualToString:@kstKeypath(self.badgeView,badgeFont)] ||
                 [keyPath isEqualToString:@kstKeypath(self.badgeView,badgeEdgeInsets)]) {
            
            [self setNeedsLayout];
            [self invalidateIntrinsicContentSize];
        }
    }
    else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

- (void)_KDIBadgeButtonInit; {
    _badgePosition = KDIBadgeButtonBadgePositionTopRight;
    
    _badgeView = [[KDIBadgeView alloc] initWithFrame:CGRectZero];
    [_badgeView setBadgeFont:[UIFont boldSystemFontOfSize:13.0]];
    [_badgeView setBadgeBackgroundColor:[UIColor redColor]];
    [_badgeView addObserver:self forKeyPath:@kstKeypath(_badgeView,badge) options:0 context:kKDIBadgeButtonObservingContext];
    [_badgeView addObserver:self forKeyPath:@kstKeypath(_badgeView,badgeFont) options:0 context:kKDIBadgeButtonObservingContext];
    [_badgeView addObserver:self forKeyPath:@kstKeypath(_badgeView,badgeEdgeInsets) options:0 context:kKDIBadgeButtonObservingContext];
    [self addSubview:_badgeView];
}

@end
