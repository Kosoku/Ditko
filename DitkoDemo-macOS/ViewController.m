//
//  ViewController.m
//  DitkoDemo-macOS
//
//  Created by William Towe on 3/8/17.
//  Copyright © 2017 Kosoku Interactive, LLC. All rights reserved.
//
//  Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
//
//  1. Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
//
//  2. Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
//
//  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

#import "ViewController.h"

#import <Ditko/Ditko.h>

@implementation ViewController

- (void)loadView {
    KDIView *view = [[KDIView alloc] initWithFrame:CGRectZero];
    
    [view setBackgroundColor:KDIColorRandomRGB()];
    [view setBorderColor:KDIColorRandomRGB()];
    [view setBorderWidth:4.0];
    [view setBorderOptions:KDIViewBorderOptionsAll];
    [view setBorderEdgeInsets:NSEdgeInsetsMake(8.0, 8.0, 8.0, 8.0)];
    
    [self setView:view];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    KDIGradientView *gradientView = [[KDIGradientView alloc] initWithFrame:CGRectZero];
    
    [gradientView setColors:@[KDIColorRandomRGB(),KDIColorRandomRGB()]];
    [gradientView setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    [self.view addSubview:gradientView];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-margin-[view]-margin-|" options:0 metrics:@{@"margin": @16.0} views:@{@"view": gradientView}]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-margin-[view]-margin-|" options:0 metrics:@{@"margin": @16.0} views:@{@"view": gradientView}]];
}

@end
