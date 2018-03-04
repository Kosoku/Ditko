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
@end

@implementation KDITableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (!(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]))
        return nil;
    
    _stackView = [[UIStackView alloc] initWithFrame:CGRectZero];
    _stackView.translatesAutoresizingMaskIntoConstraints = NO;
    _stackView.axis = UILayoutConstraintAxisHorizontal;
    _stackView.alignment = UIStackViewAlignmentCenter;
    _stackView.spacing = 8.0;
    [self.contentView addSubview:_stackView];
    
    _iconImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    _iconImageView.translatesAutoresizingMaskIntoConstraints = NO;
    [_stackView addArrangedSubview:_iconImageView];
    
    _titleSubtitleStackView = [[UIStackView alloc] initWithFrame:CGRectZero];
    _titleSubtitleStackView.translatesAutoresizingMaskIntoConstraints = NO;
    _titleSubtitleStackView.axis = UILayoutConstraintAxisVertical;
    _titleSubtitleStackView.alignment = UIStackViewAlignmentLeading;
    [_stackView addArrangedSubview:_titleSubtitleStackView];
    
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    _titleLabel.numberOfLines = 0;
    _titleLabel.KDI_dynamicTypeTextStyle = UIFontTextStyleBody;
    [_titleSubtitleStackView addArrangedSubview:_titleLabel];
    
    _subtitleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _subtitleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    _subtitleLabel.numberOfLines = 0;
    _subtitleLabel.KDI_dynamicTypeTextStyle = UIFontTextStyleFootnote;
    [_titleSubtitleStackView addArrangedSubview:_subtitleLabel];
    
    _infoLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _infoLabel.translatesAutoresizingMaskIntoConstraints = NO;
    _infoLabel.KDI_dynamicTypeTextStyle = UIFontTextStyleFootnote;
    [_stackView addArrangedSubview:_infoLabel];
    
    return self;
}

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

@end
