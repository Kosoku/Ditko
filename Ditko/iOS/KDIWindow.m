//
//  KDIWindow.m
//  Ditko-iOS
//
//  Created by William Towe on 11/1/17.
//  Copyright © 2019 Kosoku Interactive, LLC. All rights reserved.
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
