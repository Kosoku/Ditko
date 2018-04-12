//
//  AccessoryViewController.m
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
        ((KDIWindow *)UIApplication.sharedApplication.keyWindow).accessoryViewPosition = position;
    } forControlEvents:UIControlEventValueChanged];
    
    [self.button KDI_addBlock:^(__kindof UIControl * _Nonnull control, UIControlEvents controlEvents) {
        ((KDIWindow *)UIApplication.sharedApplication.keyWindow).accessoryView = [[AccessoryView alloc] initWithFrame:CGRectZero];
    } forControlEvents:UIControlEventTouchUpInside];
}

+ (NSString *)detailViewTitle {
    return @"KDIWindow";
}
+ (NSString *)detailViewSubtitle {
    return @"Top/bottom window accessory view";
}

@end
