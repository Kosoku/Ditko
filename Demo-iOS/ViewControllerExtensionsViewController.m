//
//  ViewControllerExtensionsViewController.m
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

#import "ViewControllerExtensionsViewController.h"

#import <Ditko/Ditko.h>
#import <Stanley/Stanley.h>

@interface ViewControllerExtensionsViewController ()
@property (weak,nonatomic) IBOutlet UIButton *pushButton;
@property (weak,nonatomic) IBOutlet UIButton *popButton;
@property (weak,nonatomic) IBOutlet UIButton *popAllButton;
@property (weak,nonatomic) IBOutlet UIButton *presentButton;
@property (weak,nonatomic) IBOutlet UIButton *dismissButton;
@property (weak,nonatomic) IBOutlet UIButton *dismissAllButton;
@end

@implementation ViewControllerExtensionsViewController

- (NSString *)title {
    return [NSString stringWithFormat:@"%p",self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    kstWeakify(self);
    
    self.view.backgroundColor = KDIColorRandomRGB();
    self.view.tintColor = [self.view.backgroundColor KDI_contrastingColor];
    
    [self.pushButton KDI_addBlock:^(__kindof UIControl * _Nonnull control, UIControlEvents controlEvents) {
        kstStrongify(self);
        [self.navigationController KDI_pushViewController:[[ViewControllerExtensionsViewController alloc] initWithNibName:nil bundle:nil] animated:YES completion:^{
            KSTLog(@"finished pushing view controller");
        }];
    } forControlEvents:UIControlEventTouchUpInside];
    
    [self.popButton KDI_addBlock:^(__kindof UIControl * _Nonnull control, UIControlEvents controlEvents) {
        kstStrongify(self);
        [self.navigationController KDI_popViewControllerAnimated:YES completion:^{
            KSTLog(@"finished popping view controller");
        }];
    } forControlEvents:UIControlEventTouchUpInside];
    
    [self.popAllButton KDI_addBlock:^(__kindof UIControl * _Nonnull control, UIControlEvents controlEvents) {
        kstStrongify(self);
        [self.navigationController KDI_popToRootViewControllerAnimated:YES completion:^{
            KSTLog(@"finished popping all view controllers");
        }];
    } forControlEvents:UIControlEventTouchUpInside];
    
    [self.presentButton KDI_addBlock:^(__kindof UIControl * _Nonnull control, UIControlEvents controlEvents) {
        kstStrongify(self);
        [self presentViewController:[[UINavigationController alloc] initWithRootViewController:[[ViewControllerExtensionsViewController alloc] initWithNibName:nil bundle:nil]] animated:YES completion:^{
            KSTLog(@"finished presenting view controller");
        }];
    } forControlEvents:UIControlEventTouchUpInside];
    
    [self.dismissButton KDI_addBlock:^(__kindof UIControl * _Nonnull control, UIControlEvents controlEvents) {
        kstStrongify(self);
        [self.presentingViewController dismissViewControllerAnimated:YES completion:^{
            KSTLog(@"finished dismissing view controller");
        }];
    } forControlEvents:UIControlEventTouchUpInside];
    
    [self.dismissAllButton KDI_addBlock:^(__kindof UIControl * _Nonnull control, UIControlEvents controlEvents) {
        kstStrongify(self);
        [self.presentingViewController KDI_recursivelyDismissViewControllerAnimated:YES completion:^{
            KSTLog(@"finished dismissing all view controllers");
        }];
    } forControlEvents:UIControlEventTouchUpInside];
}

+ (NSString *)detailViewTitle {
    return @"UIViewController+KDIExtensions";
}
+ (NSString *)detailViewSubtitle {
    return @"UIViewController additions";
}

@end
