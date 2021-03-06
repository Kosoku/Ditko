//
//  KDIEmptyView.m
//  Ditko
//
//  Created by William Towe on 4/28/17.
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
            [temp addObject:[NSLayoutConstraint constraintWithItem:self.stackView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0]];
            break;
        case KDIEmptyViewAlignmentVerticalSystemSpacingFromTop:
            [temp addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[view]->=margin-|" options:0 metrics:@{@"margin": margin} views:@{@"view": self.stackView}]];
            break;
        case KDIEmptyViewAlignmentVerticalCustomSpacingFromTop:
            [temp addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-spacing-[view]->=margin-|" options:0 metrics:@{@"margin": margin, @"spacing": @(self.alignmentVerticalCustomSpacing)} views:@{@"view": self.stackView}]];
            break;
        case KDIEmptyViewAlignmentVerticalSystemSpacingFromBottom:
            [temp addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|->=margin-[view]-|" options:0 metrics:@{@"margin": margin} views:@{@"view": self.stackView}]];
            break;
        case KDIEmptyViewAlignmentVerticalCustomSpacingFromBottom:
            [temp addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|->=margin-[view]-spacing-|" options:0 metrics:@{@"margin": margin, @"spacing": @(self.alignmentVerticalCustomSpacing)} views:@{@"view": self.stackView}]];
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
    
    [self.activityIndicatorView setColor:self.loadingColor ?: self.bodyColor];
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
    [self.imageView setIsAccessibilityElement:!self.imageView.isHidden && self.imageAccessibilityLabel.length > 0];
}
- (void)setImageColor:(UIColor *)imageColor {
    _imageColor = imageColor;
    
    [self.imageView setTintColor:_imageColor];
}
@dynamic imageAccessibilityLabel;
- (NSString *)imageAccessibilityLabel {
    return self.imageView.accessibilityLabel;
}
- (void)setImageAccessibilityLabel:(NSString *)imageAccessibilityLabel {
    self.imageView.accessibilityLabel = imageAccessibilityLabel;
    
    [self.imageView setIsAccessibilityElement:!self.imageView.isHidden && self.imageAccessibilityLabel.length > 0];
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
    
    _imageColor = [self.class _defaultHeadlineColor];
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
    _imageView.tintColor = _imageColor;
    [_stackView addArrangedSubview:_imageView];
    
    _headlineLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _headlineLabel.translatesAutoresizingMaskIntoConstraints = NO;
    _headlineLabel.textColor = _headlineColor;
    _headlineLabel.KDI_dynamicTypeTextStyle = _headlineTextStyle;
    [_stackView addArrangedSubview:_headlineLabel];
    
    _activityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleMedium];
    _activityIndicatorView.translatesAutoresizingMaskIntoConstraints = NO;
    _activityIndicatorView.hidesWhenStopped = YES;
    _activityIndicatorView.color = _bodyColor;
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
