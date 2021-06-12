//
//  EmptyViewController.m
//  Demo-iOS
//
//  Created by William Towe on 4/10/18.
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

#import "EmptyViewController.h"
#import "UIViewController+Extensions.h"

#import <Ditko/Ditko.h>
#import <Stanley/Stanley.h>
#import <KSOFontAwesomeExtensions/KSOFontAwesomeExtensions.h>

@interface EmptyViewController ()
@property (weak,nonatomic) IBOutlet KDIEmptyView *emptyView;
@end

@implementation EmptyViewController

- (NSString *)title {
    return [self.class detailViewTitle];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self KSO_addNavigationBarTitleView];
    
    self.emptyView.image = [UIImage KSO_fontAwesomeSolidImageWithString:@"\uf302" size:CGSizeMake(128, 128)].KDI_templateImage;
    self.emptyView.headline = @"Empty Headline";
    self.emptyView.body = @"Empty body with more info";
    self.emptyView.action = @"Action Prompt";
    self.emptyView.actionBlock = ^(__kindof KDIEmptyView * _Nonnull emptyView) {
        [UIAlertController KDI_presentAlertControllerWithTitle:@"Alert!" message:@"This is an alert message!" cancelButtonTitle:nil otherButtonTitles:nil completion:^(__kindof UIAlertController * _Nonnull alertController, NSInteger buttonIndex) {
            emptyView.loading = !emptyView.isLoading;
        }];
    };
}

+ (NSString *)detailViewTitle {
    return @"KDIEmptyView";
}
+ (NSString *)detailViewSubtitle {
    return @"UIView to indicate empty content";
}

@end
