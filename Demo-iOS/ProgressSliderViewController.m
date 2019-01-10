//
//  ProgressSliderViewController.m
//  Demo-iOS
//
//  Created by William Towe on 4/10/18.
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

#import "ProgressSliderViewController.h"
#import "UIViewController+Extensions.h"

#import <Ditko/Ditko.h>
#import <Stanley/Stanley.h>

@interface ProgressSliderViewController ()
@property (weak,nonatomic) IBOutlet KDIProgressSlider *progressSlider;
@property (strong,nonatomic) KSTTimer *timer;
@end

@implementation ProgressSliderViewController

- (NSString *)title {
    return [self.class detailViewTitle];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    kstWeakify(self);
    
    [self KSO_addNavigationBarTitleView];
    
    self.timer = [KSTTimer scheduledTimerWithTimeInterval:1.0 block:^(KSTTimer * _Nonnull timer) {
        kstStrongify(self);
        float progress = self.progressSlider.progress;
        
        progress += 0.1;
        
        if (progress > 1.0) {
            progress = 0.0;
        }
        
        self.progressSlider.progress = progress;
    } userInfo:nil repeats:YES queue:nil];
}

+ (NSString *)detailViewTitle {
    return @"KDIProgressSlider";
}
+ (NSString *)detailViewSubtitle {
    return @"UISlider that displays loading progress";
}

@end
