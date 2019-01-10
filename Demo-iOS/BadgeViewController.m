//
//  BadgeViewController.m
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

#import "BadgeViewController.h"
#import "UIViewController+Extensions.h"

#import <Ditko/Ditko.h>
#import <Stanley/Stanley.h>
#import <KSOColorPicker/KSOColorPicker.h>

@interface BadgeViewController ()
@property (weak,nonatomic) IBOutlet KDIBadgeView *badgeView;
@property (weak,nonatomic) IBOutlet KSOColorPickerButton *foregroundColorButton;
@property (weak,nonatomic) IBOutlet KSOColorPickerButton *backgroundColorButton;
@property (weak,nonatomic) IBOutlet KDITextField *badgeTextField;
@property (weak,nonatomic) IBOutlet KDITextField *cornerRadiusTextField;
@property (weak,nonatomic) IBOutlet KDITextField *topTextField;
@property (weak,nonatomic) IBOutlet KDITextField *leftTextField;
@property (weak,nonatomic) IBOutlet KDITextField *bottomTextField;
@property (weak,nonatomic) IBOutlet KDITextField *rightTextField;
@end

@implementation BadgeViewController

- (NSString *)title {
    return [self.class detailViewTitle];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    kstWeakify(self);
    
    [self KSO_addNavigationBarTitleView];
    
    self.badgeView.badge = @"Badged!";
    self.badgeView.badgeBackgroundColor = KDIColorRandomRGB();
    self.badgeView.badgeForegroundColor = [self.badgeView.badgeBackgroundColor KDI_contrastingColor];
    
    self.badgeTextField.text = self.badgeView.badge;
    
    self.foregroundColorButton.color = self.badgeView.badgeForegroundColor;
    
    self.backgroundColorButton.color = self.badgeView.badgeBackgroundColor;
    
    [self.foregroundColorButton KDI_addBlock:^(__kindof UIControl * _Nonnull control, UIControlEvents controlEvents) {
        kstStrongify(self);
        self.badgeView.badgeForegroundColor = self.foregroundColorButton.color;
    } forControlEvents:UIControlEventValueChanged];
    
    [self.backgroundColorButton KDI_addBlock:^(__kindof UIControl * _Nonnull control, UIControlEvents controlEvents) {
        kstStrongify(self);
        self.badgeView.badgeBackgroundColor = self.backgroundColorButton.color;
    } forControlEvents:UIControlEventValueChanged];
    
    [self.badgeTextField KDI_addBlock:^(__kindof UIControl * _Nonnull control, UIControlEvents controlEvents) {
        kstStrongify(self);
        self.badgeView.badge = self.badgeTextField.text;
    } forControlEvents:UIControlEventEditingChanged];
    
    [self.cornerRadiusTextField KDI_addBlock:^(__kindof UIControl * _Nonnull control, UIControlEvents controlEvents) {
        kstStrongify(self);
        self.badgeView.badgeCornerRadius = self.cornerRadiusTextField.text.doubleValue;
    } forControlEvents:UIControlEventEditingChanged];
    
    [self.topTextField KDI_addBlock:^(__kindof UIControl * _Nonnull control, UIControlEvents controlEvents) {
        kstStrongify(self);
        UIEdgeInsets edgeInsets = self.badgeView.badgeEdgeInsets;
        
        edgeInsets.top = self.topTextField.text.doubleValue;
        
        self.badgeView.badgeEdgeInsets = edgeInsets;
    } forControlEvents:UIControlEventEditingChanged];
    
    [self.leftTextField KDI_addBlock:^(__kindof UIControl * _Nonnull control, UIControlEvents controlEvents) {
        kstStrongify(self);
        UIEdgeInsets edgeInsets = self.badgeView.badgeEdgeInsets;
        
        edgeInsets.left = self.leftTextField.text.doubleValue;
        
        self.badgeView.badgeEdgeInsets = edgeInsets;
    } forControlEvents:UIControlEventEditingChanged];
    
    [self.bottomTextField KDI_addBlock:^(__kindof UIControl * _Nonnull control, UIControlEvents controlEvents) {
        kstStrongify(self);
        UIEdgeInsets edgeInsets = self.badgeView.badgeEdgeInsets;
        
        edgeInsets.bottom = self.bottomTextField.text.doubleValue;
        
        self.badgeView.badgeEdgeInsets = edgeInsets;
    } forControlEvents:UIControlEventEditingChanged];
    
    [self.rightTextField KDI_addBlock:^(__kindof UIControl * _Nonnull control, UIControlEvents controlEvents) {
        kstStrongify(self);
        UIEdgeInsets edgeInsets = self.badgeView.badgeEdgeInsets;
        
        edgeInsets.right = self.rightTextField.text.doubleValue;
        
        self.badgeView.badgeEdgeInsets = edgeInsets;
    } forControlEvents:UIControlEventEditingChanged];
}

+ (NSString *)detailViewTitle {
    return @"KDIBadgeView";
}
+ (NSString *)detailViewSubtitle {
    return @"UIView subclass providing badging";
}

@end
