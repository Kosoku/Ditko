//
//  PushViewController.m
//  Ditko
//
//  Created by William Towe on 8/23/17.
//  Copyright © 2017 Kosoku Interactive, LLC. All rights reserved.
//
//  Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
//
//  1. Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
//
//  2. Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
//
//  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

#import "PushViewController.h"
#import "UIBarButtonItem+DemoExtensions.h"

#import <Ditko/Ditko.h>
#import <Stanley/Stanley.h>
#import <KSOFontAwesomeExtensions/KSOFontAwesomeExtensions.h>

@interface PushViewController ()

@end

@implementation PushViewController

- (NSString *)title {
    return [NSString stringWithFormat:@"%p",self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    kstWeakify(self);
    
    [self.view setBackgroundColor:KDIColorRandomRGB()];
    
    KDIButton *pushButton = [KDIButton buttonWithType:UIButtonTypeSystem];
    
    [pushButton setTranslatesAutoresizingMaskIntoConstraints:NO];
    [pushButton setTitle:@"Push VC" forState:UIControlStateNormal];
    [pushButton setTintColor:[self.view.backgroundColor KDI_contrastingColor]];
    [pushButton KDI_addBlock:^(__kindof UIControl * _Nonnull control, UIControlEvents controlEvents) {
        kstStrongify(self);
        [self.navigationController pushViewController:[[PushViewController alloc] init] animated:YES];
    } forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:pushButton];
    
    KDIButton *presentButton = [KDIButton buttonWithType:UIButtonTypeSystem];
    
    [presentButton setTranslatesAutoresizingMaskIntoConstraints:NO];
    [presentButton setTitle:@"Present VC" forState:UIControlStateNormal];
    [presentButton setTintColor:[self.view.backgroundColor KDI_contrastingColor]];
    [presentButton KDI_addBlock:^(__kindof UIControl * _Nonnull control, UIControlEvents controlEvents) {
        kstStrongify(self);
        [self presentViewController:[[UINavigationController alloc] initWithRootViewController:[[PushViewController alloc] init]] animated:YES completion:nil];
    } forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:presentButton];
    
    KDIButton *actionButton = [KDIButton buttonWithType:UIButtonTypeSystem];
    
    [actionButton setTranslatesAutoresizingMaskIntoConstraints:NO];
    [actionButton setTitle:@"Badge Back Button" forState:UIControlStateNormal];
    [actionButton setTintColor:pushButton.tintColor];
    [actionButton KDI_addBlock:^(__kindof UIControl * _Nonnull control, UIControlEvents controlEvents) {
        [NSNotificationCenter.defaultCenter postNotificationName:IOSDNotificationNameBadgeDidChange object:nil userInfo:@{IOSDUserInfoKeyBadge: [NSNumberFormatter localizedStringFromNumber:@(arc4random_uniform(1001)) numberStyle:NSNumberFormatterDecimalStyle]}];
    } forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:actionButton];
    
    [NSLayoutConstraint activateConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[top]-[view]" options:0 metrics:nil views:@{@"view": pushButton, @"top": self.topLayoutGuide}]];
    [NSLayoutConstraint activateConstraints:@[[NSLayoutConstraint constraintWithItem:pushButton attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0]]];
    
    [NSLayoutConstraint activateConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[subview]-[view]" options:0 metrics:nil views:@{@"view": presentButton, @"subview": pushButton}]];
    [NSLayoutConstraint activateConstraints:@[[NSLayoutConstraint constraintWithItem:presentButton attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0]]];
    
    [NSLayoutConstraint activateConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[subview]-[view]" options:0 metrics:nil views:@{@"view": actionButton, @"subview": presentButton}]];
    [NSLayoutConstraint activateConstraints:@[[NSLayoutConstraint constraintWithItem:actionButton attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0]]];
    
    [self.navigationItem setBackBarButtonItem:[UIBarButtonItem iosd_backBarButtonItemWithViewController:self]];
    
    NSMutableArray *rightItems = [[NSMutableArray alloc] init];
    
    if (self.presentingViewController != nil) {
        [self.navigationItem setLeftBarButtonItems:@[[UIBarButtonItem KDI_barButtonSystemItem:UIBarButtonSystemItemCancel block:^(__kindof UIBarButtonItem * _Nonnull barButtonItem) {
            kstStrongify(self);
            [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
        }]]];
        
        [rightItems addObject:[UIBarButtonItem KDI_barButtonSystemItem:UIBarButtonSystemItemDone block:^(__kindof UIBarButtonItem * _Nonnull barButtonItem) {
            [[UIViewController KDI_viewControllerForPresenting] KDI_recursivelyDismissViewControllerAnimated:YES completion:nil];
        }]];
    }
    
    [rightItems addObject:[UIBarButtonItem iosd_toggleWindowAccessoryViewBarButtonItem]];
    
    [self.navigationItem setRightBarButtonItems:rightItems];
}

@end
