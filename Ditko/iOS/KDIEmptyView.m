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
#import "UIFont+KDIDynamicTypeExtensions.h"

#import <Stanley/KSTScopeMacros.h>

@interface KDIEmptyView ()
@property (strong,nonatomic) UIStackView *stackView;
@property (strong,nonatomic) UIImageView *imageView;
@property (strong,nonatomic) UILabel *headlineLabel;
@property (strong,nonatomic) UIActivityIndicatorView *activityIndicatorView;
@property (strong,nonatomic) UILabel *bodyLabel;
@property (strong,nonatomic) UIButton *actionButton;

@property (copy,nonatomic) NSArray *activeConstraints;

- (void)_KDIEmptyViewInit;
+ (UIColor *)_defaultHeadlineColor;
+ (UIFontTextStyle)_defaultHeadlineTextStyle;
+ (UIColor *)_defaultBodyColor;
+ (UIFontTextStyle)_defaultBodyTextStyle;
+ (UIFontTextStyle)_defaultActionTextStyle;
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

- (void)tintColorDidChange {
    [super tintColorDidChange];
    
    [self.imageView setTintColor:self.tintColor];
    [self.activityIndicatorView setColor:self.tintColor];
}

@dynamic image;
- (UIImage *)image {
    return self.imageView.image;
}
- (void)setImage:(UIImage *)image {
    [self.imageView setImage:image];
    [self.imageView setHidden:image == nil];
}
@dynamic headline;
- (NSString *)headline {
    return self.headlineLabel.text;
}
- (void)setHeadline:(NSString *)headline {
    [self.headlineLabel setText:headline];
    [self.headlineLabel setHidden:headline.length == 0];
}
- (void)setHeadlineColor:(UIColor *)headlineColor {
    _headlineColor = headlineColor ?: [self.class _defaultHeadlineColor];
    
    [self.headlineLabel setTextColor:_headlineColor];
}
- (void)setHeadlineTextStyle:(UIFontTextStyle)headlineTextStyle {
    _headlineTextStyle = headlineTextStyle ?: [self.class _defaultHeadlineTextStyle];
    
    [NSObject KDI_registerDynamicTypeObject:self.headlineLabel forTextStyle:_headlineTextStyle];
}
@dynamic body;
- (NSString *)body {
    return self.bodyLabel.text;
}
- (void)setBody:(NSString *)body {
    [self.bodyLabel setText:body];
    [self.bodyLabel setHidden:body.length == 0];
}
- (void)setBodyColor:(UIColor *)bodyColor {
    _bodyColor = bodyColor ?: [self.class _defaultBodyColor];
    
    [self.bodyLabel setTextColor:_bodyColor];
}
- (void)setBodyTextStyle:(UIFontTextStyle)bodyTextStyle {
    _bodyTextStyle = bodyTextStyle ?: [self.class _defaultBodyTextStyle];
    
    [NSObject KDI_registerDynamicTypeObject:self.bodyLabel forTextStyle:_bodyTextStyle];
}
@dynamic action;
- (NSString *)action {
    return [self.actionButton titleForState:UIControlStateNormal];
}
- (void)setAction:(NSString *)action {
    [self.actionButton setTitle:action forState:UIControlStateNormal];
    [self.actionButton setHidden:action.length == 0];
}
- (void)setActionTextStyle:(UIFontTextStyle)actionTextStyle {
    _actionTextStyle = actionTextStyle ?: [self.class _defaultActionTextStyle];
    
    [NSObject KDI_registerDynamicTypeObject:self.actionButton.titleLabel forTextStyle:_actionTextStyle];
}
@dynamic loading;
- (BOOL)isLoading {
    return self.activityIndicatorView.isAnimating;
}
- (void)setLoading:(BOOL)loading {
    if (loading) {
        [self.activityIndicatorView startAnimating];
    }
    else {
        [self.activityIndicatorView stopAnimating];
    }
}

