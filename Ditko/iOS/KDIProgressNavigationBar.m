//
//  KDIProgressNavigationBar.m
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

#import "KDIProgressNavigationBar.h"

#import <Stanley/KSTScopeMacros.h>

@interface KDIProgressNavigationBar ()
@property (strong,nonatomic) UIProgressView *progressView;

- (void)_KDIProgressNavigationBarInit;
@end

@implementation KDIProgressNavigationBar

#pragma mark ** Subclass Overrides **
- (instancetype)initWithFrame:(CGRect)frame {
    if (!(self = [super initWithFrame:frame]))
        return nil;
    
    [self _KDIProgressNavigationBarInit];
    
    return self;
}
- (id)initWithCoder:(NSCoder *)aDecoder {
    if (!(self = [super initWithCoder:aDecoder]))
        return nil;
    
    [self _KDIProgressNavigationBarInit];
    
    return self;
}

- (void)didAddSubview:(UIView *)subview {
    [super didAddSubview:subview];
    
    [self bringSubviewToFront:self.progressView];
}
#pragma mark ** Public Methods **
#pragma mark Properties
@dynamic progressHidden;
- (BOOL)isProgressHidden {
    return self.progressView.alpha == 0.0;
}
- (void)setProgressHidden:(BOOL)progressHidden {
    [self setProgressHidden:progressHidden animated:NO];
}
- (void)setProgressHidden:(BOOL)progressHidden animated:(BOOL)animated {
    [self willChangeValueForKey:@kstKeypath(self,progressHidden)];
    
    CGFloat const kAlpha = progressHidden ? 0.0 : 1.0;
    
    if (animated) {
        [UIView animateWithDuration:UINavigationControllerHideShowBarDuration delay:0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
            [self.progressView setAlpha:kAlpha];
        } completion:nil];
    }
    else {
        [self.progressView setAlpha:kAlpha];
    }
    
    [self didChangeValueForKey:@kstKeypath(self,progressHidden)];
}

@dynamic progress;
- (float)progress {
    return self.progressView.progress;
}
- (void)setProgress:(float)progress {
    [self setProgress:progress animated:NO];
}
- (void)setProgress:(float)progress animated:(BOOL)animated; {
    [self willChangeValueForKey:@kstKeypath(self,progress)];
    
    [self.progressView setProgress:progress animated:animated];
    
    [self didChangeValueForKey:@kstKeypath(self,progress)];
}
#pragma mark ** Private Methods **
- (void)_KDIProgressNavigationBarInit; {
    [self setProgressView:[[UIProgressView alloc] initWithFrame:CGRectZero]];
    [self.progressView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.progressView setAlpha:0.0];
    [self addSubview:self.progressView];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[view]|" options:0 metrics:nil views:@{@"view": self.progressView}]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[view]|" options:0 metrics:nil views:@{@"view": self.progressView}]];
}

@end

@implementation UINavigationController (KDIProgressNavigationBarExtensions)

- (KDIProgressNavigationBar *)KDI_progressNavigationBar; {
    return [self.navigationBar isKindOfClass:[KDIProgressNavigationBar class]] ? (KDIProgressNavigationBar *)self.navigationBar : nil;
}

@end
