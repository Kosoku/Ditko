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
#import "UIView+KDIExtensions.h"
#import "NSObject+KDIExtensions.h"

#import <Stanley/Stanley.h>

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

+ (BOOL)requiresConstraintBasedLayout {
    return YES;
}
- (void)updateConstraints {
    NSMutableArray *temp = [[NSMutableArray alloc] init];
    
    NSNumber *margin = @8.0;
    
    [temp addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-margin-[view]-margin-|" options:0 metrics:@{@"margin": margin} views:@{@"view": self.stackView}]];
    [temp addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|->=margin-[view]->=margin-|" options:0 metrics:@{@"margin": margin} views:@{@"view": self.stackView}]];
    
    switch (self.alignmentVertical) {
        case KDIEmptyViewAlignmentVerticalCenter:
            [temp addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|->=margin-[view]->=margin-|" options:0 metrics:@{@"margin": margin} views:@{@"view": self.stackView}]];
            [temp addObject:[NSLayoutConstraint constraintWithItem:self.stackView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0]];
            break;
        case KDIEmptyViewAlignmentVerticalSystemSpacing:
            [temp addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[view]->=margin-|" options:0 metrics:@{@"margin": margin} views:@{@"view": self.stackView}]];
            break;
        case KDIEmptyViewAlignmentVerticalCustomSpacing:
            [temp addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-spacing-[view]->=margin-|" options:0 metrics:@{@"margin": margin, @"spacing": @(self.alignmentVerticalCustomSpacing)} views:@{@"view": self.stackView}]];
            break;
        default:
            break;
    }
    
    [temp addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|->=margin-[view]-[subview]" options:0 metrics:@{@"margin": margin} views:@{@"view": self.activityIndicatorView, @"subview": self.bodyLabel}]];
    [temp addObject:[NSLayoutConstraint constraintWithItem:self.activityIndicatorView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.bodyLabel attribute:NSLayoutAttributeTop multiplier:1.0 constant:0]];
    
    self.KDI_customConstraints = temp;
    
    [super updateConstraints];
}

- (void)tintColorDidChange {
    [super tintColorDidChange];
    
    [self.imageView setTintColor:self.imageColor ?: self.tintColor];
    [self.activityIndicatorView setColor:self.loadingColor ?: self.tintColor];
}

- (void)setAlignmentVertical:(KDIEmptyViewAlignmentVertical)alignmentVertical {
    _alignmentVertical = alignmentVertical;
    
    [self setNeedsUpdateConstraints];
}
- (void)setAlignmentVerticalCustomSpacing:(CGFloat)alignmentVerticalCustomSpacing {
    _alignmentVerticalCustomSpacing = alignmentVerticalCustomSpacing;
    
    [self setNeedsUpdateConstraints];
}

@dynamic image;
- (UIImage *)image {
    return self.imageView.image;
}
- (void)setImage:(UIImage *)image {
    [self.imageView setImage:image];
    [self.imageView setHidden:image == nil];
    [self.imageView setIsAccessibilityElement:!self.imageView.isHidden];
}
- (void)setImageColor:(UIColor *)imageColor {
    _imageColor = imageColor;
    
    [self.imageView setTintColor:_imageColor];
}
@dynamic headline;
- (NSString *)headline {
    return self.headlineLabel.text;
}
- (void)setHeadline:(NSString *)headline {
    [self.headlineLabel setText:headline];
    [self.headlineLabel setHidden:headline.length == 0];
    [self.headlineLabel setIsAccessibilityElement:!self.headlineLabel.isHidden];
}
- (void)setHeadlineColor:(UIColor *)headlineColor {
    _headlineColor = headlineColor ?: [self.class _defaultHeadlineColor];
    
    [self.headlineLabel setTextColor:_headlineColor];
}
- (void)setHeadlineTextStyle:(UIFontTextStyle)headlineTextStyle {
    _headlineTextStyle = headlineTextStyle ?: [self.class _defaultHeadlineTextStyle];
    
    self.headlineLabel.KDI_dynamicTypeTextStyle = _headlineTextStyle;
}
@dynamic body;
- (NSString *)body {
    return self.bodyLabel.text;
}
- (void)setBody:(NSString *)body {
    [self.bodyLabel setText:body];
    [self.bodyLabel setHidden:body.length == 0];
    [self.bodyLabel setIsAccessibilityElement:!self.bodyLabel.isHidden];
}
- (void)setBodyColor:(UIColor *)bodyColor {
    _bodyColor = bodyColor ?: [self.class _defaultBodyColor];
    
    [self.bodyLabel setTextColor:_bodyColor];
}
- (void)setBodyTextStyle:(UIFontTextStyle)bodyTextStyle {
    _bodyTextStyle = bodyTextStyle ?: [self.class _defaultBodyTextStyle];
    
    self.bodyLabel.KDI_dynamicTypeTextStyle = _bodyTextStyle;
}
@dynamic action;
- (NSString *)action {
    return [self.actionButton titleForState:UIControlStateNormal];
}
- (void)setAction:(NSString *)action {
    [self.actionButton setTitle:action forState:UIControlStateNormal];
    [self.actionButton setHidden:action.length == 0];
    [self.actionButton setIsAccessibilityElement:!self.actionButton.isHidden];
}
- (void)setActionTextStyle:(UIFontTextStyle)actionTextStyle {
    _actionTextStyle = actionTextStyle ?: [self.class _defaultActionTextStyle];
    
    self.actionButton.titleLabel.KDI_dynamicTypeTextStyle = _actionTextStyle;
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
- (void)setLoadingColor:(UIColor *)loadingColor {
    _loadingColor = loadingColor;
    
    [self.activityIndicatorView setColor:_loadingColor];
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
    _headlineLabel.KDI_dynamicTypeTextStyle = _headlineTextStyle;
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
    _bodyLabel.KDI_dynamicTypeTextStyle = _bodyTextStyle;
    [_stackView addArrangedSubview:_bodyLabel];
    
    _actionButton = [UIButton buttonWithType:UIButtonTypeSystem];
    _actionButton.translatesAutoresizingMaskIntoConstraints = NO;
    _actionButton.titleLabel.KDI_dynamicTypeTextStyle = _actionTextStyle;
    [_actionButton KDI_addBlock:^(__kindof UIControl * _Nonnull control, UIControlEvents controlEvents) {
        kstStrongify(self);
        if (self.actionBlock != nil) {
            self.actionBlock(self);
        }
    } forControlEvents:UIControlEventTouchUpInside];
    [_stackView addArrangedSubview:_actionButton];
    
    self.image = nil;
    self.headline = nil;
    self.body = nil;
    self.action = nil;
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
