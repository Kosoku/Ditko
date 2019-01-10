//
//  EmptyViewController.m
//  Demo-iOS
//
//  Created by William Towe on 4/10/18.
//  Copyright © 2019 Kosoku Interactive, LLC. All rights reserved.
//
//  Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
//
//  1. Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
//
//  2. Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
//
//  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

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
