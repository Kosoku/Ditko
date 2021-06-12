//
//  DatePickerViewController.m
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

#import "DatePickerViewController.h"
#import "Constants.h"
#import "UIViewController+Extensions.h"

#import <Ditko/Ditko.h>
#import <KSOFontAwesomeExtensions/KSOFontAwesomeExtensions.h>

@interface DatePickerViewController ()
@property (weak,nonatomic) IBOutlet KDIDatePickerButton *datePickerButton;
@end

@implementation DatePickerViewController

- (NSString *)title {
    return [self.class detailViewTitle];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self KSO_addNavigationBarTitleView];
    
    self.datePickerButton.titleEdgeInsets = UIEdgeInsetsMake(0, kSubviewMargin, 0, 0);
    [self.datePickerButton setImage:[UIImage KSO_fontAwesomeSolidImageWithString:@"\uf017" size:kBarButtonItemImageSize].KDI_templateImage forState:UIControlStateNormal];
    self.datePickerButton.dateTitleBlock = ^NSString * _Nullable(__kindof KDIDatePickerButton * _Nonnull datePickerButton, NSString * _Nonnull defaultTitle) {
        return [NSString stringWithFormat:@"Due Date: %@",defaultTitle];
    };
}

+ (NSString *)detailViewTitle {
    return @"KDIDatePickerButton";
}
+ (NSString *)detailViewSubtitle {
    return @"UIButton that manages a UIDatePickerView";
}

@end
