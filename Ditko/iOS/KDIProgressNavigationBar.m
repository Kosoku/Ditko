//
//  KDIProgressNavigationBar.m
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
    [subview didAddSubview:subview];
    
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
