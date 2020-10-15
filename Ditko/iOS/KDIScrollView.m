//
//  KDIScrollView.m
//  Ditko-iOS
//
//  Created by William Towe on 11/9/17.
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

#import "KDIScrollView.h"

@interface KDIScrollView ()
@property (strong,nonatomic) CALayer *maskLayer;
@property (strong,nonatomic) CAGradientLayer *gradientLayer;

- (void)_KDIScrollViewInit;
- (void)_createMaskLayerIfNecessary;
- (void)_updateMaskLayer;
@end

@implementation KDIScrollView

- (void)setFadeAxis:(KDIScrollViewFadeAxis)fadeAxis {
    if (_fadeAxis == fadeAxis) {
        return;
    }
    
    _fadeAxis = fadeAxis;
    
    [self _createMaskLayerIfNecessary];
    [self _updateMaskLayer];
}
- (void)setLeadingEdgeFadePercentage:(float)leadingEdgeFadePercentage {
    _leadingEdgeFadePercentage = leadingEdgeFadePercentage;
    
    [self _updateMaskLayer];
}
- (void)setTrailingEdgeFadePercentage:(float)trailingEdgeFadePercentage {
    _trailingEdgeFadePercentage = trailingEdgeFadePercentage;
    
    [self _updateMaskLayer];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    if (self.fadeAxis == KDIScrollViewFadeAxisNone) {
        return;
    }
    
    [CATransaction begin];
    [CATransaction setDisableActions:YES];
    
    self.maskLayer.frame = self.bounds;
    
    [CATransaction commit];
    
    self.gradientLayer.frame = self.maskLayer.bounds;
    
    NSInteger offset = roundf(self.fadeAxis == KDIScrollViewFadeAxisHorizontal ? self.contentOffset.x : self.contentOffset.y);
    NSMutableArray *colors = [[NSMutableArray alloc] init];
    id transparentColor = (__bridge id)UIColor.clearColor.CGColor;
    id opaqueColor = (__bridge id)UIColor.blackColor.CGColor;
    
    if (self.leadingEdgeFadePercentage > 0.0) {
        if (offset <= 0) {
            [colors addObjectsFromArray:@[opaqueColor, opaqueColor]];
        }
        else if (offset > 0) {
            [colors addObjectsFromArray:@[transparentColor, opaqueColor]];
        }
    }
    if (self.trailingEdgeFadePercentage > 0.0) {
        NSInteger maxOffset = roundf(self.fadeAxis == KDIScrollViewFadeAxisHorizontal ? self.contentSize.width - CGRectGetWidth(self.bounds) : self.contentSize.height - CGRectGetHeight(self.bounds));
        
        if (offset >= maxOffset) {
            [colors addObjectsFromArray:@[opaqueColor, opaqueColor]];
        }
        else if (offset < maxOffset) {
            [colors addObjectsFromArray:@[opaqueColor, transparentColor]];
        }
    }
    
    self.gradientLayer.colors = colors;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (!(self = [super initWithFrame:frame]))
        return nil;
    
    [self _KDIScrollViewInit];
    
    return self;
}
- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (!(self = [super initWithCoder:aDecoder]))
        return nil;
    
    [self _KDIScrollViewInit];
    
    return self;
}

- (void)_KDIScrollViewInit; {
    _fadeAxis = KDIScrollViewFadeAxisNone;
    
    [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(_keyboardNotification:) name:UIKeyboardWillShowNotification object:nil];
    [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(_keyboardNotification:) name:UIKeyboardWillHideNotification object:nil];
}
- (void)_createMaskLayerIfNecessary; {
    if (self.fadeAxis == KDIScrollViewFadeAxisNone) {
        self.layer.mask = nil;
        self.maskLayer = nil;
        self.gradientLayer = nil;
        return;
    }
    
    if (self.maskLayer != nil) {
        return;
    }
    
    self.maskLayer = [CALayer layer];
    self.maskLayer.frame = self.bounds;
    
    self.gradientLayer = [CAGradientLayer layer];
    self.gradientLayer.frame = CGRectMake(0.0, 0.0, self.bounds.size.width, self.bounds.size.height);
    
    [self.maskLayer addSublayer:self.gradientLayer];
    
    self.layer.mask = self.maskLayer;
}
- (void)_updateMaskLayer; {
    if (self.fadeAxis == KDIScrollViewFadeAxisNone) {
        return;
    }
    
    NSMutableArray *colors = [[NSMutableArray alloc] init];
    NSMutableArray *locations = [[NSMutableArray alloc] init];
    id transparentColor = (__bridge id)UIColor.clearColor.CGColor;
    id opaqueColor = (__bridge id)UIColor.blackColor.CGColor;
    
    if (self.leadingEdgeFadePercentage > 0.0) {
        [colors addObjectsFromArray:@[transparentColor, opaqueColor]];
        [locations addObjectsFromArray:@[@0.0, @(self.leadingEdgeFadePercentage)]];
    }
    if (self.trailingEdgeFadePercentage > 0.0) {
        [colors addObjectsFromArray:@[opaqueColor, transparentColor]];
        [locations addObjectsFromArray:@[@(1.0 - self.trailingEdgeFadePercentage), @1.0]];
    }
    
    [CATransaction begin];
    [CATransaction setDisableActions:YES];
    
    switch (self.fadeAxis) {
        case KDIScrollViewFadeAxisHorizontal:
            self.gradientLayer.startPoint = CGPointMake(0.0, 0.5);
            self.gradientLayer.endPoint = CGPointMake(1.0, 0.5);
            break;
        case KDIScrollViewFadeAxisVertical:
            self.gradientLayer.startPoint = CGPointMake(0.5, 0.0);
            self.gradientLayer.endPoint = CGPointMake(0.5, 1.0);
            break;
        case KDIScrollViewFadeAxisNone:
            break;
    }
    
    [CATransaction commit];
    
    self.gradientLayer.colors = colors;
    self.gradientLayer.locations = locations;
    
    [self setNeedsLayout];
}

- (void)_keyboardNotification:(NSNotification *)notification {
    if (!self.adjustsContentInsetForKeyboard) {
        return;
    }
    
    CGRect keyboardFrame = [self convertRect:[self.window convertRect:[notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue] fromWindow:nil] fromView:nil];
    NSTimeInterval duration = [notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    UIViewAnimationCurve curve = [notification.userInfo[UIKeyboardAnimationCurveUserInfoKey] integerValue];
    
    if ([notification.name isEqualToString:UIKeyboardWillShowNotification]) {
        [UIView animateWithDuration:duration delay:0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
            [UIView setAnimationCurve:curve];
            
            self.contentInset = UIEdgeInsetsMake(0, 0, CGRectGetHeight(CGRectIntersection(keyboardFrame, self.bounds)), 0);
        } completion:^(BOOL finished) {
            if (finished) {
                [self flashScrollIndicators];
            }
        }];
    }
    else {
        [UIView animateWithDuration:duration delay:0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
            [UIView setAnimationCurve:curve];
            
            self.contentInset = UIEdgeInsetsZero;
        } completion:^(BOOL finished) {
            if (finished) {
                [self flashScrollIndicators];
            }
        }];
    }
}

@end
