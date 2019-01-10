//
//  EmptyViewController.m
//  Ditko
//
//  Created by William Towe on 4/28/17.
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
