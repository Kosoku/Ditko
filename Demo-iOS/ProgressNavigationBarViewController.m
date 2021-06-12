//
//  ProgressNavigationBarViewController.m
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

#import "ProgressNavigationBarViewController.h"
#import "UIViewController+Extensions.h"

#import <Ditko/Ditko.h>
#import <Stanley/Stanley.h>

@interface ProgressNavigationBarViewController ()
@property (weak,nonatomic) IBOutlet UIButton *button;

@property (strong,nonatomic) KSTTimer *timer;
@end

@implementation ProgressNavigationBarViewController

- (NSString *)title {
    return [self.class detailViewTitle];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    kstWeakify(self);
    
    [self KSO_addNavigationBarTitleView];
    
    [self.button KDI_addBlock:^(__kindof UIControl * _Nonnull control, UIControlEvents controlEvents) {
        kstStrongify(self);
        if (self.timer == nil) {
            self.timer = [KSTTimer scheduledTimerWithTimeInterval:1.0 block:^(KSTTimer * _Nonnull timer) {
                kstStrongify(self);
                float progress = self.navigationController.KDI_progressNavigationBar.progress;
                
                progress += 0.1;
                
                if (progress > 1.0) {
                    progress = 0.0;
                }
                
                [self.navigationController.KDI_progressNavigationBar setProgress:progress animated:YES];
            } userInfo:nil repeats:YES queue:nil];
        }
        else {
            self.timer = nil;
        }
    } forControlEvents:UIControlEventTouchUpInside];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.navigationController.KDI_progressNavigationBar.progress = 0.0;
    [self.navigationController.KDI_progressNavigationBar setProgressHidden:NO animated:animated];
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [self.navigationController.KDI_progressNavigationBar setProgressHidden:YES animated:animated];
}

+ (NSString *)detailViewTitle {
    return @"KDIProgressNavigationBar";
}
+ (NSString *)detailViewSubtitle {
    return @"UIProgressView embedded in a UINavigationBar";
}

@end
