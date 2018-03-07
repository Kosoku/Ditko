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
#import "KDIBorderedViewImpl.h"

#import <Stanley/Stanley.h>

NSNotificationName const KDITextViewNotificationDidBecomeFirstResponder = @"KDITextViewNotificationDidBecomeFirstResponder";
NSNotificationName const KDITextViewNotificationDidResignFirstResponder = @"KDITextViewNotificationDidResignFirstResponder";

@interface KDITextView ()
@property (strong,nonatomic) UILabel *placeholderLabel;

@property (strong,nonatomic) KDIBorderedViewImpl *borderedViewImpl;
@property (strong,nonatomic) UIFont *internalFont;

- (void)_KDITextViewInit;
- (void)_updatePlaceholderLabelWithText:(NSString *)text;
- (CGSize)_sizeThatFits:(CGSize)size layout:(BOOL)layout;

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
- (id)forwardingTargetForSelector:(SEL)aSelector {
    if ([self.borderedViewImpl respondsToSelector:aSelector]) {
        return self.borderedViewImpl;
    }
    return [super forwardingTargetForSelector:aSelector];
}
#pragma mark -
- (BOOL)becomeFirstResponder {
    [self willChangeValueForKey:@kstKeypath(self,isFirstResponder)];
    
    BOOL retval = [super becomeFirstResponder];
    
    [self didChangeValueForKey:@kstKeypath(self,isFirstResponder)];
    
    [self firstResponderDidChange];
    
    [NSNotificationCenter.defaultCenter postNotificationName:KDIUIResponderNotificationDidBecomeFirstResponder object:self];
    
    return retval;
}
- (BOOL)resignFirstResponder {
    [self willChangeValueForKey:@kstKeypath(self,isFirstResponder)];
    
    BOOL retval = [super resignFirstResponder];
    
    [self didChangeValueForKey:@kstKeypath(self,isFirstResponder)];
    
    [self firstResponderDidChange];
    
    [NSNotificationCenter.defaultCenter postNotificationName:KDIUIResponderNotificationDidResignFirstResponder object:self];
    
    return retval;
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
    return [self _sizeThatFits:[super intrinsicContentSize] layout:NO];
}
- (CGSize)sizeThatFits:(CGSize)size {
    return [self _sizeThatFits:size layout:NO];
}
#pragma mark -
- (void)didAddSubview:(UIView *)subview {
    [super didAddSubview:subview];
    
    [self sendSubviewToBack:self.placeholderLabel];
}
- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self _sizeThatFits:self.bounds.size layout:YES];
}
#pragma mark -
- (void)setText:(NSString *)text {
    [super setText:text];
    
//    [self invalidateIntrinsicContentSize];
    
    [self _updatePlaceholderLabelWithText:self.placeholder];
}
- (void)setAttributedText:(NSAttributedString *)attributedText {
    [super setAttributedText:attributedText];
    
//    [self invalidateIntrinsicContentSize];
    
    [self _updatePlaceholderLabelWithText:self.placeholder];
}
- (UIFont *)font {
    UIFont *retval = [super font];
    
    if (![retval isEqual:self.internalFont]) {
        retval = self.internalFont;
    }
    
    return retval;
}
- (void)setFont:(UIFont *)font {
    [self setInternalFont:font];
    
    [super setFont:self.internalFont];
    
    [self _updatePlaceholderLabelWithText:self.placeholder];
}
- (void)setTextAlignment:(NSTextAlignment)textAlignment {
    [super setTextAlignment:textAlignment];
    
    [self.placeholderLabel setTextAlignment:textAlignment];
}
#pragma mark KDIBorderedView
@dynamic borderOptions;
@dynamic borderWidth;
@dynamic borderWidthRespectsScreenScale;
@dynamic borderEdgeInsets;
@dynamic borderColor;
- (void)setBorderColor:(UIColor *)borderColor animated:(BOOL)animated {
    [self.borderedViewImpl setBorderColor:borderColor animated:animated];
}
#pragma mark KDIUIResponder
- (void)firstResponderDidChange {
    
}
#pragma mark *** Public Methods ***
#pragma mark Properties
- (void)setAllowsMultilinePlaceholder:(BOOL)allowsMultilinePlaceholder {
    _allowsMultilinePlaceholder = allowsMultilinePlaceholder;
    
    [self invalidateIntrinsicContentSize];
    
    self.placeholderLabel.numberOfLines = allowsMultilinePlaceholder ? 0 : 1;
}
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
#pragma mark -
- (void)setMinimumHeight:(CGFloat)minimumHeight {
    _minimumHeight = minimumHeight;
    
    [self invalidateIntrinsicContentSize];
}
- (void)setMaximumHeight:(CGFloat)maximumHeight {
    _maximumHeight = maximumHeight;
    
    [self invalidateIntrinsicContentSize];
}
- (void)setMinimumNumberOfLines:(NSUInteger)minimumNumberOfLines {
    _minimumNumberOfLines = minimumNumberOfLines;
    
    [self invalidateIntrinsicContentSize];
}
- (void)setMaximumNumberOfLines:(NSUInteger)maximumNumberOfLines {
    _maximumNumberOfLines = maximumNumberOfLines;
    
    [self invalidateIntrinsicContentSize];
}
#pragma mark *** Private Methods ***
- (void)_KDITextViewInit {
    _borderedViewImpl = [[KDIBorderedViewImpl alloc] initWithView:self];
    _placeholderTextColor = [self.class _defaultPlaceholderTextColor];
    _allowsMultilinePlaceholder = YES;
    
    [self setFont:[self.class _defaultFont]];
    [self setTextContainerInset:UIEdgeInsetsZero];
    [self.textContainer setLineFragmentPadding:0];
    
    [self setPlaceholderLabel:[[UILabel alloc] initWithFrame:CGRectZero]];
    [self.placeholderLabel setNumberOfLines:0];
    // if the super sets text before label is created
    [self.placeholderLabel setHidden:self.text.length > 0];
    [self addSubview:self.placeholderLabel];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(_textDidChangeNotification:) name:UITextViewTextDidChangeNotification object:self];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(_textStorageDidProcessEditingNotification:) name:NSTextStorageDidProcessEditingNotification object:nil];
}
- (void)_updatePlaceholderLabelWithText:(NSString *)text; {
    [self.placeholderLabel setHidden:self.text.length > 0];
    [self setAttributedPlaceholder:[[NSAttributedString alloc] initWithString:text ?: @"" attributes:@{NSFontAttributeName: self.font, NSForegroundColorAttributeName: self.placeholderTextColor}]];
}
- (CGSize)_sizeThatFits:(CGSize)size layout:(BOOL)layout; {
    CGSize retval = size;
    
    if (!layout) {
        if (retval.height <= 0) {
            retval.height = self.contentSize.height;
        }
        
        CGFloat placeholderHeight = [self.placeholderLabel sizeThatFits:CGSizeMake(CGRectGetWidth(self.bounds) - self.textContainerInset.left - self.textContainerInset.right, CGFLOAT_MAX)].height + self.textContainerInset.top + self.textContainerInset.bottom;
        CGFloat lineHeight = self.font.lineHeight + self.textContainerInset.top + self.textContainerInset.bottom;
        CGFloat height = MAX(MAX(retval.height, placeholderHeight), lineHeight);
        
        if (self.minimumHeight > 0) {
            height = MAX(height, self.minimumHeight);
        }
        
        if (self.minimumNumberOfLines > 0) {
            height = MAX(height, (lineHeight * self.minimumNumberOfLines) + self.textContainerInset.top + self.textContainerInset.bottom);
        }
        
        if (self.maximumHeight > 0) {
            height = MIN(height, self.maximumHeight);
        }
        
        if (self.maximumNumberOfLines > 0) {
            height = MIN(height, (lineHeight * self.maximumNumberOfLines) + self.textContainerInset.top + self.textContainerInset.bottom);
        }
        
        retval.height = ceil(height);
    }
    
    if (layout) {
        [self.borderedViewImpl layoutSubviews];
        
        CGFloat maxWidth = CGRectGetWidth(self.bounds) - self.textContainerInset.left - self.textContainerInset.right;
        
        [self.placeholderLabel setFrame:CGRectMake(self.textContainerInset.left, self.textContainerInset.top, maxWidth, [self.placeholderLabel sizeThatFits:CGSizeMake(maxWidth, CGFLOAT_MAX)].height)];
    }
    
    if (!layout) {
        KSTDispatchMainAsync(^{
            if (self.selectedRange.location == self.text.length) {
                CGRect rect = [self caretRectForPosition:self.selectedTextRange.end];
                rect.size.height += self.textContainerInset.bottom;
                
                [UIView performWithoutAnimation:^{
                    [self scrollRectToVisible:rect animated:NO];
                }];
            }
            else {
                [UIView performWithoutAnimation:^{
                    [self scrollRangeToVisible:self.selectedRange];
                }];
            }
        });
    }
    
    return retval;
}
#pragma mark -
+ (UIFont *)_defaultFont {
    return [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
}
+ (UIColor *)_defaultPlaceholderTextColor {
    return [UIColor colorWithWhite:0.7 alpha:1.0];
}
#pragma mark Properties
- (void)setInternalFont:(UIFont *)internalFont {
    _internalFont = internalFont ?: [self.class _defaultFont];
}
#pragma mark Notifications
- (void)_textDidChangeNotification:(NSNotification *)note {
    [self _updatePlaceholderLabelWithText:self.placeholder];
}
- (void)_textStorageDidProcessEditingNotification:(NSNotification *)note {
    if ([note.object isEqual:self.textStorage] &&
        self.textStorage.editedMask & NSTextStorageEditedCharacters) {
        
        [self _updatePlaceholderLabelWithText:self.placeholder];
    }
}

@end
