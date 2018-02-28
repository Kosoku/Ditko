//
//  KDINavigationBarTitleView.m
//  Ditko-iOS
//
//  Created by William Towe on 11/7/17.
//  Copyright © 2017 Kosoku Interactive, LLC. All rights reserved.
//

#import "KDINavigationBarTitleView.h"

@interface KDINavigationBarTitleView ()
@property (strong,nonatomic) UIStackView *stackView;
@property (strong,nonatomic) UILabel *titleLabel;
@property (strong,nonatomic) UILabel *subtitleLabel;

+ (UIFont *)_defaultTitleFont;
+ (UIFont *)_defaultSubtitleFont;
+ (UIColor *)_defaultTitleTextColor;
+ (UIColor *)_defaultSubtitleTextColor;
@end

@implementation KDINavigationBarTitleView

- (instancetype)initWithFrame:(CGRect)frame {
    if (!(self = [super initWithFrame:frame]))
        return nil;
    
    self.translatesAutoresizingMaskIntoConstraints = NO;
    
    _titleFont = [self.class _defaultTitleFont];
    _subtitleFont = [self.class _defaultSubtitleFont];
    _titleTextColor = [self.class _defaultTitleTextColor];
    _subtitleTextColor = [self.class _defaultSubtitleTextColor];
    
    _stackView = [[UIStackView alloc] initWithFrame:CGRectZero];
    _stackView.translatesAutoresizingMaskIntoConstraints = NO;
    _stackView.axis = UILayoutConstraintAxisVertical;
    _stackView.alignment = UIStackViewAlignmentCenter;
    [self addSubview:_stackView];
    
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    _titleLabel.textColor = _titleTextColor;
    _titleLabel.font = _titleFont;
    [_stackView addArrangedSubview:_titleLabel];
    
    _subtitleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _subtitleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    _subtitleLabel.textColor = _subtitleTextColor;
    _subtitleLabel.font = _subtitleFont;
    [_stackView addArrangedSubview:_subtitleLabel];
    
    [NSLayoutConstraint activateConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[view]-|" options:0 metrics:nil views:@{@"view": _stackView}]];
    [NSLayoutConstraint activateConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[view]|" options:0 metrics:nil views:@{@"view": _stackView}]];
    
    return self;
}

@dynamic title;
- (NSString *)title {
    return self.titleLabel.text;
}
- (void)setTitle:(NSString *)title {
    [self.titleLabel setText:title];
    [self.titleLabel setHidden:title.length == 0];
    [self.titleLabel setIsAccessibilityElement:!self.titleLabel.isHidden];
}
@dynamic subtitle;
- (NSString *)subtitle {
    return self.subtitleLabel.text;
}
- (void)setSubtitle:(NSString *)subtitle {
    [self.subtitleLabel setText:subtitle];
    [self.subtitleLabel setHidden:subtitle.length == 0];
    [self.subtitleLabel setIsAccessibilityElement:!self.subtitleLabel.isHidden];
}

- (void)setTitleFont:(UIFont *)titleFont {
    _titleFont = titleFont ?: [self.class _defaultTitleFont];
    
    [self.titleLabel setFont:_titleFont];
}
- (void)setSubtitleFont:(UIFont *)subtitleFont {
    _subtitleFont = subtitleFont ?: [self.class _defaultSubtitleFont];
    
    [self.subtitleLabel setFont:_subtitleFont];
}
- (void)setTitleTextColor:(UIColor *)titleTextColor {
    _titleTextColor = titleTextColor ?: [self.class _defaultTitleTextColor];
    
    [self.titleLabel setTextColor:_titleTextColor];
}
- (void)setSubtitleTextColor:(UIColor *)subtitleTextColor {
    _subtitleTextColor = subtitleTextColor ?: [self.class _defaultSubtitleTextColor];
    
    [self.subtitleLabel setTextColor:_subtitleTextColor];
}

+ (UIFont *)_defaultTitleFont; {
    return UINavigationBar.appearance.titleTextAttributes[NSFontAttributeName] ?: [UIFont boldSystemFontOfSize:17.0];
}
+ (UIFont *)_defaultSubtitleFont; {
    return [UIFont systemFontOfSize:13.0];
}
+ (UIColor *)_defaultTitleTextColor; {
    return UINavigationBar.appearance.titleTextAttributes[NSForegroundColorAttributeName] ?: UIColor.blackColor;
}
+ (UIColor *)_defaultSubtitleTextColor; {
    return UIColor.darkGrayColor;
}

@end
