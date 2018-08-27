//
//  KDINavigationBarTitleView.m
//  Ditko-iOS
//
//  Created by William Towe on 11/7/17.
//  Copyright © 2018 Kosoku Interactive, LLC. All rights reserved.
//
//  Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
//
//  1. Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
//
//  2. Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
//
//  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

#import "KDINavigationBarTitleView.h"

@interface KDINavigationBarTitleView ()
@property (strong,nonatomic) UIStackView *stackView;
@property (strong,nonatomic) UILabel *titleLabel;
@property (strong,nonatomic) UILabel *subtitleLabel;

- (void)_updateAccessibilityLabel;

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
    self.isAccessibilityElement = YES;
    self.accessibilityTraits = UIAccessibilityTraitStaticText|UIAccessibilityTraitHeader;
    
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
    _subtitleLabel.hidden = YES;
    _subtitleLabel.isAccessibilityElement = NO;
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
    
    [self _updateAccessibilityLabel];
}
@dynamic subtitle;
- (NSString *)subtitle {
    return self.subtitleLabel.text;
}
- (void)setSubtitle:(NSString *)subtitle {
    [self.subtitleLabel setText:subtitle];
    [self.subtitleLabel setHidden:subtitle.length == 0];
    [self.subtitleLabel setIsAccessibilityElement:!self.subtitleLabel.isHidden];
    
    [self _updateAccessibilityLabel];
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

- (void)_updateAccessibilityLabel; {
    NSMutableString *retval = [[NSMutableString alloc] init];
    
    if (self.title.length > 0) {
        [retval appendString:self.title];
    }
    
    if (self.subtitle.length > 0) {
        [retval appendFormat:@"\n%@",self.subtitle];
    }
    
    self.accessibilityLabel = retval;
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
