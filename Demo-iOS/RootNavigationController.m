//
//  RootNavigationController.m
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

#import "RootNavigationController.h"
#import "ColorExtensionsViewController.h"

#import <Ditko/Ditko.h>

@interface RootNavigationController ()
@property (strong,nonatomic) UIColor *accessoryViewBackgroundColor;
@property (strong,nonatomic) UIColor *navigationBarTintColor;
@end

@implementation RootNavigationController

- (UIStatusBarStyle)preferredStatusBarStyle {
    if (self.accessoryViewBackgroundColor != nil) {
        return [self.accessoryViewBackgroundColor KDI_contrastingStatusBarStyle];
    }
    else if (self.navigationBarTintColor != nil) {
        return [self.navigationBarTintColor KDI_contrastingStatusBarStyle];
    }
    return [super preferredStatusBarStyle];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(_updateForAccessoryView:) name:KDIWindowNotificationDidChangeAccessoryView object:nil];
    [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(_updateForAccessoryView:) name:KDIWindowNotificationDidChangeAccessoryViewPosition object:nil];
    [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(_didChangeStatusBarStyle:) name:ColorExtensionsViewControllerNotificationDidChangeNavigationBarTintColor object:nil];
}

- (void)setAccessoryViewBackgroundColor:(UIColor *)accessoryViewBackgroundColor {
    _accessoryViewBackgroundColor = accessoryViewBackgroundColor;
    
    [self setNeedsStatusBarAppearanceUpdate];
}
- (void)setNavigationBarTintColor:(UIColor *)navigationBarTintColor {
    _navigationBarTintColor = navigationBarTintColor;
    
    self.navigationBar.barTintColor = _navigationBarTintColor;
    self.navigationBar.tintColor = _navigationBarTintColor == nil ? nil : [_navigationBarTintColor KDI_contrastingColor];
    self.navigationBar.titleTextAttributes = _navigationBarTintColor == nil ? nil : @{NSForegroundColorAttributeName: [_navigationBarTintColor KDI_contrastingColor]};
    
    [self setNeedsStatusBarAppearanceUpdate];
}

- (void)_updateForAccessoryView:(NSNotification *)note {
    KDIWindow *window = note.object;
    
    if ([note.name isEqualToString:KDIWindowNotificationDidChangeAccessoryView]) {
        self.accessoryViewBackgroundColor = window.accessoryView.backgroundColor;
    }
    else if ([note.name isEqualToString:KDIWindowNotificationDidChangeAccessoryViewPosition]) {
        self.accessoryViewBackgroundColor = window.accessoryViewPosition == KDIWindowAccessoryViewPositionTop ? window.accessoryView.backgroundColor : nil;
    }
}
- (void)_didChangeStatusBarStyle:(NSNotification *)note {
    self.navigationBarTintColor = note.userInfo[ColorExtensionsViewControllerUserInfoKeyNavigationBarTintColor];
}

@end
