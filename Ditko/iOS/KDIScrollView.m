//
//  KDIScrollView.m
//  Ditko-iOS
//
//  Created by William Towe on 11/9/17.
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

#import "KDIScrollView.h"

@interface KDIScrollView ()
- (void)_KDIScrollViewInit;
@end

@implementation KDIScrollView

- (instancetype)initWithFrame:(CGRect)frame {
    if (!(self = [super initWithFrame:frame]))
        return nil;
    
    [self _KDIScrollViewInit];
    
    return self;
}
- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (!(self = [super initWithCoder:aDecoder]))
        return nil;
    
    [self _KDIScrollViewInit];
    
    return self;
}

- (void)_KDIScrollViewInit; {
    [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(_keyboardNotification:) name:UIKeyboardWillShowNotification object:nil];
    [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(_keyboardNotification:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)_keyboardNotification:(NSNotification *)notification {
    if (!self.adjustsContentInsetForKeyboard) {
        return;
    }
    
    CGRect keyboardFrame = [self convertRect:[self.window convertRect:[notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue] fromWindow:nil] fromView:nil];
    NSTimeInterval duration = [notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    UIViewAnimationCurve curve = [notification.userInfo[UIKeyboardAnimationCurveUserInfoKey] integerValue];
    
    if ([notification.name isEqualToString:UIKeyboardWillShowNotification]) {
        [UIView animateWithDuration:duration delay:0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
            [UIView setAnimationCurve:curve];
            
            self.contentInset = UIEdgeInsetsMake(0, 0, CGRectGetHeight(CGRectIntersection(keyboardFrame, self.bounds)), 0);
        } completion:^(BOOL finished) {
            if (finished) {
                [self flashScrollIndicators];
            }
        }];
    }
    else {
        [UIView animateWithDuration:duration delay:0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
            [UIView setAnimationCurve:curve];
            
            self.contentInset = UIEdgeInsetsZero;
        } completion:^(BOOL finished) {
            if (finished) {
                [self flashScrollIndicators];
            }
        }];
    }
}

@end
