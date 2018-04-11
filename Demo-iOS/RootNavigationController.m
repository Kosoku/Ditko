//
//  RootNavigationController.m
//  Demo-iOS
//
//  Created by William Towe on 4/9/18.
//  Copyright © 2018 Kosoku Interactive, LLC. All rights reserved.
//
//  Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
//
//  1. Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
//
//  2. Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
//
//  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

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
