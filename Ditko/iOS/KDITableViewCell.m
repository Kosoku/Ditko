//
//  KDITableViewCell.m
//  Ditko
//
//  Created by William Towe on 3/4/18.
//  Copyright © 2018 Kosoku Interactive, LLC. All rights reserved.
//
//  Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
//
//  1. Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
//
//  2. Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
//
//  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

#import "KDITableViewCell.h"
#import "NSObject+KDIExtensions.h"
#import "UIFont+KDIDynamicTypeExtensions.h"

@interface KDITableViewCell ()
@property (strong,nonatomic) UIStackView *stackView;
@property (strong,nonatomic) UIStackView *titleSubtitleStackView;

@property (strong,nonatomic) UIImageView *iconImageView;
@property (strong,nonatomic) UILabel *titleLabel;
@property (strong,nonatomic) UILabel *subtitleLabel;
@property (strong,nonatomic) UILabel *infoLabel;

+ (UIColor *)_defaultTitleColor;
+ (UIColor *)_defaultSubtitleColor;
+ (UIColor *)_defaultInfoColor;
+ (UIFontTextStyle)_defaultTitleTextStyle;
+ (UIFontTextStyle)_defaultSubtitleTextStyle;
+ (UIFontTextStyle)_defaultInfoTextStyle;
@end

