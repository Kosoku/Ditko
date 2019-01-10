//
//  ProgressNavigationBarViewController.m
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
