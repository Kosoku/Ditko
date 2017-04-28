//
//  KDIEmptyView.m
//  Ditko
//
//  Created by William Towe on 4/28/17.
//  Copyright © 2017 Kosoku Interactive, LLC. All rights reserved.
//
//  Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
//
//  1. Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
//
//  2. Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
//
//  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

#import "KDIEmptyView.h"
#import "UIControl+KDIExtensions.h"

#import <Stanley/KSTScopeMacros.h>

@interface KDIEmptyView ()
@property (strong,nonatomic) UIView *containerView;
@property (strong,nonatomic) UIImageView *imageView;
@property (strong,nonatomic) UILabel *headlineLabel;
@property (strong,nonatomic) UILabel *bodyLabel;
@property (strong,nonatomic) UIButton *actionButton;

@property (copy,nonatomic) NSArray *activeConstraints;

- (void)_KDIEmptyViewInit;
+ (UIColor *)_defaultHeadlineColor;
+ (UIColor *)_defaultBodyColor;
@end

@implementation KDIEmptyView

- (instancetype)initWithFrame:(CGRect)frame {
    if (!(self = [super initWithFrame:frame]))
        return nil;
    
    [self _KDIEmptyViewInit];
    
    return self;
}
- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (!(self = [super initWithCoder:aDecoder]))
        return nil;
    
    [self _KDIEmptyViewInit];
    
    return self;
}

