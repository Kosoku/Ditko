//
//  KDIScrollView.m
//  Ditko-iOS
//
//  Created by William Towe on 11/9/17.
//  Copyright © 2017 Kosoku Interactive, LLC. All rights reserved.
//
//  Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
//
//  1. Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
//
//  2. Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
//
//  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

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
    [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(_keyboardNotification:) name:UIKeyboardDidShowNotification object:nil];
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
