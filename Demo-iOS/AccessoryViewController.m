//
//  AccessoryViewController.m
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

#import "AccessoryViewController.h"
#import "AccessoryView.h"
#import "UIViewController+Extensions.h"

#import <Ditko/Ditko.h>
#import <Stanley/Stanley.h>

@interface AccessoryViewController ()
@property (weak,nonatomic) IBOutlet UISegmentedControl *segmentedControl;
@property (weak,nonatomic) IBOutlet UIButton *button;
@end

@implementation AccessoryViewController

- (NSString *)title {
    return [self.class detailViewTitle];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    kstWeakify(self);
    
    [self KSO_addNavigationBarTitleView];
    
    [self.segmentedControl KDI_addBlock:^(__kindof UIControl * _Nonnull control, UIControlEvents controlEvents) {
        kstStrongify(self);
        KDIWindowAccessoryViewPosition position = KDIWindowAccessoryViewPositionTop;
        
        if (self.segmentedControl.selectedSegmentIndex == 1) {
            position = KDIWindowAccessoryViewPositionBottom;
        }
        ((KDIWindow *)self.view.window).accessoryViewPosition = position;
    } forControlEvents:UIControlEventValueChanged];
    
    [self.button KDI_addBlock:^(__kindof UIControl * _Nonnull control, UIControlEvents controlEvents) {
        ((KDIWindow *)self.view.window).accessoryView = [[AccessoryView alloc] initWithFrame:CGRectZero];
    } forControlEvents:UIControlEventTouchUpInside];
}

+ (NSString *)detailViewTitle {
    return @"KDIWindow";
}
+ (NSString *)detailViewSubtitle {
    return @"Top/bottom window accessory view";
}

@end
