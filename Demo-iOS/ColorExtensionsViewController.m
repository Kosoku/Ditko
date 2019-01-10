//
//  ColorExtensionsViewController.m
//  Demo-iOS
//
//  Created by William Towe on 4/11/18.
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

#import "ColorExtensionsViewController.h"

#import <Ditko/Ditko.h>
#import <Stanley/Stanley.h>

NSNotificationName const ColorExtensionsViewControllerNotificationDidChangeNavigationBarTintColor = @"ColorExtensionsViewControllerNotificationDidChangeNavigationBarTintColor";
NSString *const ColorExtensionsViewControllerUserInfoKeyNavigationBarTintColor = @"ColorExtensionsViewControllerUserInfoKeyNavigationBarTintColor";

@interface ColorExtensionsViewController ()
@property (weak,nonatomic) IBOutlet UIButton *button;
@end

@implementation ColorExtensionsViewController

- (NSString *)title {
    return [self.class detailViewTitle];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    kstWeakify(self);
    
    void(^block)(void) = ^{
        kstStrongify(self);
        self.view.backgroundColor = KDIColorRandomRGB();
        self.button.tintColor = [self.view.backgroundColor KDI_contrastingColor];
        
        [NSNotificationCenter.defaultCenter postNotificationName:ColorExtensionsViewControllerNotificationDidChangeNavigationBarTintColor object:self userInfo:@{ColorExtensionsViewControllerUserInfoKeyNavigationBarTintColor: self.view.backgroundColor}];
    };
    
    [self.button KDI_addBlock:^(__kindof UIControl * _Nonnull control, UIControlEvents controlEvents) {
        block();
    } forControlEvents:UIControlEventTouchUpInside];
    
    block();
}
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
    [NSNotificationCenter.defaultCenter postNotificationName:ColorExtensionsViewControllerNotificationDidChangeNavigationBarTintColor object:self];
}

+ (NSString *)detailViewTitle {
    return @"UIColor+Extensions";
}
+ (NSString *)detailViewSubtitle {
    return @"UIColor additions";
}

@end