@implementation KDITableViewCell
#pragma mark *** Subclass Overrides ***
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (!(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]))
        return nil;
    
    _titleColor = [self.class _defaultTitleColor];
    _subtitleColor = [self.class _defaultSubtitleColor];
    _infoColor = [self.class _defaultInfoColor];
    
    _stackView = [[UIStackView alloc] initWithFrame:CGRectZero];
    _stackView.translatesAutoresizingMaskIntoConstraints = NO;
    _stackView.axis = UILayoutConstraintAxisHorizontal;
    _stackView.alignment = UIStackViewAlignmentCenter;
    _stackView.spacing = 8.0;
    [self.contentView addSubview:_stackView];
    
    _iconImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    _iconImageView.translatesAutoresizingMaskIntoConstraints = NO;
    _iconImageView.hidden = YES;
    [_iconImageView setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    [_iconImageView setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    [_stackView addArrangedSubview:_iconImageView];
    
    _titleSubtitleStackView = [[UIStackView alloc] initWithFrame:CGRectZero];
    _titleSubtitleStackView.translatesAutoresizingMaskIntoConstraints = NO;
    _titleSubtitleStackView.axis = UILayoutConstraintAxisVertical;
    _titleSubtitleStackView.alignment = UIStackViewAlignmentLeading;
    _titleSubtitleStackView.spacing = 4.0;
    [_stackView addArrangedSubview:_titleSubtitleStackView];
    
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    _titleLabel.numberOfLines = 0;
    _titleLabel.textColor = _titleColor;
    _titleLabel.KDI_dynamicTypeTextStyle = UIFontTextStyleBody;
    [_titleLabel setContentCompressionResistancePriority:UILayoutPriorityDefaultHigh forAxis:UILayoutConstraintAxisHorizontal];
    [_titleLabel setContentHuggingPriority:UILayoutPriorityDefaultLow forAxis:UILayoutConstraintAxisHorizontal];
    [_titleSubtitleStackView addArrangedSubview:_titleLabel];
    
    _subtitleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _subtitleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    _subtitleLabel.hidden = YES;
    _subtitleLabel.numberOfLines = 0;
    _subtitleLabel.textColor = _subtitleColor;
    _subtitleLabel.KDI_dynamicTypeTextStyle = UIFontTextStyleFootnote;
    [_subtitleLabel setContentCompressionResistancePriority:UILayoutPriorityDefaultHigh forAxis:UILayoutConstraintAxisHorizontal];
    [_subtitleLabel setContentHuggingPriority:UILayoutPriorityDefaultLow forAxis:UILayoutConstraintAxisHorizontal];
    [_titleSubtitleStackView addArrangedSubview:_subtitleLabel];
    
    _infoLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _infoLabel.translatesAutoresizingMaskIntoConstraints = NO;
    _infoLabel.hidden = YES;
    _infoLabel.textColor = _infoColor;
    _infoLabel.KDI_dynamicTypeTextStyle = UIFontTextStyleFootnote;
    [_infoLabel setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    [_infoLabel setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    [_stackView addArrangedSubview:_infoLabel];
    
    return self;
}
#pragma mark -
+ (BOOL)requiresConstraintBasedLayout {
    return YES;
}
- (void)updateConstraints {
    NSMutableArray *temp = [[NSMutableArray alloc] init];
    
    [temp addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-left-[view]-right-|" options:0 metrics:@{@"left": @(self.layoutMargins.left), @"right": @(self.accessoryType == UITableViewCellAccessoryNone ? self.layoutMargins.right : 0.0)} views:@{@"view": self.stackView}]];
    [temp addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-top-[view]-bottom-|" options:0 metrics:@{@"top": @(self.layoutMargins.top), @"bottom": @(self.layoutMargins.bottom)} views:@{@"view": self.stackView}]];
    
    self.KDI_customConstraints = temp;
    
    [super updateConstraints];
}
#pragma mark -
- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.separatorInset = UIEdgeInsetsMake(0, self.iconImageView.isHidden ? self.layoutMargins.left : CGRectGetMinX([self convertRect:self.titleLabel.bounds fromView:self.titleLabel]), 0, 0);
}
#pragma mark -
- (void)layoutMarginsDidChange {
    [super layoutMarginsDidChange];
    
    [self setNeedsUpdateConstraints];
}
#pragma mark *** Public Methods ***
#pragma mark Properties
@dynamic icon;
- (UIImage *)icon {
    return self.iconImageView.image;
}
- (void)setIcon:(UIImage *)icon {
    self.iconImageView.image = icon;
    self.iconImageView.hidden = self.iconImageView.image == nil;
}
@dynamic title;
- (NSString *)title {
    return self.titleLabel.text;
}
- (void)setTitle:(NSString *)title {
    self.titleLabel.text = title;
    self.titleLabel.hidden = self.titleLabel.text.length == 0;
}
@dynamic subtitle;
- (NSString *)subtitle {
    return self.subtitleLabel.text;
}
- (void)setSubtitle:(NSString *)subtitle {
    self.subtitleLabel.text = subtitle;
    self.subtitleLabel.hidden = self.subtitleLabel.text.length == 0;
}
@dynamic info;
- (NSString *)info {
    return self.infoLabel.text;
}
- (void)setInfo:(NSString *)info {
    self.infoLabel.text = info;
    self.infoLabel.hidden = self.infoLabel.text == 0;
}
#pragma mark -
- (void)setIconColor:(UIColor *)iconColor {
    _iconColor = iconColor;
    
    self.iconImageView.tintColor = _iconColor;
}
- (void)setTitleColor:(UIColor *)titleColor {
    _titleColor = titleColor ?: [self.class _defaultTitleColor];
    
    self.titleLabel.textColor = _titleColor;
}
- (void)setSubtitleColor:(UIColor *)subtitleColor {
    _subtitleColor = subtitleColor ?: [self.class _defaultSubtitleColor];
    
    self.subtitleLabel.textColor = _subtitleColor;
}
- (void)setInfoColor:(UIColor *)infoColor {
    _infoColor = infoColor ?: [self.class _defaultInfoColor];
    
    self.infoLabel.textColor = _infoColor;
}
#pragma mark -
- (void)setTitleTextStyle:(UIFontTextStyle)titleTextStyle {
    _titleTextStyle = titleTextStyle ?: [self.class _defaultTitleTextStyle];
    
    self.titleLabel.KDI_dynamicTypeTextStyle = _titleTextStyle;
}
- (void)setSubtitleTextStyle:(UIFontTextStyle)subtitleTextStyle {
    _subtitleTextStyle = subtitleTextStyle ?: [self.class _defaultSubtitleTextStyle];
    
    self.subtitleLabel.KDI_dynamicTypeTextStyle = _subtitleTextStyle;
}
- (void)setInfoTextStyle:(UIFontTextStyle)infoTextStyle {
    _infoTextStyle = infoTextStyle ?: [self.class _defaultInfoTextStyle];
    
    self.infoTextStyle.KDI_dynamicTypeTextStyle = _infoTextStyle;
}
#pragma mark -
@dynamic horizontalMargin;
- (CGFloat)horizontalMargin {
    return self.stackView.spacing;
}
- (void)setHorizontalMargin:(CGFloat)horizontalMargin {
    self.stackView.spacing = horizontalMargin;
}
@dynamic verticalMargin;
- (CGFloat)verticalMargin {
    return self.titleSubtitleStackView.spacing;
}
- (void)setVerticalMargin:(CGFloat)verticalMargin {
    self.titleSubtitleStackView.spacing = verticalMargin;
}
#pragma mark *** Private Methods ***
+ (UIColor *)_defaultTitleColor; {
    return UIColor.blackColor;
}
+ (UIColor *)_defaultSubtitleColor; {
    return UIColor.darkGrayColor;
}
+ (UIColor *)_defaultInfoColor; {
    return UIColor.lightGrayColor;
}
+ (UIFontTextStyle)_defaultTitleTextStyle; {
    return UIFontTextStyleBody;
}
+ (UIFontTextStyle)_defaultSubtitleTextStyle; {
    return UIFontTextStyleFootnote;
}
+ (UIFontTextStyle)_defaultInfoTextStyle; {
    return UIFontTextStyleFootnote;
}

@end
