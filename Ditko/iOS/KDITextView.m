//
//  KDITextView.m
//  Ditko
//
//  Created by William Towe on 3/10/17.
//  Copyright © 2017 Kosoku Interactive, LLC. All rights reserved.
//
//  Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
//
//  1. Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
//
//  2. Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
//
//  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

#import "KDITextView.h"

@interface KDITextView ()

@property (strong,nonatomic) UILabel *placeholderLabel;

- (void)_KDITextViewInit;
- (void)_updatePlaceholderLabelWithText:(NSString *)text;

+ (UIFont *)_defaultFont;
+ (UIColor *)_defaultPlaceholderTextColor;
@end

@implementation KDITextView
#pragma mark *** Subclass Overrides ***
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
#pragma mark -
- (instancetype)initWithFrame:(CGRect)frame textContainer:(NSTextContainer *)textContainer {
    if (!(self = [super initWithFrame:frame textContainer:textContainer]))
        return nil;
    
    [self _KDITextViewInit];
    
    return self;
}
- (id)initWithCoder:(NSCoder *)aDecoder {
    if (!(self = [super initWithCoder:aDecoder]))
        return nil;
    
    [self _KDITextViewInit];
    
    return self;
}
#pragma mark -
- (void)tintColorDidChange {
    [super tintColorDidChange];
    
    if (self.isFirstResponder) {
        // the selection highlight and caret mirror our tint color, but it won't refresh unless we do this
        [self resignFirstResponder];
        [self becomeFirstResponder];
    }
}
#pragma mark -
- (CGSize)intrinsicContentSize {
    CGSize retval = [super intrinsicContentSize];
    
    retval.height = ceil(MAX(retval.height, [self.placeholderLabel sizeThatFits:CGSizeMake(CGRectGetWidth(self.bounds) - self.textContainerInset.left - self.textContainerInset.right, CGFLOAT_MAX)].height));
    
    return retval;
}
- (CGSize)sizeThatFits:(CGSize)size {
    CGSize retval = [super sizeThatFits:size];
    
    retval.height = ceil(MAX(retval.height, [self.placeholderLabel sizeThatFits:CGSizeMake(size.width - self.textContainerInset.left - self.textContainerInset.right, CGFLOAT_MAX)].height));
    
    return retval;
}
#pragma mark -
- (void)didAddSubview:(UIView *)subview {
    [super didAddSubview:subview];
    
    [self sendSubviewToBack:self.placeholderLabel];
}
- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat maxWidth = CGRectGetWidth(self.bounds) - self.textContainerInset.left - self.textContainerInset.right;
    
    [self.placeholderLabel setFrame:CGRectMake(self.textContainerInset.left, self.textContainerInset.top, maxWidth, ceil([self.placeholderLabel sizeThatFits:CGSizeMake(maxWidth, CGFLOAT_MAX)].height))];
}
#pragma mark -
- (void)setFont:(UIFont *)font {
    [super setFont:font ?: [self.class _defaultFont]];
    
    [self _updatePlaceholderLabelWithText:self.placeholder];
}
- (void)setAttributedText:(NSAttributedString *)attributedText {
    [super setAttributedText:attributedText];
    
    [self.placeholderLabel setHidden:attributedText.length > 0];
}
#pragma mark *** Public Methods ***
#pragma mark Properties
@dynamic placeholder;
- (NSString *)placeholder {
    return self.attributedPlaceholder.string;
}
- (void)setPlaceholder:(NSString *)placeholder {
    [self _updatePlaceholderLabelWithText:placeholder];
}
@dynamic attributedPlaceholder;
- (NSAttributedString *)attributedPlaceholder {
    return self.placeholderLabel.attributedText;
}
- (void)setAttributedPlaceholder:(NSAttributedString *)attributedPlaceholder {
    [self.placeholderLabel setAttributedText:attributedPlaceholder];
    
    [self setNeedsLayout];
    [self invalidateIntrinsicContentSize];
}
@synthesize placeholderTextColor=_placeholderTextColor;
- (UIColor *)placeholderTextColor {
    return _placeholderTextColor ?: [self.class _defaultPlaceholderTextColor];
}
- (void)setPlaceholderTextColor:(UIColor *)placeholderTextColor {
    _placeholderTextColor = placeholderTextColor ?: [self.class _defaultPlaceholderTextColor];
    
    [self _updatePlaceholderLabelWithText:self.placeholder];
}
#pragma mark *** Private Methods ***
- (void)_KDITextViewInit {
    _placeholderTextColor = [self.class _defaultPlaceholderTextColor];
    
    [self setFont:[self.class _defaultFont]];
    [self setTextContainerInset:UIEdgeInsetsZero];
    [self.textContainer setLineFragmentPadding:0];
    
    [self setPlaceholderLabel:[[UILabel alloc] initWithFrame:CGRectZero]];
    [self.placeholderLabel setNumberOfLines:0];
    [self addSubview:self.placeholderLabel];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(_textDidChangeNotification:) name:UITextViewTextDidChangeNotification object:self];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(_textStorageDidProcessEditingNotification:) name:NSTextStorageDidProcessEditingNotification object:self.textStorage];
}
- (void)_updatePlaceholderLabelWithText:(NSString *)text; {
    [self setAttributedPlaceholder:[[NSAttributedString alloc] initWithString:text ?: @"" attributes:@{NSFontAttributeName: self.font, NSForegroundColorAttributeName: self.placeholderTextColor}]];
}
#pragma mark -
+ (UIFont *)_defaultFont {
    return [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
}
+ (UIColor *)_defaultPlaceholderTextColor {
    return [UIColor colorWithWhite:0.7 alpha:1.0];
}
#pragma mark Notifications
- (void)_textDidChangeNotification:(NSNotification *)note {
    [self.placeholderLabel setHidden:self.text.length > 0];
}
- (void)_textStorageDidProcessEditingNotification:(NSNotification *)note {
    if (self.textStorage.editedMask & NSTextStorageEditedCharacters) {
        [self.placeholderLabel setHidden:self.textStorage.length > 0];
    }
}

@end
