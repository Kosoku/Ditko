//
//  UIView+KDIExtensions.m
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
