//
//  KDILabel.m
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

#import "KDILabel.h"
#import "KDIBorderedViewImpl.h"

@interface KDILabel ()
@property (strong,nonatomic) KDIBorderedViewImpl *borderedViewImpl;

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

@end
