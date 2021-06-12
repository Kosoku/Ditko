//
//  KDIProgressSlider.m
//  Ditko
//
//  Created by William Towe on 3/10/17.
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

#import "KDIProgressSlider.h"

@interface KDIProgressSlider ()

- (void)_KDIProgressSliderInit;

+ (UIColor *)_defaultMaximumTrackFillColor;
+ (UIColor *)_defaultProgressFillColor;
@end

@implementation KDIProgressSlider

- (instancetype)initWithFrame:(CGRect)frame {
    if (!(self = [super initWithFrame:frame]))
        return nil;
    
    [self _KDIProgressSliderInit];
    
    return self;
}
- (id)initWithCoder:(NSCoder *)aDecoder {
    if (!(self = [super initWithCoder:aDecoder]))
        return nil;
    
    [self _KDIProgressSliderInit];
    
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    if (!self.isTracking) {
        [self setNeedsDisplay];
    }
}

- (void)drawRect:(CGRect)rect {
    CGRect trackRect = [self trackRectForBounds:self.bounds];
    
    [self.maximumTrackFillColor setFill];
    UIRectFill(trackRect);
    
    if (self.progressRanges.count > 0) {
        CGRect trackRect = [self trackRectForBounds:self.bounds];
        CGFloat availableWidth = CGRectGetWidth(trackRect);
        
        [self.progressFillColor setFill];
        
        [self.progressRanges enumerateObjectsUsingBlock:^(NSArray<NSNumber *> * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            CGFloat startX = CGRectGetMinX(trackRect) + floorf(availableWidth * obj.firstObject.floatValue);
            CGFloat width = startX + floorf(availableWidth * obj.lastObject.floatValue);
            
            UIRectFill(CGRectMake(startX, CGRectGetMinY(trackRect), width, CGRectGetHeight(trackRect)));
        }];
    }
    
    CGRect thumbRect = [self thumbRectForBounds:self.bounds trackRect:trackRect value:self.value];
    
    [self.minimumTrackFillColor setFill];
    UIRectFill(CGRectMake(CGRectGetMinX(trackRect), CGRectGetMinY(trackRect), CGRectGetMidX(thumbRect), CGRectGetHeight(trackRect)));
}

- (BOOL)continueTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event {
    BOOL retval = [super continueTrackingWithTouch:touch withEvent:event];
    
    if (retval) {
        [self setNeedsDisplay];
    }
    
    return retval;
}

@dynamic progress;
- (float)progress {
    return self.progressRanges.lastObject.lastObject.floatValue;
}
- (void)setProgress:(float)progress {
    [self setProgressRanges:@[@[@0.0,@(progress)]]];
}

- (void)setProgressRanges:(NSArray<NSArray<NSNumber *> *> *)progressRanges {
    _progressRanges = [progressRanges copy];
    
    [self setNeedsDisplay];
}

@synthesize minimumTrackFillColor=_minimumTrackFillColor;
- (UIColor *)minimumTrackFillColor {
    return _minimumTrackFillColor ?: self.tintColor;
}
- (void)setMinimumTrackFillColor:(UIColor *)minimumTrackFillColor {
    _minimumTrackFillColor = minimumTrackFillColor;
    
    [self setNeedsDisplay];
}
- (void)setMaximumTrackFillColor:(UIColor *)maximumTrackFillColor {
    _maximumTrackFillColor = maximumTrackFillColor ?: [self.class _defaultMaximumTrackFillColor];
    
    [self setNeedsDisplay];
}
- (void)setProgressFillColor:(UIColor *)progressFillColor {
    _progressFillColor = progressFillColor ?: [self.class _defaultProgressFillColor];
    
    [self setNeedsDisplay];
}

- (void)_KDIProgressSliderInit; {
    _progressFillColor = [self.class _defaultProgressFillColor];
    _maximumTrackFillColor = [self.class _defaultMaximumTrackFillColor];
    
    [self setMinimumTrackTintColor:[UIColor clearColor]];
    [self setMaximumTrackTintColor:[UIColor clearColor]];
}

+ (UIColor *)_defaultMaximumTrackFillColor; {
    return [UIColor lightGrayColor];
}
+ (UIColor *)_defaultProgressFillColor; {
    return [UIColor darkGrayColor];
}

@end