- (void)updateConstraints {
    [NSLayoutConstraint deactivateConstraints:self.activeConstraints];
    
    NSMutableArray *constraints = [[NSMutableArray alloc] init];
    UIView *previousView = nil;
    
    if (self.image != nil) {
        [constraints addObject:[NSLayoutConstraint constraintWithItem:self.imageView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.containerView attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0]];
        [constraints addObject:[NSLayoutConstraint constraintWithItem:self.imageView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.containerView attribute:NSLayoutAttributeTop multiplier:1.0 constant:0]];
        
        previousView = self.imageView;
    }
    
    if (self.headline.length > 0) {
        [constraints addObject:[NSLayoutConstraint constraintWithItem:self.headlineLabel attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.containerView attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0]];
        
        if (previousView == nil) {
            [constraints addObject:[NSLayoutConstraint constraintWithItem:self.headlineLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.containerView attribute:NSLayoutAttributeTop multiplier:1.0 constant:0]];
        }
        else {
            [constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[subview]-[view]" options:0 metrics:nil views:@{@"view": self.headlineLabel, @"subview": previousView}]];
        }
        
        previousView = self.headlineLabel;
    }
    
    if (self.body.length > 0) {
        [constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[view]|" options:0 metrics:nil views:@{@"view": self.bodyLabel}]];
        
        if (previousView == nil) {
            [constraints addObject:[NSLayoutConstraint constraintWithItem:self.bodyLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.containerView attribute:NSLayoutAttributeTop multiplier:1.0 constant:0]];
        }
        else {
            [constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[subview]-[view]" options:0 metrics:nil views:@{@"view": self.bodyLabel, @"subview": previousView}]];
        }
        
        previousView = self.bodyLabel;
    }
    
    if (self.action.length > 0) {
        [constraints addObject:[NSLayoutConstraint constraintWithItem:self.actionButton attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.containerView attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0]];
        
        if (previousView == nil) {
            [constraints addObject:[NSLayoutConstraint constraintWithItem:self.actionButton attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.containerView attribute:NSLayoutAttributeTop multiplier:1.0 constant:0]];
        }
        else {
            [constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[subview]-[view]" options:0 metrics:nil views:@{@"view": self.actionButton, @"subview": previousView}]];
        }
        
        previousView = self.actionButton;
    }
    
    if (previousView != nil) {
        [constraints addObject:[NSLayoutConstraint constraintWithItem:previousView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.containerView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0]];
    }
    
    CGFloat padding = 20.0;
    
    [constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-padding-[view]-padding-|" options:0 metrics:@{@"padding": @(padding)} views:@{@"view": self.containerView}]];
    [constraints addObject:[NSLayoutConstraint constraintWithItem:self.containerView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0]];
    
    [self setActiveConstraints:constraints];
    
    [NSLayoutConstraint activateConstraints:constraints];
    
    [super updateConstraints];
}

@dynamic image;
- (UIImage *)image {
    return self.imageView.image;
}
- (void)setImage:(UIImage *)image {
    BOOL wasVisible = self.image != nil;
    
    [self.imageView setImage:image];
    
    if (image != nil &&
        !wasVisible) {
        
        [self.containerView addSubview:self.imageView];
        [self setNeedsUpdateConstraints];
    }
    else if (image == nil &&
             wasVisible) {
        
        [self.imageView removeFromSuperview];
        [self setNeedsUpdateConstraints];
    }
}
@dynamic headline;
- (NSString *)headline {
    return self.headlineLabel.text;
}
- (void)setHeadline:(NSString *)headline {
    BOOL wasVisible = self.headline.length > 0;
    
    [self.headlineLabel setText:headline];
    
    if (headline.length > 0 &&
        !wasVisible) {
        
        [self.containerView addSubview:self.headlineLabel];
        [self setNeedsUpdateConstraints];
    }
    else if (headline.length == 0 &&
             wasVisible) {
        
        [self.headlineLabel removeFromSuperview];
        [self setNeedsUpdateConstraints];
    }
}
- (void)setHeadlineColor:(UIColor *)headlineColor {
    _headlineColor = headlineColor ?: [self.class _defaultHeadlineColor];
    
    [self.headlineLabel setTextColor:_headlineColor];
}
@dynamic body;
- (NSString *)body {
    return self.bodyLabel.text;
}
- (void)setBody:(NSString *)body {
    BOOL wasVisible = self.body.length > 0;
    
    [self.bodyLabel setText:body];
    
    if (body.length > 0 &&
        !wasVisible) {
        
        [self.containerView addSubview:self.bodyLabel];
        [self setNeedsUpdateConstraints];
    }
    else if (body.length == 0 &&
             wasVisible) {
        
        [self.bodyLabel removeFromSuperview];
        [self setNeedsUpdateConstraints];
    }
}
- (void)setBodyColor:(UIColor *)bodyColor {
    _bodyColor = bodyColor ?: [self.class _defaultBodyColor];
    
    [self.bodyLabel setTextColor:_bodyColor];
}
@dynamic action;
- (NSString *)action {
    return [self.actionButton titleForState:UIControlStateNormal];
}
- (void)setAction:(NSString *)action {
    BOOL wasVisible = self.action.length > 0;
    
    [self.actionButton setTitle:action forState:UIControlStateNormal];
    
    if (action.length > 0 &&
        !wasVisible) {
        
        [self.containerView addSubview:self.actionButton];
        [self setNeedsUpdateConstraints];
    }
    else if (action.length == 0 &&
             wasVisible) {
        
        [self.actionButton removeFromSuperview];
        [self setNeedsUpdateConstraints];
    }
}

- (void)_KDIEmptyViewInit; {
    _headlineColor = [self.class _defaultHeadlineColor];
    _bodyColor = [self.class _defaultBodyColor];
    
    _containerView = [[UIView alloc] initWithFrame:CGRectZero];
    [_containerView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self addSubview:_containerView];
    
    _imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    [_imageView setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    _headlineLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    [_headlineLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    [_headlineLabel setAdjustsFontForContentSizeCategory:YES];
    [_headlineLabel setFont:[UIFont preferredFontForTextStyle:UIFontTextStyleHeadline]];
    [_headlineLabel setTextColor:UIColor.blackColor];
    
    _bodyLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    [_bodyLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    [_bodyLabel setNumberOfLines:0];
    [_bodyLabel setTextAlignment:NSTextAlignmentCenter];
    [_bodyLabel setAdjustsFontForContentSizeCategory:YES];
    [_bodyLabel setFont:[UIFont preferredFontForTextStyle:UIFontTextStyleBody]];
    [_bodyLabel setTextColor:UIColor.grayColor];
    
    _actionButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [_actionButton setTranslatesAutoresizingMaskIntoConstraints:NO];
    [_actionButton.titleLabel setAdjustsFontForContentSizeCategory:YES];
    [_actionButton.titleLabel setFont:[UIFont preferredFontForTextStyle:UIFontTextStyleBody]];
    kstWeakify(self);
    [_actionButton KDI_addBlock:^(__kindof UIControl * _Nonnull control, UIControlEvents controlEvents) {
        kstStrongify(self);
        if (self.actionBlock != nil) {
            self.actionBlock();
        }
    } forControlEvents:UIControlEventTouchUpInside];
}

+ (UIColor *)_defaultHeadlineColor; {
    return UIColor.blackColor;
}
+ (UIColor *)_defaultBodyColor; {
    return UIColor.grayColor;
}

@end
