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

#import <Stanley/KSTScopeMacros.h>

static void *kObservingContext = &kObservingContext;

@interface KDITextView ()

@property (strong,nonatomic) UILabel *placeholderLabel;

- (void)_KDITextViewInit;

+ (UIFont *)_defaultPlaceholderFont;
+ (UIColor *)_defaultPlaceholderTextColor;

@end

@implementation KDITextView

#pragma mark *** Subclass Overrides ***
- (void)dealloc {
    [self removeObserver:self forKeyPath:@kstKeypath(self,placeholderFont) context:kObservingContext];
    [self removeObserver:self forKeyPath:@kstKeypath(self,placeholderTextColor) context:kObservingContext];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

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

- (void)didAddSubview:(UIView *)subview {
    [super didAddSubview:subview];
    
    [self sendSubviewToBack:self.placeholderLabel];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat maxWidth = CGRectGetWidth(self.bounds) - self.contentInset.left - self.textContainerInset.left - self.contentInset.right - self.textContainerInset.right;
    
    [self.placeholderLabel setFrame:CGRectMake(self.contentInset.left + self.textContainerInset.left, self.contentInset.top + self.textContainerInset.top, maxWidth, ceil([self.placeholderLabel sizeThatFits:CGSizeMake(maxWidth, CGFLOAT_MAX)].height))];
}

- (CGSize)sizeThatFits:(CGSize)size {
    CGSize retval = [super sizeThatFits:size];
    
    retval.height = ceil(MAX(retval.height, [self.placeholderLabel sizeThatFits:CGSizeMake(size.width - self.contentInset.left - self.textContainerInset.left - self.textContainerInset.right - self.contentInset.right, CGFLOAT_MAX)].height));
    
    return retval;
}

- (void)setAttributedText:(NSAttributedString *)attributedText {
    [super setAttributedText:attributedText];
    
    [self.placeholderLabel setHidden:attributedText.length > 0];
}
#pragma mark NSKeyValueObserving
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if (context == kObservingContext) {
        if ([keyPath isEqualToString:@kstKeypath(self,placeholderFont)] ||
            [keyPath isEqualToString:@kstKeypath(self,placeholderTextColor)]) {
            
            [self setAttributedPlaceholder:[[NSAttributedString alloc] initWithString:self.placeholder ?: @"" attributes:@{NSFontAttributeName: self.placeholderFont, NSForegroundColorAttributeName: self.placeholderTextColor}]];
        }
    }
    else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}
#pragma mark *** Public Methods ***
#pragma mark Properties
@dynamic placeholder;
- (NSString *)placeholder {
    return self.attributedPlaceholder.string;
}
- (void)setPlaceholder:(NSString *)placeholder {
    [self setAttributedPlaceholder:[[NSAttributedString alloc] initWithString:placeholder ?: @"" attributes:@{NSFontAttributeName: self.placeholderFont, NSForegroundColorAttributeName: self.placeholderTextColor}]];
}
@dynamic attributedPlaceholder;
- (NSAttributedString *)attributedPlaceholder {
    return self.placeholderLabel.attributedText;
}
- (void)setAttributedPlaceholder:(NSAttributedString *)attributedPlaceholder {
    [self.placeholderLabel setAttributedText:attributedPlaceholder];
    
    [self setNeedsLayout];
}

- (void)setPlaceholderFont:(UIFont *)placeholderFont {
    _placeholderFont = placeholderFont ?: [self.class _defaultPlaceholderFont];
}
- (void)setPlaceholderTextColor:(UIColor *)placeholderTextColor {
    _placeholderTextColor = placeholderTextColor ?: [self.class _defaultPlaceholderTextColor];
}

#pragma mark *** Private Methods ***
- (void)_KDITextViewInit {
    _placeholderFont = [self.class _defaultPlaceholderFont];
    _placeholderTextColor = [self.class _defaultPlaceholderTextColor];
    
    [self setContentInset:UIEdgeInsetsZero];
    [self setTextContainerInset:UIEdgeInsetsZero];
    [self.textContainer setLineFragmentPadding:0];
    
    [self setPlaceholderLabel:[[UILabel alloc] initWithFrame:CGRectZero]];
    [self.placeholderLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.placeholderLabel setNumberOfLines:0];
    [self.placeholderLabel setLineBreakMode:NSLineBreakByWordWrapping];
    [self addSubview:self.placeholderLabel];
    
    [self addObserver:self forKeyPath:@kstKeypath(self,placeholderFont) options:0 context:kObservingContext];
    [self addObserver:self forKeyPath:@kstKeypath(self,placeholderTextColor) options:0 context:kObservingContext];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(_textDidChangeNotification:) name:UITextViewTextDidChangeNotification object:self];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(_textStorageDidProcessEditingNotification:) name:NSTextStorageDidProcessEditingNotification object:self.textStorage];
}

+ (UIFont *)_defaultPlaceholderFont {
    return [UIFont systemFontOfSize:17];
}
+ (UIColor *)_defaultPlaceholderTextColor {
    return [UIColor darkGrayColor];
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
