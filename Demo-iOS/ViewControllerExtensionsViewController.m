//
//  ViewControllerExtensionsViewController.m
//  Demo-iOS
//
//  Created by William Towe on 4/10/18.
//  Copyright © 2018 Kosoku Interactive, LLC. All rights reserved.
//
//  Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
//
//  1. Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
//
//  2. Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
//
//  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

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
