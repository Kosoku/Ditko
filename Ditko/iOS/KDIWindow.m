//
//  KDIWindow.m
//  Ditko-iOS
//
//  Created by William Towe on 11/1/17.
//  Copyright © 2018 Kosoku Interactive, LLC. All rights reserved.
//
//  Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
//
//  1. Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
//
//  2. Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
//
//  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

#import "KDIWindow.h"

#import <Stanley/Stanley.h>

NSNotificationName const KDIWindowNotificationDidChangeAccessoryView = @"KDIWindowNotificationDidChangeAccessoryView";
NSNotificationName const KDIWindowNotificationDidChangeAccessoryViewPosition = @"KDIWindowNotificationDidChangeAccessoryViewPosition";

@implementation KDIWindow

- (void)didAddSubview:(UIView *)subview {
    [super didAddSubview:subview];
    
    [self setNeedsLayout];
    [self layoutIfNeeded];
}
- (void)willRemoveSubview:(UIView *)subview {
    [super willRemoveSubview:subview];
    
    if (subview == self.accessoryView) {
        [self setNeedsLayout];
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGRect rect = self.bounds;
    
    if (self.accessoryView != nil) {
        CGFloat height = 0.0;
        
        if ([self.accessoryView.class requiresConstraintBasedLayout]) {
            height = [self.accessoryView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
        }
        else {
            height = self.accessoryView.intrinsicContentSize.height;
            
            if (height <= 0.0) {
                height = [self.accessoryView sizeThatFits:CGSizeZero].height;
            }
        }
        
        switch (self.accessoryViewPosition) {
            case KDIWindowAccessoryViewPositionTop:
                height += CGRectGetHeight(UIApplication.sharedApplication.statusBarFrame);
                
                [self.accessoryView setFrame:CGRectMake(0, 0, CGRectGetWidth(self.bounds), height)];
                
                rect = CGRectMake(0, height, CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds) - height);
                break;
            case KDIWindowAccessoryViewPositionBottom:
                [self.accessoryView setFrame:CGRectMake(0, CGRectGetHeight(self.bounds) - height, CGRectGetWidth(self.bounds), height)];
                
                rect = CGRectMake(0, 0, CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds) - height);
                break;
            default:
                break;
        }
    }
    
    for (UIView *subview in self.subviews) {
        if (subview == self.accessoryView) {
            continue;
        }
        
        [subview setFrame:rect];
    }
}

- (void)setAccessoryView:(__kindof UIView *)accessoryView {
    if (_accessoryView == accessoryView) {
        return;
    }
    
    [_accessoryView removeFromSuperview];
    
    _accessoryView = accessoryView;
    
    if (_accessoryView != nil) {
        [self addSubview:_accessoryView];
    }
    
    [NSNotificationCenter.defaultCenter postNotificationName:KDIWindowNotificationDidChangeAccessoryView object:self];
}
- (void)setAccessoryViewPosition:(KDIWindowAccessoryViewPosition)accessoryViewPosition {
    if (_accessoryViewPosition == accessoryViewPosition) {
        return;
    }
    
    _accessoryViewPosition = accessoryViewPosition;
    
    [self setNeedsLayout];
    
    [NSNotificationCenter.defaultCenter postNotificationName:KDIWindowNotificationDidChangeAccessoryViewPosition object:self];
}

@end