- (void)_KDIEmptyViewInit; {
    kstWeakify(self);
    
    _headlineColor = [self.class _defaultHeadlineColor];
    _headlineTextStyle = [self.class _defaultHeadlineTextStyle];
    _bodyColor = [self.class _defaultBodyColor];
    _bodyTextStyle = [self.class _defaultBodyTextStyle];
    _actionTextStyle = [self.class _defaultActionTextStyle];
    
    _stackView = [[UIStackView alloc] initWithFrame:CGRectZero];
    _stackView.translatesAutoresizingMaskIntoConstraints = NO;
    _stackView.axis = UILayoutConstraintAxisVertical;
    _stackView.alignment = UIStackViewAlignmentCenter;
    _stackView.distribution = UIStackViewDistributionEqualSpacing;
    _stackView.spacing = 8.0;
    [self addSubview:_stackView];
    
    _imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    _imageView.translatesAutoresizingMaskIntoConstraints = NO;
    [_stackView addArrangedSubview:_imageView];
    
    _headlineLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _headlineLabel.translatesAutoresizingMaskIntoConstraints = NO;
    _headlineLabel.textColor = _headlineColor;
    [_stackView addArrangedSubview:_headlineLabel];
    
    _activityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    _activityIndicatorView.translatesAutoresizingMaskIntoConstraints = NO;
    _activityIndicatorView.hidesWhenStopped = YES;
    [_stackView addSubview:_activityIndicatorView];
    
    _bodyLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _bodyLabel.translatesAutoresizingMaskIntoConstraints = NO;
    _bodyLabel.numberOfLines = 0;
    _bodyLabel.textAlignment = NSTextAlignmentCenter;
    _bodyLabel.textColor = _bodyColor;
    [_stackView addArrangedSubview:_bodyLabel];
    
    _actionButton = [UIButton buttonWithType:UIButtonTypeSystem];
    _actionButton.translatesAutoresizingMaskIntoConstraints = NO;
    [_actionButton KDI_addBlock:^(__kindof UIControl * _Nonnull control, UIControlEvents controlEvents) {
        kstStrongify(self);
        if (self.actionBlock != nil) {
            self.actionBlock(self);
        }
    } forControlEvents:UIControlEventTouchUpInside];
    [_stackView addArrangedSubview:_actionButton];
    
    [NSObject KDI_registerDynamicTypeObjectsForTextStyles:@{_bodyTextStyle: @[_bodyLabel],
                                                            _headlineTextStyle: @[_headlineLabel],
                                                            _actionTextStyle: @[_actionButton.titleLabel]
                                                            }];
    
    NSNumber *margin = @8.0;
    
    [NSLayoutConstraint activateConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-margin-[view]-margin-|" options:0 metrics:@{@"margin": margin} views:@{@"view": _stackView}]];
    [NSLayoutConstraint activateConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|->=margin-[view]->=margin-|" options:0 metrics:@{@"margin": margin} views:@{@"view": _stackView}]];
    [NSLayoutConstraint activateConstraints:@[[NSLayoutConstraint constraintWithItem:_stackView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0]]];
    
    [NSLayoutConstraint activateConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|->=margin-[view]-[subview]" options:0 metrics:@{@"margin": margin} views:@{@"view": _activityIndicatorView, @"subview": _bodyLabel}]];
    [NSLayoutConstraint activateConstraints:@[[NSLayoutConstraint constraintWithItem:_activityIndicatorView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:_bodyLabel attribute:NSLayoutAttributeTop multiplier:1.0 constant:0]]];
}

+ (UIColor *)_defaultHeadlineColor; {
#if (TARGET_OS_IOS)
    return UIColor.blackColor;
#else
    return nil;
#endif
}
+ (UIFontTextStyle)_defaultHeadlineTextStyle; {
    return UIFontTextStyleHeadline;
}
+ (UIColor *)_defaultBodyColor; {
#if (TARGET_OS_IOS)
    return UIColor.darkGrayColor;
#else
    return nil;
#endif
}
+ (UIFontTextStyle)_defaultBodyTextStyle {
    return UIFontTextStyleBody;
}
+ (UIFontTextStyle)_defaultActionTextStyle {
    return UIFontTextStyleCallout;
}

@end
