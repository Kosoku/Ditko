//
//  ButtonViewController.m
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
@end

@implementation ButtonViewController

- (NSString *)title {
    return [self.class detailViewTitle];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    kstWeakify(self);
    
    [self KSO_addNavigationBarTitleView];
    
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
