//
//  EmptyViewController.m
//  Ditko
//
//  Created by William Towe on 4/28/17.
//  Copyright © 2017 Kosoku Interactive, LLC. All rights reserved.
//
//  Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
//
//  1. Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
//
//  2. Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
//
//  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

#import "EmptyViewController.h"

#import <Ditko/Ditko.h>
#import <KSOFontAwesomeExtensions/KSOFontAwesomeExtensions.h>

@interface EmptyViewController ()

@end

@implementation EmptyViewController

- (NSString *)title {
    return @"Empty";
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view setBackgroundColor:UIColor.whiteColor];
    
    KDIEmptyView *emptyView = [[KDIEmptyView alloc] initWithFrame:CGRectZero];
    
    [emptyView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [emptyView setBackgroundColor:UIColor.whiteColor];
    [emptyView setImage:[UIImage KSO_fontAwesomeImageWithString:@"\uf080" size:CGSizeMake(128, 128)]];
    [emptyView setHeadline:@"Headline Text"];
    [emptyView setBody:@"Body text that should wrap to multiple lines and do something nifty"];
    [emptyView setAction:@"Action Button Text"];
    [emptyView setActionBlock:^(__kindof KDIEmptyView * _Nonnull emptyView) {
        [UIAlertController KDI_presentAlertControllerWithError:nil];
    }];
    
    [self.view addSubview:emptyView];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[view]|" options:0 metrics:nil views:@{@"view": emptyView}]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[top][view][bottom]" options:0 metrics:nil views:@{@"view": emptyView, @"top": self.topLayoutGuide, @"bottom": self.bottomLayoutGuide}]];
}

@end
