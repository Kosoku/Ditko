//
//  KDITextView.m
//  Ditko
//
//  Created by William Towe on 3/10/17.
//  Copyright © 2018 Kosoku Interactive, LLC. All rights reserved.
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
#import "NSObject+KDIExtensions.h"

#import <Stanley/Stanley.h>

NSNotificationName const KDITextViewNotificationDidBecomeFirstResponder = @"KDITextViewNotificationDidBecomeFirstResponder";
NSNotificationName const KDITextViewNotificationDidResignFirstResponder = @"KDITextViewNotificationDidResignFirstResponder";

@interface KDITextView ()
@property (strong,nonatomic) UILabel *placeholderLabel;

@property (strong,nonatomic) KDIBorderedViewImpl *borderedViewImpl;
@property (strong,nonatomic) UIFont *internalFont;
@property (assign,nonatomic) BOOL hasSetAttributedPlaceholder;

- (void)_KDITextViewInit;
- (void)_updatePlaceholderLabelWithText:(NSString *)text;
- (void)_updatePlaceholderLabelWithAttributedText:(NSAttributedString *)attributedText;

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
- (NSString *)accessibilityLabel {
    return KSTIsEmptyObject(self.text) ? self.placeholder : self.text;
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
+ (BOOL)requiresConstraintBasedLayout {
    return YES;
}
- (void)updateConstraints {
    NSMutableArray *temp = [[NSMutableArray alloc] init];
    
    [temp addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-left-[view]-right-|" options:0 metrics:@{@"left": @(self.textContainerInset.left), @"right": @(self.textContainerInset.right)} views:@{@"view": self.placeholderLabel}]];
    [temp addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-top-[view]->=bottom-|" options:0 metrics:@{@"top": @(self.textContainerInset.top), @"bottom": @(self.textContainerInset.bottom)} views:@{@"view": self.placeholderLabel}]];
    [temp addObject:[self.placeholderLabel.widthAnchor constraintEqualToAnchor:self.widthAnchor constant:-(self.textContainerInset.left + self.textContainerInset.right)]];
    
    CGFloat minimumHeight = self.minimumHeight;
    CGFloat lineHeight = ceil(self.font.lineHeight);
    
    if (self.minimumNumberOfLines > 0) {
        minimumHeight = MAX(minimumHeight, lineHeight * (CGFloat)self.minimumNumberOfLines);
    }
    
    if (minimumHeight > 0.0) {
        [temp addObject:[self.heightAnchor constraintGreaterThanOrEqualToConstant:minimumHeight]];
    }
    
    CGFloat maximumHeight = self.maximumHeight;
    
    if (self.maximumNumberOfLines > 0) {
        maximumHeight = MAX(maximumHeight, lineHeight * (CGFloat)self.maximumNumberOfLines);
    }
    
    if (maximumHeight > 0.0) {
        [temp addObject:[self.heightAnchor constraintLessThanOrEqualToConstant:maximumHeight]];
    }
    
    self.KDI_customConstraints = temp;
    
    [super updateConstraints];
}
#pragma mark -
- (void)didAddSubview:(UIView *)subview {
    [super didAddSubview:subview];
    
    [self sendSubviewToBack:self.placeholderLabel];
}
- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self.borderedViewImpl layoutSubviews];
}
#pragma mark -
- (void)setText:(NSString *)text {
    [super setText:text];
    
    [self _updatePlaceholderLabelWithText:self.placeholder];
}
- (void)setAttributedText:(NSAttributedString *)attributedText {
    [super setAttributedText:attributedText];
    
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
- (void)setTextContainerInset:(UIEdgeInsets)textContainerInset {
    [super setTextContainerInset:textContainerInset];
    
    [self invalidateIntrinsicContentSize];
    [self setNeedsUpdateConstraints];
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
    
    self.placeholderLabel.numberOfLines = allowsMultilinePlaceholder ? 0 : 1;
    
    [self invalidateIntrinsicContentSize];
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
    self.hasSetAttributedPlaceholder = !KSTIsEmptyObject(attributedPlaceholder);
    
    [self.placeholderLabel setAttributedText:attributedPlaceholder];
    
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
    [self setNeedsUpdateConstraints];
}
- (void)setMaximumHeight:(CGFloat)maximumHeight {
    _maximumHeight = maximumHeight;
    
    [self invalidateIntrinsicContentSize];
    [self setNeedsUpdateConstraints];
}
- (void)setMinimumNumberOfLines:(NSUInteger)minimumNumberOfLines {
    _minimumNumberOfLines = minimumNumberOfLines;
    
    [self invalidateIntrinsicContentSize];
    [self setNeedsUpdateConstraints];
}
- (void)setMaximumNumberOfLines:(NSUInteger)maximumNumberOfLines {
    _maximumNumberOfLines = maximumNumberOfLines;
    
    [self invalidateIntrinsicContentSize];
    [self setNeedsUpdateConstraints];
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
    [self.placeholderLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.placeholderLabel setNumberOfLines:0];
    // if the super sets text before label is created
    [self.placeholderLabel setHidden:self.text.length > 0];
    [self.placeholderLabel setIsAccessibilityElement:NO];
    [self addSubview:self.placeholderLabel];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(_textDidChangeNotification:) name:UITextViewTextDidChangeNotification object:self];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(_textStorageDidProcessEditingNotification:) name:NSTextStorageDidProcessEditingNotification object:nil];
}
- (void)_updatePlaceholderLabelWithText:(NSString *)text; {
    [self _updatePlaceholderLabelWithAttributedText:[[NSAttributedString alloc] initWithString:text ?: @"" attributes:@{NSFontAttributeName: self.font, NSForegroundColorAttributeName: self.placeholderTextColor}]];
}
- (void)_updatePlaceholderLabelWithAttributedText:(NSAttributedString *)attributedText; {
    self.placeholderLabel.hidden = !KSTIsEmptyObject(self.text);
    
    if (self.hasSetAttributedPlaceholder) {
        return;
    }

    self.attributedPlaceholder = attributedText;
    
    self.hasSetAttributedPlaceholder = NO;
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
