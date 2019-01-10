//
//  KDITableViewCell.m
//  Ditko
//
//  Created by William Towe on 3/4/18.
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

#import "KDITableViewCell.h"
#import "NSObject+KDIExtensions.h"
#import "UIFont+KDIDynamicTypeExtensions.h"

#import <Stanley/Stanley.h>

@interface KDITableViewCell ()
@property (strong,nonatomic) UIStackView *stackView;
@property (strong,nonatomic) UIStackView *titleSubtitleStackView;

@property (strong,nonatomic) UIImageView *iconImageView;
@property (strong,nonatomic) UILabel *titleLabel;
@property (strong,nonatomic) UILabel *subtitleLabel;
@property (strong,nonatomic) UILabel *infoLabel;

- (void)_updateAccessoryTypeForSelection;

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
    
    self.isAccessibilityElement = YES;
    
    _titleColor = [self.class _defaultTitleColor];
    _subtitleColor = [self.class _defaultSubtitleColor];
    _infoColor = [self.class _defaultInfoColor];
    _titleTextStyle = [self.class _defaultTitleTextStyle];
    _subtitleTextStyle = [self.class _defaultSubtitleTextStyle];
    _infoTextStyle = [self.class _defaultInfoTextStyle];
    
    _stackView = [[UIStackView alloc] initWithFrame:CGRectZero];
    _stackView.translatesAutoresizingMaskIntoConstraints = NO;
    _stackView.axis = UILayoutConstraintAxisHorizontal;
    _stackView.alignment = UIStackViewAlignmentCenter;
    _stackView.spacing = 8.0;
    [self.contentView addSubview:_stackView];
    
    _iconImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    _iconImageView.translatesAutoresizingMaskIntoConstraints = NO;
    _iconImageView.hidden = YES;
    _iconImageView.contentMode = UIViewContentModeScaleAspectFit;
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
    _titleLabel.KDI_dynamicTypeTextStyle = _titleTextStyle;
    [_titleLabel setContentCompressionResistancePriority:UILayoutPriorityDefaultHigh forAxis:UILayoutConstraintAxisHorizontal];
    [_titleLabel setContentHuggingPriority:UILayoutPriorityDefaultLow forAxis:UILayoutConstraintAxisHorizontal];
    [_titleSubtitleStackView addArrangedSubview:_titleLabel];
    
    _subtitleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _subtitleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    _subtitleLabel.hidden = YES;
    _subtitleLabel.numberOfLines = 0;
    _subtitleLabel.textColor = _subtitleColor;
    _subtitleLabel.KDI_dynamicTypeTextStyle = _subtitleTextStyle;
    [_subtitleLabel setContentCompressionResistancePriority:UILayoutPriorityDefaultHigh forAxis:UILayoutConstraintAxisHorizontal];
    [_subtitleLabel setContentHuggingPriority:UILayoutPriorityDefaultLow forAxis:UILayoutConstraintAxisHorizontal];
    [_titleSubtitleStackView addArrangedSubview:_subtitleLabel];
    
    _infoLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _infoLabel.translatesAutoresizingMaskIntoConstraints = NO;
    _infoLabel.hidden = YES;
    _infoLabel.textColor = _infoColor;
    _infoLabel.KDI_dynamicTypeTextStyle = _infoTextStyle;
    [_infoLabel setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    [_infoLabel setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    [_stackView addArrangedSubview:_infoLabel];
    
    return self;
}
#pragma mark -
- (NSString *)accessibilityLabel {
    NSMutableArray *retval = [[NSMutableArray alloc] init];
    
    if (!self.iconImageView.isHidden &&
        !KSTIsEmptyObject(self.iconAccessibilityLabel)) {
        
        [retval addObject:self.iconAccessibilityLabel];
    }
    if (!self.titleLabel.isHidden) {
        [retval addObject:self.titleLabel.text];
    }
    if (!self.subtitleLabel.isHidden) {
        [retval addObject:self.subtitleLabel.text];
    }
    if (self.infoLabel.superview != nil &&
        !self.infoLabel.isHidden) {
        
        [retval addObject:self.infoLabel.text];
    }
    if (self.infoView != nil &&
        !self.infoView.isHidden &&
        !KSTIsEmptyObject(self.infoView.accessibilityLabel)) {
        
        [retval addObject:self.infoView.accessibilityLabel];
    }
    
    return [retval componentsJoinedByString:@", "];
}
#pragma mark -
+ (BOOL)requiresConstraintBasedLayout {
    return YES;
}
- (void)updateConstraints {
    NSMutableArray *temp = [[NSMutableArray alloc] init];
    
    NSLayoutConstraint *minHeight = [NSLayoutConstraint constraintWithItem:self.contentView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationGreaterThanOrEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:44.0];
    
    minHeight.priority = UILayoutPriorityDefaultHigh;
    
    [temp addObject:minHeight];
    
    [temp addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-left-[view]-right-|" options:0 metrics:@{@"left": @(self.layoutMargins.left), @"right": @(self.accessoryType == UITableViewCellAccessoryNone ? self.layoutMargins.right : 0.0)} views:@{@"view": self.stackView}]];
    [temp addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-top-[view]-bottom-|" options:0 metrics:@{@"top": @(self.layoutMargins.top), @"bottom": @(self.layoutMargins.bottom)} views:@{@"view": self.stackView}]];
    
    if (self.minimumIconSize.width > 0.0) {
        [temp addObject:[NSLayoutConstraint constraintWithItem:self.iconImageView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationGreaterThanOrEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:self.minimumIconSize.width]];
    }
    if (self.minimumIconSize.height > 0.0) {
        [temp addObject:[NSLayoutConstraint constraintWithItem:self.iconImageView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationGreaterThanOrEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:self.minimumIconSize.height]];
    }
    
    if (self.maximumIconSize.width > 0.0) {
        [temp addObject:[NSLayoutConstraint constraintWithItem:self.iconImageView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationLessThanOrEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:self.maximumIconSize.width]];
    }
    if (self.maximumIconSize.height > 0.0) {
        [temp addObject:[NSLayoutConstraint constraintWithItem:self.iconImageView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationLessThanOrEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:self.maximumIconSize.height]];
    }
    
    self.KDI_customConstraints = temp;
    
    [super updateConstraints];
}
#pragma mark -
- (void)layoutSubviews {
    [super layoutSubviews];
    
#if (TARGET_OS_IOS)
    self.separatorInset = UIEdgeInsetsMake(0, self.iconImageView.isHidden ? self.layoutMargins.left : CGRectGetMinX([self convertRect:self.titleLabel.bounds fromView:self.titleLabel]), 0, 0);
#endif
}
#pragma mark -
- (void)layoutMarginsDidChange {
    [super layoutMarginsDidChange];
    
    [self setNeedsUpdateConstraints];
}
#pragma mark -
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    [self _updateAccessoryTypeForSelection];
}
- (void)setAccessoryType:(UITableViewCellAccessoryType)accessoryType {
    [super setAccessoryType:accessoryType];
    
    [self setNeedsUpdateConstraints];
}
#pragma mark *** Public Methods ***
#pragma mark Properties
- (void)setShowsSelectionUsingAccessoryType:(BOOL)showsSelectionUsingAccessoryType {
    _showsSelectionUsingAccessoryType = showsSelectionUsingAccessoryType;
    
    [self _updateAccessoryTypeForSelection];
}
#pragma mark -
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
    self.titleLabel.isAccessibilityElement = !self.titleLabel.isHidden;
}
@dynamic titleNumberOfLines;
- (NSInteger)titleNumberOfLines {
    return self.titleLabel.numberOfLines;
}
- (void)setTitleNumberOfLines:(NSInteger)titleNumberOfLines {
    self.titleLabel.numberOfLines = titleNumberOfLines;
}
@dynamic subtitle;
- (NSString *)subtitle {
    return self.subtitleLabel.text;
}
- (void)setSubtitle:(NSString *)subtitle {
    self.subtitleLabel.text = subtitle;
    self.subtitleLabel.hidden = self.subtitleLabel.text.length == 0;
    self.subtitleLabel.isAccessibilityElement = !self.subtitleLabel.isHidden;
}
@dynamic subtitleNumberOfLines;
- (NSInteger)subtitleNumberOfLines {
    return self.subtitleLabel.numberOfLines;
}
- (void)setSubtitleNumberOfLines:(NSInteger)subtitleNumberOfLines {
    self.subtitleLabel.numberOfLines = subtitleNumberOfLines;
}
@dynamic info;
- (NSString *)info {
    return self.infoLabel.text;
}
- (void)setInfo:(NSString *)info {
    self.infoLabel.text = info;
    self.infoLabel.hidden = self.infoLabel.text == 0;
    self.infoLabel.isAccessibilityElement = !self.infoLabel.isHidden;
}

- (void)setInfoView:(__kindof UIView *)infoView {
    if (_infoView == infoView) {
        return;
    }
    
    [_infoView removeFromSuperview];
    
    _infoView = infoView;
    
    if (_infoView == nil) {
        if (self.infoLabel.superview == nil) {
            [self.stackView addArrangedSubview:self.infoLabel];
        }
    }
    else {
        [self.infoLabel removeFromSuperview];
        
        [self.stackView addArrangedSubview:_infoView];
    }
    
    [self setNeedsUpdateConstraints];
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
- (void)setSelectedBackgroundViewClassName:(NSString *)selectedBackgroundViewClassName {
    _selectedBackgroundViewClassName = [selectedBackgroundViewClassName copy];
    
    if (_selectedBackgroundViewClassName) {
        NSAssert([NSClassFromString(_selectedBackgroundViewClassName) isSubclassOfClass:UIView.class], @"%@ must be a subclass of %@", NSStringFromClass(_selectedBackgroundViewClassName), NSStringFromClass(UIView.class));
    }
    
    self.selectedBackgroundView = _selectedBackgroundViewClassName ? [[NSClassFromString(_selectedBackgroundViewClassName) alloc] initWithFrame:CGRectZero] : nil;
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
- (void)setMinimumIconSize:(CGSize)minimumIconSize {
    _minimumIconSize = minimumIconSize;
    
    [self setNeedsUpdateConstraints];
}
- (void)setMaximumIconSize:(CGSize)maximumIconSize {
    _maximumIconSize = maximumIconSize;
    
    [self setNeedsUpdateConstraints];
}
#pragma mark -
@dynamic iconAccessibilityLabel;
- (NSString *)iconAccessibilityLabel {
    return self.iconImageView.accessibilityLabel;
}
- (void)setIconAccessibilityLabel:(NSString *)iconAccessibilityLabel {
    self.iconImageView.accessibilityLabel = iconAccessibilityLabel;
}
#pragma mark *** Private Methods ***
- (void)_updateAccessoryTypeForSelection; {
    if (self.showsSelectionUsingAccessoryType) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.accessoryType = self.isSelected ? UITableViewCellAccessoryCheckmark : UITableViewCellAccessoryNone;
    }
}
#pragma mark -
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
