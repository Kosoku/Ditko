//
//  KDIBadgeButton.m
//  Ditko
//
//  Created by William Towe on 4/13/17.
//  Copyright © 2021 Kosoku Interactive, LLC. All rights reserved.
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
+ (void)initialize {
    if (self != KDIBadgeButton.class) {
        return;
    }
    
    if (KDIBadgeView.appearance.badgeFont == nil &&
        [KDIBadgeView appearanceWhenContainedInInstancesOfClasses:@[KDIBadgeButton.class]].badgeFont == nil) {
        
        [KDIBadgeView appearanceWhenContainedInInstancesOfClasses:@[KDIBadgeButton.class]].badgeFont = [UIFont preferredFontForTextStyle:UIFontTextStyleCaption2];
    }
    if (KDIBadgeView.appearance.badgeForegroundColor == nil &&
        [KDIBadgeView appearanceWhenContainedInInstancesOfClasses:@[KDIBadgeButton.class]].badgeForegroundColor == nil) {
        
        [[KDIBadgeView appearanceWhenContainedInInstancesOfClasses:@[KDIBadgeButton.class]] setBadgeForegroundColor:UIColor.whiteColor];
        [[KDIBadgeView appearanceWhenContainedInInstancesOfClasses:@[KDIBadgeButton.class]] setBadgeHighlightedForegroundColor:[UIColor.whiteColor colorWithAlphaComponent:0.5]];
    }
    if (KDIBadgeView.appearance.badgeBackgroundColor == nil &&
        [KDIBadgeView appearanceWhenContainedInInstancesOfClasses:@[KDIBadgeButton.class]].badgeBackgroundColor == nil) {
        
        [[KDIBadgeView appearanceWhenContainedInInstancesOfClasses:@[KDIBadgeButton.class]] setBadgeBackgroundColor:UIColor.redColor];
        [[KDIBadgeView appearanceWhenContainedInInstancesOfClasses:@[KDIBadgeButton.class]] setBadgeHighlightedBackgroundColor:[UIColor.redColor colorWithAlphaComponent:0.5]];
    }
}

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
#pragma mark -
- (NSArray *)accessibilityElements {
    NSMutableArray *retval = [[NSMutableArray alloc] init];
    
    if (self.accessibilityOptions & KDIBadgeButtonAccessibilityOptionsElementButton) {
        [retval addObject:self.button];
    }
    if (self.accessibilityOptions & KDIBadgeButtonAccessibilityOptionsElementBadgeView) {
        [retval addObject:self.badgeView];
    }
    
    return [retval copy];
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
- (void)setBadgePositionOffset:(UIOffset)badgePositionOffset {
    _badgePositionOffset = badgePositionOffset;
    
    [self setNeedsLayout];
    [self invalidateIntrinsicContentSize];
}
- (void)setBadgeSizeOffset:(UIOffset)badgeSizeOffset {
    _badgeSizeOffset = badgeSizeOffset;
    
    [self setNeedsLayout];
    [self invalidateIntrinsicContentSize];
}
#pragma mark *** Private Methods ***
- (void)_KDIBadgeButtonInit; {
    _accessibilityOptions = KDIBadgeButtonAccessibilityOptionsAll;
    _badgePosition = KDIBadgeButtonBadgePositionRelativeToBounds;
    _badgePositionOffset = UIOffsetMake(1.0, 0.0);
    _badgeSizeOffset = UIOffsetMake(-0.25, -0.25);
    
    _button = [KDIButton buttonWithType:UIButtonTypeSystem];
    [_button addObserver:self forKeyPath:@kstKeypath(_button,highlighted) options:0 context:kKDIBadgeButtonObservingContext];
    [_button addObserver:self forKeyPath:@kstKeypath(_button,titleContentVerticalAlignment) options:0 context:kKDIBadgeButtonObservingContext];
    [_button addObserver:self forKeyPath:@kstKeypath(_button,titleContentHorizontalAlignment) options:0 context:kKDIBadgeButtonObservingContext];
    [_button addObserver:self forKeyPath:@kstKeypath(_button,imageContentVerticalAlignment) options:0 context:kKDIBadgeButtonObservingContext];
    [_button addObserver:self forKeyPath:@kstKeypath(_button,imageContentHorizontalAlignment) options:0 context:kKDIBadgeButtonObservingContext];
    [self addSubview:_button];
    
    _badgeView = [[KDIBadgeView alloc] initWithFrame:CGRectZero];
    [_badgeView setUserInteractionEnabled:NO];
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
            badgeViewFrame.origin.x += ceil(CGRectGetWidth(buttonFrame) * self.badgePositionOffset.horizontal);
            badgeViewFrame.origin.y += ceil(CGRectGetHeight(buttonFrame) * self.badgePositionOffset.vertical);
            break;
        case KDIBadgeButtonBadgePositionRelativeToImage:
            [self.button setNeedsLayout];
            [self.button layoutIfNeeded];
            
            badgeViewFrame.origin = [self convertRect:self.button.imageView.frame fromView:self.button].origin;
            badgeViewFrame.origin.x += ceil(CGRectGetWidth(self.button.imageView.frame) * self.badgePositionOffset.horizontal);
            badgeViewFrame.origin.y += ceil(CGRectGetHeight(self.button.imageView.frame) * self.badgePositionOffset.vertical);
            break;
        case KDIBadgeButtonBadgePositionRelativeToTitle:
            [self.button setNeedsLayout];
            [self.button layoutIfNeeded];
            
            badgeViewFrame.origin = [self convertRect:self.button.titleLabel.frame fromView:self.button].origin;
            badgeViewFrame.origin.x += ceil(CGRectGetWidth(self.button.titleLabel.frame) * self.badgePositionOffset.horizontal);
            badgeViewFrame.origin.y += ceil(CGRectGetHeight(self.button.titleLabel.frame) * self.badgePositionOffset.vertical);
            break;
    }
    
    badgeViewFrame.origin.x += ceil(CGRectGetWidth(badgeViewFrame) * self.badgeSizeOffset.horizontal);
    badgeViewFrame.origin.y += ceil(CGRectGetHeight(badgeViewFrame) * self.badgeSizeOffset.vertical);
    
    buttonFrame = CGRectStandardize(buttonFrame);
    badgeViewFrame = CGRectStandardize(badgeViewFrame);
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
