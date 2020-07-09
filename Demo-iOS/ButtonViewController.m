//
//  ButtonViewController.m
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

#import "ButtonViewController.h"
#import "Constants.h"
#import "UIViewController+Extensions.h"

#import <Ditko/Ditko.h>
#import <Stanley/Stanley.h>
#import <KSOFontAwesomeExtensions/KSOFontAwesomeExtensions.h>

@interface ButtonViewController ()
@property (weak,nonatomic) IBOutlet KDIButton *button;
@property (weak,nonatomic) IBOutlet UISegmentedControl *segmentedControl;
@property (weak,nonatomic) IBOutlet UISwitch *invertedSwitch;
@property (weak,nonatomic) IBOutlet UISwitch *roundedSwitch;
@property (weak,nonatomic) IBOutlet UISwitch *activityIndicatorSwitch;
@property (weak,nonatomic) IBOutlet UISwitch *loadingWhenDisabledSwitch;
@property (weak,nonatomic) IBOutlet UISwitch *enabledSwitch;
@property (weak,nonatomic) IBOutlet UISwitch *borderedSwitch;
@end

@implementation ButtonViewController

- (NSString *)title {
    return [self.class detailViewTitle];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    kstWeakify(self);
    
    [self KSO_addNavigationBarTitleView];
    
    self.button.borderColorMatchesTintColor = YES;
    
    void(^block)(void) = ^{
        kstStrongify(self);
        switch (self.segmentedControl.selectedSegmentIndex) {
            case 0:
                // image left, title right
                self.button.titleContentHorizontalAlignment = KDIButtonContentHorizontalAlignmentRight;
                self.button.titleContentVerticalAlignment = KDIButtonContentVerticalAlignmentCenter;
                self.button.imageContentHorizontalAlignment = KDIButtonContentHorizontalAlignmentLeft;
                self.button.imageContentVerticalAlignment = KDIButtonContentVerticalAlignmentCenter;
                
                self.button.titleEdgeInsets = UIEdgeInsetsMake(0, kSubviewMargin, 0, 0);
                break;
            case 1:
                // image right, title left
                self.button.titleContentHorizontalAlignment = KDIButtonContentHorizontalAlignmentLeft;
                self.button.titleContentVerticalAlignment = KDIButtonContentVerticalAlignmentCenter;
                self.button.imageContentHorizontalAlignment = KDIButtonContentHorizontalAlignmentRight;
                self.button.imageContentVerticalAlignment = KDIButtonContentVerticalAlignmentCenter;
                
                self.button.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, kSubviewMargin);
                break;
            case 2:
                // image top, title bottom
                self.button.titleContentHorizontalAlignment = KDIButtonContentHorizontalAlignmentCenter;
                self.button.titleContentVerticalAlignment = KDIButtonContentVerticalAlignmentBottom;
                self.button.imageContentHorizontalAlignment = KDIButtonContentHorizontalAlignmentCenter;
                self.button.imageContentVerticalAlignment = KDIButtonContentVerticalAlignmentTop;
                
                self.button.titleEdgeInsets = UIEdgeInsetsMake(kSubviewMargin, 0, 0, 0);
                break;
            case 3:
                // image bottom, title top
                self.button.titleContentHorizontalAlignment = KDIButtonContentHorizontalAlignmentCenter;
                self.button.titleContentVerticalAlignment = KDIButtonContentVerticalAlignmentTop;
                self.button.imageContentHorizontalAlignment = KDIButtonContentHorizontalAlignmentCenter;
                self.button.imageContentVerticalAlignment = KDIButtonContentVerticalAlignmentBottom;
                
                self.button.titleEdgeInsets = UIEdgeInsetsMake(0, 0, kSubviewMargin, 0);
                break;
            default:
                break;
        }
    };
    
    [self.segmentedControl KDI_addBlock:^(__kindof UIControl * _Nonnull control, UIControlEvents controlEvents) {
        block();
    } forControlEvents:UIControlEventValueChanged];
    
    [self.invertedSwitch KDI_addBlock:^(__kindof UIControl * _Nonnull control, UIControlEvents controlEvents) {
        kstStrongify(self);
        self.button.inverted = self.invertedSwitch.isOn;
    } forControlEvents:UIControlEventValueChanged];
    
    [self.roundedSwitch KDI_addBlock:^(__kindof UIControl * _Nonnull control, UIControlEvents controlEvents) {
        kstStrongify(self);
        self.button.rounded = self.roundedSwitch.isOn;
    } forControlEvents:UIControlEventValueChanged];
    
    [self.activityIndicatorSwitch KDI_addBlock:^(__kindof UIControl * _Nonnull control, UIControlEvents controlEvents) {
        kstStrongify(self);
        self.button.loading = self.activityIndicatorSwitch.isOn;
    } forControlEvents:UIControlEventValueChanged];
    
    [self.loadingWhenDisabledSwitch KDI_addBlock:^(__kindof UIControl * _Nonnull control, UIControlEvents controlEvents) {
        kstStrongify(self);
        self.button.automaticallyTogglesLoadingWhenDisabled = self.loadingWhenDisabledSwitch.isOn;
    } forControlEvents:UIControlEventValueChanged];
    
    [self.enabledSwitch KDI_addBlock:^(__kindof UIControl * _Nonnull control, UIControlEvents controlEvents) {
        kstStrongify(self);
        self.button.enabled = self.enabledSwitch.isOn;
    } forControlEvents:UIControlEventValueChanged];
    
    [self.borderedSwitch KDI_addBlock:^(__kindof UIControl * _Nonnull control, UIControlEvents controlEvents) {
        kstStrongify(self);
        self.button.KDI_borderWidth = self.borderedSwitch.isOn ? 1.0 : 0.0;
        self.button.KDI_cornerRadius = 4.0;
    } forControlEvents:UIControlEventValueChanged];
    
    self.button.contentEdgeInsets = UIEdgeInsetsMake(kSubviewPadding, kSubviewPadding, kSubviewPadding, kSubviewPadding);
    [self.button setImage:[UIImage KSO_fontAwesomeSolidImageWithString:@"\uf433" size:kButtonImageSize].KDI_templateImage forState:UIControlStateNormal];
    
    block();
    
    self.navigationItem.rightBarButtonItems = @[[UIBarButtonItem KDI_barButtonItemWithImage:[UIImage KSO_fontAwesomeSolidImageWithString:@"\uf043" size:kBarButtonItemImageSize].KDI_templateImage style:UIBarButtonItemStylePlain block:^(__kindof UIBarButtonItem * _Nonnull barButtonItem) {
        kstStrongify(self);
        self.button.tintColor = KDIColorRandomRGB();
    }],[UIBarButtonItem KDI_barButtonItemWithImage:[UIImage KSO_fontAwesomeSolidImageWithString:@"\uf021" size:kBarButtonItemImageSize].KDI_templateImage style:UIBarButtonItemStylePlain block:^(__kindof UIBarButtonItem * _Nonnull barButtonItem) {
        kstStrongify(self);
        self.button.tintColor = nil;
    }]];
}

+ (NSString *)detailViewTitle {
    return @"KDIButton";
}
+ (NSString *)detailViewSubtitle {
    return @"UIButton with a variety of additions";
}

@end
