//
//  GradientViewController.m
//  Demo-iOS
//
//  Created by William Towe on 4/9/18.
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

#import "GradientViewController.h"
#import "UIViewController+Extensions.h"

#import <Ditko/Ditko.h>

@interface GradientViewController ()
@property (weak,nonatomic) IBOutlet KDIGradientView *gradientView;
@end

@implementation GradientViewController

- (NSString *)title {
    return [self.class detailViewTitle];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self KSO_addNavigationBarTitleView];
    
    self.gradientView.colors = @[KDIColorRandomRGB(),
                                 KDIColorRandomRGB(),
                                 KDIColorRandomRGB()];
}

+ (NSString *)detailViewTitle {
    return @"KDIGradientView";
}
+ (NSString *)detailViewSubtitle {
    return @"CAGradientLayer backed view";
}

@end
