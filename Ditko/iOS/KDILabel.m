//
//  KDILabel.m
//  Ditko
//
//  Created by William Towe on 3/10/17.
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

#import "KDILabel.h"
#import "KDIBorderedViewImpl.h"

@interface KDILabel ()
@property (strong,nonatomic) KDIBorderedViewImpl *borderedViewImpl;
#if (TARGET_OS_IOS)
@property (strong,nonatomic) UILongPressGestureRecognizer *longPressGestureRecognizer;
#endif

- (void)_KDILabelInit;
- (CGSize)_sizeThatFits:(CGSize)size layout:(BOOL)layout;
@end

@implementation KDILabel

#pragma mark *** Subclass Overrides ***
- (instancetype)initWithFrame:(CGRect)frame {
    if (!(self = [super initWithFrame:frame]))
        return nil;
    
    [self _KDILabelInit];
    
    return self;
}
- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (!(self = [super initWithCoder:aDecoder]))
        return nil;
    
    [self _KDILabelInit];
    
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
#if (TARGET_OS_IOS)
- (BOOL)canPerformAction:(SEL)action withSender:(id)sender {
    if (action == @selector(copy:)) {
        return self.isCopyable;
    }
    return [super canPerformAction:action withSender:sender];
}
- (void)copy:(id)sender {
    if (!self.isCopyable) {
        return;
    }
    
    [UIPasteboard.generalPasteboard setString:self.text];
}

- (BOOL)canBecomeFirstResponder {
    return self.isCopyable;
}
#endif
#pragma mark -
- (CGSize)intrinsicContentSize {
    return [self _sizeThatFits:[super intrinsicContentSize] layout:NO];
}
- (CGSize)sizeThatFits:(CGSize)size {
    return [self _sizeThatFits:[super sizeThatFits:size] layout:NO];
}
#pragma mark -
- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self _sizeThatFits:self.bounds.size layout:YES];
}
#pragma mark -
- (void)drawTextInRect:(CGRect)rect {
    [super drawTextInRect:UIEdgeInsetsInsetRect(rect, self.edgeInsets)];
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
#pragma mark *** Public Methods ***
#pragma mark Properties
#if (TARGET_OS_IOS)
- (void)setCopyable:(BOOL)copyable {
    _copyable = copyable;
    
    [self setUserInteractionEnabled:_copyable];
    
    [self setLongPressGestureRecognizer:_copyable ? [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(_longPressGestureRecognizerAction:)] : nil];
}
#endif
- (void)setEdgeInsets:(UIEdgeInsets)edgeInsets {
    _edgeInsets = edgeInsets;
    
    [self setNeedsDisplay];
    [self invalidateIntrinsicContentSize];
}
#pragma mark *** Private Methods ***
- (void)_KDILabelInit; {
    _borderedViewImpl = [[KDIBorderedViewImpl alloc] initWithView:self];
}
- (CGSize)_sizeThatFits:(CGSize)size layout:(BOOL)layout {
    CGSize retval = size;
    
    retval.width += self.edgeInsets.left + self.edgeInsets.right;
    retval.height += self.edgeInsets.top + self.edgeInsets.bottom;
    
    if (layout) {
        [self.borderedViewImpl layoutSubviews];
    }
    
    return retval;
}
#if (TARGET_OS_IOS)
#pragma mark Properties
- (void)setLongPressGestureRecognizer:(UILongPressGestureRecognizer *)longPressGestureRecognizer {
    [_longPressGestureRecognizer.view removeGestureRecognizer:_longPressGestureRecognizer];
    
    _longPressGestureRecognizer = longPressGestureRecognizer;
    
    if (_longPressGestureRecognizer != nil) {
        [self addGestureRecognizer:_longPressGestureRecognizer];
    }
}
#pragma mark Actions
- (IBAction)_longPressGestureRecognizerAction:(id)sender {
    if (!UIMenuController.sharedMenuController.isMenuVisible) {
        [self becomeFirstResponder];
        
        [UIMenuController.sharedMenuController showMenuFromView:self rect:self.bounds];
    }
}
#endif

@end
