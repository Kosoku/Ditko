//
//  UIView+KDIExtensions.m
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

#import "UIView+KDIExtensions.h"

#import <objc/runtime.h>

@implementation UIView (KDIExtensions)

@dynamic KDI_frameMinimumX;
- (CGFloat)KDI_frameMinimumX {
    return CGRectGetMinX(self.frame);
}
- (void)setKDI_frameMinimumX:(CGFloat)frameMinimumX {
    [self setFrame:CGRectMake(frameMinimumX, CGRectGetMinY(self.frame), CGRectGetWidth(self.frame), CGRectGetHeight(self.frame))];
}
@dynamic KDI_frameMaximumX;
- (CGFloat)KDI_frameMaximumX {
    return CGRectGetMaxX(self.frame);
}
- (void)setKDI_frameMaximumX:(CGFloat)frameMaximumX {
    [self setFrame:CGRectMake(frameMaximumX - CGRectGetWidth(self.frame), CGRectGetMinY(self.frame), CGRectGetWidth(self.frame), CGRectGetHeight(self.frame))];
}
@dynamic KDI_frameMinimumY;
- (CGFloat)KDI_frameMinimumY {
    return CGRectGetMinY(self.frame);
}
- (void)setKDI_frameMinimumY:(CGFloat)frameMinimumY {
    [self setFrame:CGRectMake(CGRectGetMinX(self.frame), frameMinimumY, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame))];
}
@dynamic KDI_frameMaximumY;
- (CGFloat)KDI_frameMaximumY {
    return CGRectGetMaxY(self.frame);
}
- (void)setKDI_frameMaximumY:(CGFloat)frameMaximumY {
    [self setFrame:CGRectMake(CGRectGetMinX(self.frame), frameMaximumY - CGRectGetHeight(self.frame), CGRectGetWidth(self.frame), CGRectGetHeight(self.frame))];
}
@dynamic KDI_frameWidth;
- (CGFloat)KDI_frameWidth {
    return CGRectGetWidth(self.frame);
}
- (void)setKDI_frameWidth:(CGFloat)KDI_frameWidth {
    [self setFrame:CGRectMake(CGRectGetMinX(self.frame), CGRectGetMinY(self.frame), KDI_frameWidth, CGRectGetHeight(self.frame))];
}
@dynamic KDI_frameHeight;
- (CGFloat)KDI_frameHeight {
    return CGRectGetHeight(self.frame);
}
- (void)setKDI_frameHeight:(CGFloat)KDI_frameHeight {
    [self setFrame:CGRectMake(CGRectGetMinX(self.frame), CGRectGetMinY(self.frame), CGRectGetWidth(self.frame), KDI_frameHeight)];
}

@dynamic KDI_borderColor;
- (UIColor *)KDI_borderColor {
    return self.layer.borderColor == nil ? nil : [UIColor colorWithCGColor:self.layer.borderColor];
}
- (void)setKDI_borderColor:(UIColor *)KDI_borderColor {
    [self.layer setBorderColor:KDI_borderColor.CGColor];
}
@dynamic KDI_borderWidth;
- (CGFloat)KDI_borderWidth {
    return self.layer.borderWidth;
}
- (void)setKDI_borderWidth:(CGFloat)KDI_borderWidth {
    [self.layer setBorderWidth:KDI_borderWidth];
}
@dynamic KDI_cornerRadius;
- (CGFloat)KDI_cornerRadius {
    return self.layer.cornerRadius;
}
- (void)setKDI_cornerRadius:(CGFloat)KDI_cornerRadius {
    [self.layer setCornerRadius:KDI_cornerRadius];
}

static void const *kKDI_customConstraintsKey = &kKDI_customConstraintsKey;

@dynamic KDI_customConstraints;
- (NSArray<NSLayoutConstraint *> *)KDI_customConstraints {
    return objc_getAssociatedObject(self, kKDI_customConstraintsKey);
}
- (void)setKDI_customConstraints:(NSArray<NSLayoutConstraint *> *)KDI_customConstraints {
    NSArray *oldCustomConstraints = self.KDI_customConstraints;
    
    if (oldCustomConstraints != nil) {
        [NSLayoutConstraint deactivateConstraints:oldCustomConstraints];
    }
    
    objc_setAssociatedObject(self, kKDI_customConstraintsKey, KDI_customConstraints, OBJC_ASSOCIATION_COPY_NONATOMIC);
    
    if (KDI_customConstraints != nil) {
        [NSLayoutConstraint activateConstraints:KDI_customConstraints];
    }
}

- (UIScrollView *)KDI_enclosingScrollView {
    UIView *view = self;
    
    while (view != nil) {
        if ([view isKindOfClass:UIScrollView.class]) {
            return (UIScrollView *)view;
        }
        
        view = view.superview;
    }
    
    return nil;
}

- (NSArray *)KDI_recursiveSubviews; {
    NSMutableOrderedSet *retval = [[NSMutableOrderedSet alloc] init];
    
    for (UIView *view in self.subviews) {
        [retval addObject:view];
        [retval addObjectsFromArray:[view KDI_recursiveSubviews]];
    }
    
    return retval.array;
}

- (UIImage *)KDI_snapshotImageAfterScreenUpdates:(BOOL)afterScreenUpdates; {
    return [self KDI_snapshotImageFromRect:self.bounds afterScreenUpdates:afterScreenUpdates];
}
- (UIImage *)KDI_snapshotImageFromRect:(CGRect)rect afterScreenUpdates:(BOOL)afterScreenUpdates; {
    UIGraphicsBeginImageContextWithOptions(rect.size, self.isOpaque, self.contentScaleFactor);
    
    [self drawViewHierarchyInRect:rect afterScreenUpdates:afterScreenUpdates];
    
    UIImage *retval = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return retval;
}

- (void)KDI_addDebugBorderWithColor:(UIColor *)color; {
#ifdef DEBUG
    self.layer.borderWidth = 1.0;
    self.layer.borderColor = color.CGColor;
#endif
}

@end
