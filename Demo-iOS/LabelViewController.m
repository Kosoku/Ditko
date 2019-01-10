//
//  LabelViewController.m
//  Demo-iOS
//
//  Created by William Towe on 4/9/18.
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

#import "LabelViewController.h"
#import "UISegmentedControl+Extensions.h"
#import "UIViewController+Extensions.h"

#import <Ditko/Ditko.h>
#import <Stanley/Stanley.h>

@interface LabelViewController ()
@property (weak,nonatomic) IBOutlet UISegmentedControl *segmentedControl;
@property (weak,nonatomic) IBOutlet UITextField *textField;
@property (weak,nonatomic) IBOutlet KDILabel *label;
@end

@implementation LabelViewController

- (NSString *)title {
    return [self.class detailViewTitle];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    kstWeakify(self);
    
    [self KSO_addNavigationBarTitleView];
    
    self.textField.text = [self.label.borderColor KDI_hexadecimalString];
    
    [self.segmentedControl KSO_configureForBorderedViews:@[self.label]];
    
    [self.textField KDI_addBlock:^(__kindof UIControl * _Nonnull control, UIControlEvents controlEvents) {
        kstStrongify(self);
        self.label.borderColor = KDIColorHexadecimal(self.textField.text);
    } forControlEvents:UIControlEventEditingChanged];
    
    self.label.copyable = YES;
    self.label.borderWidth = 1.0;
    self.label.borderOptions = KDIBorderOptionsBottom;
}

+ (NSString *)detailViewTitle {
    return @"KDILabel";
}
+ (NSString *)detailViewSubtitle {
    return @"Bordered, copyable label (long press)";
}

@end
